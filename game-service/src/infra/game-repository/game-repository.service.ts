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

  async findOneGame(id: string) {
    return this.gameModel.findById(id).populate('prices').lean();
  }

  async findGames(
    { ids, search }: { ids?: string[]; search?: string },
    page = 1,
  ) {
    const searchRegex = new RegExp(search, 'i');
    const filter =
      search || ids
        ? search
          ? {
              $or: [
                { 'euEshopDetail.title': searchRegex },
                { 'usEshopDetail.title': searchRegex },
              ],
            }
          : { _id: { $in: ids } }
        : {};
    return this.gameModel
      .find(
        filter,
        '_id usEshopDetail euEshopDetail usEshopId euEshopId hkEshopId jpEshopId createdAt updatedAt',
      )
      .limit(20)
      .skip(20 * (page - 1))
      .lean();
  }
}
