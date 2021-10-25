import { CACHE_MANAGER, Inject, Injectable, Logger } from '@nestjs/common';
import { differenceInDays, format, startOfDay, subDays } from 'date-fns';
import { PriceHistory } from '../infra/game-history-repository/priceHistory.schema';
import { PriceHistoryRepositoryService } from '../infra/game-history-repository/price-history-repository.service';
import { Cache } from 'cache-manager';
import { PriceRepositoryService } from '../infra/price-repository/price-repository.service';
import { countries } from '../infra/countries';

@Injectable()
export class PriceHistoryService {
  private readonly priceHistoryLogger = new Logger('price-history');

  constructor(
    @Inject(CACHE_MANAGER) private cacheManager: Cache,
    @Inject('PRICE_REPOSITORY') private priceRepository: PriceRepositoryService,
    @Inject('PRICE_HISTORY_REPOSITORY')
    private repository: PriceHistoryRepositoryService,
  ) {}

  async getPriceHistoryByGameIdAndCountry(gameId: string, country = 'all') {
    const cached = await this.cacheManager.get<any[]>(
      `price-history:${gameId}:${country}`,
    );
    if (cached) return cached;
    const pricesChanges = await this.repository.findPriceHistory(
      gameId,
      country,
    );
    const pricesChangesByCountry = pricesChanges.reduce((acc, item) => {
      return {
        ...acc,
        [item.country]: [
          ...(acc[item.country] || []),
          { ...item, date: startOfDay(item.date) },
        ],
      };
    }, {} as { [x: string]: PriceHistory[] });

    const pricesCompleted = Object.keys(pricesChangesByCountry).reduce(
      (acc, item) => [
        ...acc,
        ...this.getCompletedPriceHistory(pricesChangesByCountry[item]),
      ],
      [] as {
        value: number;
        date: string;
        country: string;
      }[],
    );

    const groupByDate = pricesCompleted.reduce(
      (acc, item) => ({
        ...acc,
        [item.date]: acc[item.date]
          ? {
              prices: [
                ...acc[item.date].prices,
                { country: item.country, value: item.value },
              ],
              date: item.date,
            }
          : {
              prices: [{ country: item.country, value: item.value }],
              date: item.date,
            },
      }),
      {},
    );

    const flatHistory = Object.keys(groupByDate).reduce(
      (acc, item) => [...acc, groupByDate[item]],
      [],
    );

    await this.cacheManager.set(
      `price-history:${gameId}:${country}`,
      flatHistory,
      { ttl: 60 * 5 },
    );

    return flatHistory;
  }

  getCompletedPriceHistory(priceHistory: PriceHistory[]) {
    const priceHistorySorted = priceHistory.sort(
      (a, b) => Number(b.date) - Number(a.date),
    );
    let point = startOfDay(new Date());
    const priceHistoryByDay: {
      value: number;
      date: string;
      country: string;
    }[] = [];
    for (const priceChange of priceHistorySorted) {
      const days = differenceInDays(point, priceChange.date);
      for (let i = 0; i <= days; i++) {
        priceHistoryByDay.push({
          value: priceChange.newPrice,
          date: format(subDays(point, i), 'yyyy-MM-dd'),
          country: priceChange.country,
        });
      }
      point = subDays(priceChange.date, 1);
    }
    return priceHistoryByDay;
  }

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
