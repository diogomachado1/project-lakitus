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

  async findPriceHistory(gameId: string, countryFilter: string) {
    const country =
      countryFilter === 'all' ? undefined : countryFilter.toUpperCase();
    return this.priceHistoryModel.find({ gameId, country }).lean();
  }
}
