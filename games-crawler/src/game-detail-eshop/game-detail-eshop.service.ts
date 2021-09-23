import { Inject, Injectable } from '@nestjs/common';
import { GameJP, parseGameCode, parseNSUID } from 'nintendo-switch-eshop';
import { EshopService } from '../eshop/eshop.service';
import { GameRepositoryService } from '../game-repository/game-repository.service';
@Injectable()
export class GameDetailEshopService {
  constructor(
    @Inject('GAME_REPOSITORY') private repository: GameRepositoryService,
    @Inject('ESHOP_SERVICE') private eshopService: EshopService,
  ) {}

  async getAndSaveGameData(usId: string, euId: string) {
    console.log('start');
    const [usEshopData, euEshopData] = await Promise.all([
      this.getUsGameDetail(usId),
      this.getEuGameDetail(euId),
    ]);
    console.log('us and eu');
    console.log(usEshopData);
    if (usEshopData) {
      const codeGame = parseGameCode(euEshopData, 2);
      console.log('get jp e hk');

      const [jpEshopDetail, hkEshopDetail] = await Promise.all([
        this.getJpGameDetail(codeGame),
        this.getHkGameDetail(codeGame),
      ]);
      const jpEshopId = jpEshopDetail && parseNSUID(jpEshopDetail, 3);
      const hkEshopId =
        hkEshopDetail &&
        parseNSUID({ LinkURL: hkEshopDetail.link } as GameJP, 3);
      console.log('init save');

      await this.repository.saveGameDetail({
        euEshopDetail: euEshopData,
        usEshopDetail: usEshopData,
        jpEshopDetail,
        hkEshopDetail,
        usEshopId: usId,
        euEshopId: euId,
        jpEshopId,
        hkEshopId,
      });
      console.log('saved');

      console.log(
        JSON.stringify({
          status: 'success',
          usEshopId: usId,
          euEshopId: euId,
          jpEshopId,
          hkEshopId,
        }),
      );
    } else {
      throw new Error('not found');
    }
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
