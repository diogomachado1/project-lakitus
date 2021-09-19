import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { GameUS } from 'nintendo-switch-eshop';
import { GameRepositoryUsEshopService } from 'src/game-detail-us-eshop/game-detail-us-eshop.service';
import { Game, GameDocument } from './game.schema';

@Injectable()
export class GameRepositoryService implements GameRepositoryUsEshopService {
  constructor(@InjectModel(Game.name) private gameModel: Model<GameDocument>) {}

  async saveGameDetailUS({
    usEshopDetail,
    usEshopId,
  }: {
    usEshopDetail: GameUS;
    usEshopId: string;
  }) {
    await this.gameModel.findOneAndUpdate(
      { usEshopId: usEshopId },
      { usEshopDetail, usEshopId },
      { upsert: true },
    );
  }
}
