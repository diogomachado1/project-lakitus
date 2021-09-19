import { Inject, Injectable } from '@nestjs/common';
import { GameUS } from 'nintendo-switch-eshop';

export interface GameRepositoryUsEshopService {
  saveGameDetailUS: (gameDetail: {
    usEshopDetail: GameUS;
    usEshopId: string;
  }) => Promise<void>;
}

export interface EshopServiceUsEshopService {
  findGameByUsId: (id: string) => Promise<GameUS | undefined>;
}
@Injectable()
export class GameDetailUsEshopService {
  constructor(
    @Inject('GAME_REPOSITORY') private repository: GameRepositoryUsEshopService,
    @Inject('ESHOP_SERVICE') private eshopService: EshopServiceUsEshopService,
  ) {}

  async getAndSaveGameData(id: string) {
    const usEshopData = await this.eshopService.findGameByUsId(id);
    if (usEshopData) {
      await this.repository.saveGameDetailUS({
        usEshopDetail: usEshopData,
        usEshopId: id,
      });
    }
  }
}
