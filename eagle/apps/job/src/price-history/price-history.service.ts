import { Inject, Injectable, Logger } from '@nestjs/common';
import { PriceHistoryRepositoryService } from '@infra/infra/game-history-repository/price-history-repository.service';
import { PriceRepositoryService } from '@infra/infra/price-repository/price-repository.service';
import { countries } from '@infra/infra/countries';

@Injectable()
export class PriceHistoryService {
  private readonly priceHistoryLogger = new Logger('price-history');

  constructor(
    @Inject('PRICE_REPOSITORY') private priceRepository: PriceRepositoryService,
    @Inject('PRICE_HISTORY_REPOSITORY')
    private repository: PriceHistoryRepositoryService,
  ) {}

  async saveHistoryPrice(
    gameId: string,
    oldPrice: { [x: string]: number | null },
  ) {
    const prices = await this.priceRepository.getPriceByGameId(gameId);
    const datas = prices.reduce(
      (acc, item) => ({
        ...acc,
        [item.country]:
          item.salesStatus !== 'not_found'
            ? item?.discountPrice?.rawValue ||
              item?.regularPrice?.rawValue ||
              null
            : null,
      }),
      {},
    );

    const changedCountryPrice = countries.filter(
      (item) => (oldPrice[item.code] || null) !== (datas[item.code] || null),
    );

    const changedPrices = changedCountryPrice.map((item) => ({
      newPrice: datas[item.code] ? Number(datas[item.code]) : null,
      oldPrice: oldPrice[item.code] ? Number(oldPrice[item.code]) : null,
      date: new Date(),
      gameId: gameId,
      country: item.code,
    }));

    changedPrices.forEach((item) =>
      this.priceHistoryLogger.log(
        `price history created: ${JSON.stringify(item)}`,
      ),
    );

    await this.repository.savePriceHistories(changedPrices);
  }
}
