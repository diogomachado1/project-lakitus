import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Price, PriceDocument } from './price.schema';

@Injectable()
export class PriceRepositoryService {
  constructor(
    @InjectModel(Price.name) private gameModel: Model<PriceDocument>,
  ) {}

  async deletePrices(gamesIds: string[], country: string) {
    await this.gameModel.deleteMany({ gameId: { $in: gamesIds }, country });
  }

  async savePrices(pricesFormated: Price[]) {
    await this.gameModel.insertMany(pricesFormated);
  }

  async getPriceByGameId(gameId: string) {
    return this.gameModel.find({ gameId }).lean();
  }
}
