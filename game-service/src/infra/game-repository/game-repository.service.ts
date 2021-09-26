import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Game, GameDocument } from './game.schema';

@Injectable()
export class GameRepositoryService {
  constructor(@InjectModel(Game.name) private gameModel: Model<GameDocument>) {}

  async getAllUsId() {
    return this.gameModel.find({}, 'usEshopId').lean();
  }

  async getAllEshopIds() {
    return this.gameModel
      .find({}, ['usEshopId', 'euEshopId', 'hkEshopId', 'jpEshopId', '_id'])
      .lean();
  }
}
