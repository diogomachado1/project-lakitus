import { Inject, Injectable } from '@nestjs/common';

import { EshopService } from '../eshop/eshop.service';
import { PriceRepositoryService } from '../price-repository/price-repository.service';
@Injectable()
export class PriceEshopService {
  constructor(
    @Inject('PRICE_REPOSITORY') private repository: PriceRepositoryService,
    @Inject('ESHOP_SERVICE') private eshopService: EshopService,
  ) {}

  async getAndSavePriceData(
    gamesIds: { _id: string; externalId: string }[],
    country: string,
  ) {
    const prices = await this.eshopService.getPrices(
      gamesIds.map((item) => item.externalId),
      country,
    );
    const pricesFormated = prices.prices.map((item) => ({
      country,
      gameId: gamesIds.find(
        (game) => game.externalId === item.title_id.toString(),
      )._id,
      salesStatus: item.sales_status,
      regularPrice: item.regular_price && {
        amount: item.regular_price.amount,
        currency: item.regular_price.currency,
        rawValue: item.regular_price.raw_value,
        startDatetime: item.regular_price.start_datetime,
        endDatetime: item.regular_price.end_datetime,
      },
      discountPrice: item.discount_price && {
        amount: item.discount_price.amount,
        currency: item.discount_price.currency,
        rawValue: item.discount_price.raw_value,
        startDatetime: item.discount_price.start_datetime,
        endDatetime: item.discount_price.end_datetime,
      },
    }));
    await this.repository.deletePrices(
      gamesIds.map((item) => item._id),
      country,
    );
    await this.repository.savePrices(pricesFormated);
  }
}
