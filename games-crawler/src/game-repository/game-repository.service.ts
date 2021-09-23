import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { GameEU, GameJP, GameUS } from 'nintendo-switch-eshop';
import { GameHk } from 'src/eshop/eshop.service';
import { Game, GameDocument } from './game.schema';

@Injectable()
export class GameRepositoryService {
  constructor(@InjectModel(Game.name) private gameModel: Model<GameDocument>) {}

  async saveGameDetail({
    euEshopDetail,
    usEshopDetail,
    jpEshopDetail,
    hkEshopDetail,
    usEshopId,
    euEshopId,
    jpEshopId,
    hkEshopId,
  }: {
    euEshopDetail?: GameEU;
    usEshopDetail?: GameUS;
    jpEshopDetail?: GameJP;
    hkEshopDetail?: GameHk;
    usEshopId: string;
    euEshopId?: string;
    jpEshopId?: string;
    hkEshopId?: string;
  }) {
    await this.gameModel.findOneAndUpdate(
      { usEshopId: usEshopId },
      {
        euEshopDetail,
        usEshopDetail,
        hkEshopDetail,
        jpEshopDetail,
        euEshopId,
        usEshopId,
        jpEshopId,
        hkEshopId,
      },
      { upsert: true },
    );
  }
}
