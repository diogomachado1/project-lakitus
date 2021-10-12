import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { PriceHistory, PriceHistoryDocument } from './priceHistory.schema';

@Injectable()
export class PriceHistoryRepositoryService {
  constructor(
    @InjectModel(PriceHistory.name)
    private priceHistoryModel: Model<PriceHistoryDocument>,
  ) {}

  async savePriceHistories(pricesFormated: PriceHistory[]) {
    await this.priceHistoryModel.insertMany(pricesFormated);
  }

  async getPriceHistoryByGameId(gameId: string) {
    return this.priceHistoryModel.find({ gameId }).lean();
  }
}
