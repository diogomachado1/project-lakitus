import { Inject, Injectable } from '@nestjs/common';
import { GameRepositoryService } from '@infra/infra/game-repository/game-repository.service';
import {
  GameEU,
  GameJP,
  GameUS,
  parseGameCode,
  parseNSUID,
} from 'nintendo-switch-eshop';
import { EshopService, GameHk } from '@infra/infra/eshop/eshop.service';
import { NsgService } from '@infra/infra/nsg/nsg.service';
import { NsgGame } from '@infra/infra/nsg/interfaces/NsgGame';
import { Game } from '@infra/infra/game-repository/game.schema';
import { SonicService } from '@infra/infra/sonic/sonic.service';

@Injectable()
export class GameService {
  constructor(
    @Inject('GAME_REPOSITORY') private gameRepository: GameRepositoryService,
    @Inject('ESHOP_SERVICE') private eshopService: EshopService,
    @Inject('NSG_SERVICE') private nsgService: NsgService,
    @Inject('SONIC_SERVICE') private sonicService: SonicService,
  ) {}

  async gameIndex() {
    const totalGames = await this.gameRepository.getTotalGames();
    const pages = Math.ceil(totalGames / 500);
    for (let index = 1; index <= pages; index++) {
      const games = await this.gameRepository.getGamesPagination(index);
      console.log(games.length, index);
      await Promise.all(
        games.map((game) => this.sonicService.saveGameDetail(game)),
      );
    }
  }

  async verifyNewNintendoGame() {
    const [usGames, euGames, jpGames, hkGames, nsgGame] = await Promise.all([
      this.getNewGamesByRegion<GameUS>('us'),
      this.getNewGamesByRegion<GameEU>('eu'),
      this.getNewGamesByRegion<GameJP>('jp'),
      this.getNewGamesByRegion<GameHk>('hk'),
      this.nsgService.getGames(),
    ]);
    const newUsGames = usGames.map((item) =>
      this.getUsGameData(item, euGames, jpGames, hkGames, nsgGame),
    );
    const euGamesFiltered = this.getNewArray<GameEU>(
      newUsGames,
      euGames,
      'euEshopId',
      (item) => parseNSUID(item, 2),
    );
    const newEuGames = euGamesFiltered.map((item) =>
      this.getEuGameData(item, jpGames, hkGames),
    );
    const jpGamesFiltered = this.getNewArray<GameJP>(
      newEuGames,
      jpGames,
      'jpEshopId',
      (item) => parseNSUID(item, 3),
    );
    const newJpGames = jpGamesFiltered.map((item) => this.getJpGameData(item));
    const hkGamesFiltered = this.getNewArray<GameHk>(
      newEuGames,
      hkGames,
      'hkEshopId',
      (item) => parseNSUID({ LinkURL: item.link } as GameJP, 3),
    );
    const newHkGames = hkGamesFiltered.map((item) => this.getHkGameData(item));

    const response = [
      ...newUsGames,
      ...newEuGames,
      ...newJpGames,
      ...newHkGames,
    ];

    await this.gameRepository.saveAllGameDetail(
      response.map((item) => ({
        ...item,
        platform: 'nintendo',
        active: false,
      })),
    );

    return response;
  }

  protected getNewArray<T>(
    gamesFinded: Partial<Game>[],
    gamesTotal: T[],
    key: string,
    handleGetNsuid: (item: T) => string,
  ) {
    const euGamesIdFindInUsGames = gamesFinded.reduce(
      (acc, item) => (item[key] ? [...acc, item[key]] : acc),
      [],
    );
    const filtered = gamesTotal.filter(
      (item) => !euGamesIdFindInUsGames.includes(handleGetNsuid(item)),
    );

    return filtered;
  }

  async getNewGamesByRegion<T>(region: 'us' | 'eu' | 'jp' | 'hk') {
    const regionIdFieldAndFuntion = {
      us: { field: 'usEshopId', handle: 'getGamesUs' },
      eu: { field: 'euEshopId', handle: 'getGamesEu' },
      jp: { field: 'jpEshopId', handle: 'getGamesJp' },
      hk: { field: 'hkEshopId', handle: 'getGamesHk' },
    };
    const field = regionIdFieldAndFuntion[region].field;
    const savedNintendoGamesByRegion = (
      await this.gameRepository.findByExternalId<{ [x: string]: string }>(field)
    ).map((item) => item[field]);

    const games = (await this.eshopService[
      regionIdFieldAndFuntion[region].handle
    ]()) as unknown as (T & {
      nintendoId: string;
    })[];

    const filtered = games.filter(
      (item) =>
        !savedNintendoGamesByRegion.includes(item.nintendoId) &&
        item.nintendoId,
    ) as T[];
    return filtered;
  }

  getUsGameData(
    game: GameUS,
    newEuGames: GameEU[],
    newJpGames: GameJP[],
    newHkGames: GameHk[],
    nsgGames: NsgGame[],
  ) {
    const nsgGame = nsgGames.find(
      (item) => item.nsuid_na.toString() === game.nsuid,
    );
    const euGame =
      nsgGame &&
      newEuGames.find(
        (item) => nsgGame?.nsuid_eu?.toString() === parseNSUID(item, 2),
      );
    const euGameData =
      euGame && this.getEuGameData(euGame, newJpGames, newHkGames);
    return { usEshopId: game.nsuid, usEshopDetail: game, ...euGameData };
  }

  getEuGameData(game: GameEU, newJpGames: GameJP[], newHkGames: GameHk[]) {
    const codeGame = parseGameCode(game, 2);

    const jpGame = this.eshopService.findGameByJpId(codeGame, newJpGames);
    const jpGameData = jpGame && this.getJpGameData(jpGame);
    const hkGame = this.eshopService.findGameByHkId(codeGame, newHkGames);
    const hkGameData = hkGame && this.getHkGameData(hkGame);
    return {
      euEshopId: parseNSUID(game, 2),
      euEshopDetail: game,
      ...jpGameData,
      ...hkGameData,
    };
  }

  getJpGameData(game: GameJP) {
    return {
      jpEshopId: parseNSUID(game, 3),
      jpEshopDetail: game,
    };
  }

  getHkGameData(game: GameHk) {
    return {
      hkEshopId: game && parseNSUID({ LinkURL: game.link } as GameJP, 3),
      hkEshopDetail: game,
    };
  }
}
