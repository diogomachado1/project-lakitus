import { Inject, Injectable } from '@nestjs/common';
import { Game } from 'src/infra/game-repository/game.schema';
import { NsgService } from 'src/infra/nsg/nsg.service';
import { RabbitService } from 'src/infra/rabbit/rabbit.service';
import { GameRepositoryService } from '../infra/game-repository/game-repository.service';
import { contries } from './contries';
import { NsgGame } from './interfaces/NsgGame';

@Injectable()
export class ProducerGameDetailService {
  constructor(
    @Inject('GAME_REPOSITORY') private gameRepository: GameRepositoryService,
    @Inject('NSG_SERVICE') private nsgServices: NsgService,
    @Inject('RABBIT_SERVICE') private RabbitService: RabbitService,
  ) {}

  protected idFieldByRegionCode = {
    '1': 'usEshopId',
    '2': 'euEshopId',
    '3': 'jpEshopId',
    '4': 'hkEshopId',
  };

  async sendGamesMessage(sendAll = false) {
    const [nsgGames, savedGamesUsId] = await Promise.all([
      this.nsgServices.getGames(),
      this.gameRepository.getAllUsId(),
    ]);

    const gamesIds = sendAll
      ? this.getAllGames(nsgGames)
      : this.getNewGames(nsgGames, savedGamesUsId);

    await this.RabbitService.sendBatchToGameDetail(gamesIds);
    return gamesIds;
  }
  protected getNewGames(
    nsgGames: NsgGame[],
    savedGamesUsId: { usEshopId: string }[],
  ) {
    const usIdHashTable = this.createHatableUsIdEshop(savedGamesUsId);
    return nsgGames
      .filter((item) => !usIdHashTable.includes(item.nsuid_na.toString()))
      .map((item) => ({ usId: item.nsuid_na, euId: item.nsuid_eu }));
  }

  protected getAllGames(nsgGames: NsgGame[]) {
    return nsgGames.map((item) => ({
      usId: item.nsuid_na,
      euId: item.nsuid_eu,
    }));
  }

  protected createHatableUsIdEshop(savedGamesUsId: { usEshopId: string }[]) {
    return savedGamesUsId.map((item) => item.usEshopId.toString());
  }

  async getPriceMessages() {
    const contriesWithGames = contries.map((item) => ({ ...item, games: [] }));
    const games = await this.gameRepository.getAllEshopIds();
    games.forEach((game) => {
      contriesWithGames.forEach((country, index) => {
        if (this.verifyRegion(game, country.region))
          contriesWithGames[index].games.push({
            externalId: game[this.idFieldByRegionCode[country.region]],
            _id: game._id,
          });
      });
    });

    const priceMessages = contriesWithGames.reduce(
      (acc, item) => [
        ...acc,
        ...this.chunkGameArray(item.games).map((gamesIds) => ({
          ...item,
          games: gamesIds,
        })),
      ],
      [],
    );

    await this.RabbitService.sendBatchToGamePrice(priceMessages);
    return { status: 'success' };
  }

  protected chunkGameArray(gamesArray: string[]) {
    const perChunk = 50;

    return gamesArray.reduce((resultArray, item, index) => {
      const chunkIndex = Math.floor(index / perChunk);
      if (!resultArray[chunkIndex]) {
        resultArray[chunkIndex] = [];
      }
      resultArray[chunkIndex].push(item);
      return resultArray;
    }, []) as string[][];
  }

  protected verifyRegion(game: Game, region: number) {
    return !!game[this.idFieldByRegionCode[region]];
  }
}
