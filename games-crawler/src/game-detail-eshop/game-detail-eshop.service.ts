import { Inject, Injectable } from '@nestjs/common';
import {
  GameEU,
  GameJP,
  parseGameCode,
  parseNSUID,
} from 'nintendo-switch-eshop';
import { EshopService } from '../eshop/eshop.service';
import { GameRepositoryService } from '../game-repository/game-repository.service';
@Injectable()
export class GameDetailEshopService {
  constructor(
    @Inject('GAME_REPOSITORY') private repository: GameRepositoryService,
    @Inject('ESHOP_SERVICE') private eshopService: EshopService,
  ) {}

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
      await this.repository.saveGameDetail(gameToSave);
    } else {
      const gameToSave = {
        usEshopId: usId,
        euEshopId: euId,
      };
      await this.repository.saveGameDetail(gameToSave);
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
