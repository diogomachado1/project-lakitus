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
import { Document, LeanDocument } from 'mongoose';
import { Game } from '../infra/game-repository/game.schema';
import { SimpleDetail } from '../infra/game-repository/SimpleDetail';

@Injectable()
export class GameService {
  constructor(
    @Inject(CACHE_MANAGER) private cacheManager: Cache,
    @Inject('GAME_REPOSITORY') private gameRepository: GameRepositoryService,
    @Inject('ESHOP_SERVICE') private eshopService: EshopService,
  ) {}

  async getOneGame(id: string) {
    const cached = await this.cacheManager.get<SimpleDetail>(`game:${id}`);
    if (cached) return cached;
    const game = await this.gameRepository.findOneGameSimple(id);
    await this.cacheManager.set(`game:${id}`, game, { ttl: 60 * 5 });
    return game;
  }

  async getOneGameFull(id: string) {
    const cached = await this.cacheManager.get<
      LeanDocument<
        Game &
          Document<any, any, any> & {
            _id: any;
          }
      >
    >(`game-full:${id}`);
    if (cached) return cached;
    const game = await this.gameRepository.findOneGame(id);
    await this.cacheManager.set(`game-full:${id}`, game, { ttl: 60 * 5 });
    return game;
  }

  async getManyGame(ids?: string[], search?: string, page?: number) {
    return this.gameRepository.findGamesSimpleDetail({ ids, search }, page);
  }

  async getManyGameFull(ids?: string[], search?: string, page?: number) {
    return this.gameRepository.findGames({ ids, search }, page);
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

  async tryGetJPandHKDetail(euEshopData?: GameEU) {
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
