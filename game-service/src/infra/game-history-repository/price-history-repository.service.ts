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

  async findPriceHistory(gameId: string, country: string) {
    const filter =
      country === 'all'
        ? { gameId }
        : { gameId, country: country.toUpperCase() };
    const prices = this.priceHistoryModel.find(filter).lean();

    return prices;
  }
}
