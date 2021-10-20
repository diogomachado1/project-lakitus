import { CACHE_MANAGER, Inject, Injectable } from '@nestjs/common';
import { GameRepositoryService } from '../infra/game-repository/game-repository.service';
import {
  GameEU,
  GameJP,
  parseGameCode,
  parseNSUID,
} from 'nintendo-switch-eshop';
import { EshopService } from '../infra/eshop/eshop.service';
import { Cache } from 'cache-manager';

@Injectable()
export class GameService {
  constructor(
    @Inject(CACHE_MANAGER) private cacheManager: Cache,
    @Inject('GAME_REPOSITORY') private gameRepository: GameRepositoryService,
    @Inject('ESHOP_SERVICE') private eshopService: EshopService,
  ) {}

  async getOneGame(id: string, fullDetail: boolean) {
    const cached = await this.cacheManager.get<any[]>(
      `game:${id}:${fullDetail ? 'true' : 'false'}`,
    );
    if (cached) return cached;
    const game = this.gameRepository.findOneGame(id, fullDetail);
    await this.cacheManager.set(
      `game:${id}:${fullDetail ? 'true' : 'false'}`,
      game,
      { ttl: 60 * 5 },
    );
    return game;
  }

  async getManyGame(
    ids: string[],
    search: string,
    page: number,
    fullDetail: boolean,
  ) {
    return this.gameRepository.findGames({ ids, search }, page, fullDetail);
  }

  async getAndSaveGameData(usId: string, euId: string) {
    const [usEshopData, euEshopData] = await Promise.all([
      this.getUsGameDetail(usId),
      this.getEuGameDetail(euId),
    ]);

    if (usEshopData || euEshopData) {
      const jpAndHkDetail = await this.tryGetJPandHKDetail(euEshopData);

      const gameToSave = {
        euEshopDetail: euEshopData,
        usEshopDetail: usEshopData,
        jpEshopDetail: jpAndHkDetail?.jpEshopDetail,
        hkEshopDetail: jpAndHkDetail?.hkEshopDetail,
        usEshopId: usId,
        euEshopId: euId,
        jpEshopId: jpAndHkDetail?.jpEshopId,
        hkEshopId: jpAndHkDetail?.hkEshopId,
      };
      await this.gameRepository.saveGameDetail(gameToSave);
    } else {
      const gameToSave = {
        usEshopId: usId,
        euEshopId: euId,
      };
      await this.gameRepository.saveGameDetail(gameToSave);
    }
  }

  async tryGetJPandHKDetail(euEshopData: GameEU) {
    if (euEshopData) {
      const codeGame = parseGameCode(euEshopData, 2);

      const [jpEshopDetail, hkEshopDetail] = await Promise.all([
        this.getJpGameDetail(codeGame),
        this.getHkGameDetail(codeGame),
      ]);
      const jpEshopId = jpEshopDetail && parseNSUID(jpEshopDetail, 3);
      const hkEshopId =
        hkEshopDetail &&
        parseNSUID({ LinkURL: hkEshopDetail.link } as GameJP, 3);
      return {
        jpEshopDetail,
        hkEshopDetail,
        jpEshopId,
        hkEshopId,
      };
    }
    return undefined;
  }

  async getUsGameDetail(id: string) {
    return this.eshopService.findGameByUsId(id);
  }

  async getEuGameDetail(euId: string) {
    return this.eshopService.findGameByEuId(euId);
  }

  async getJpGameDetail(euProductCode: string) {
    return this.eshopService.findGameByJpId(euProductCode);
  }

  async getHkGameDetail(euProductCode: string) {
    return this.eshopService.findGameByHkId(euProductCode);
  }
}
