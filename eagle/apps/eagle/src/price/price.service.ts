import { Inject, Injectable } from '@nestjs/common';
import { GameRepositoryService } from '../infra/game-repository/game-repository.service';
import { Game } from '../infra/game-repository/game.schema';
import { RabbitService } from '../infra/rabbit/rabbit.service';

import { EshopService } from '../infra/eshop/eshop.service';
import { PriceRepositoryService } from '../infra/price-repository/price-repository.service';
import { countries } from '../infra/countries';
@Injectable()
export class PriceService {
  constructor(
    @Inject('PRICE_REPOSITORY') private repository: PriceRepositoryService,
    @Inject('ESHOP_SERVICE') private eshopService: EshopService,
    @Inject('GAME_REPOSITORY') private gameRepository: GameRepositoryService,
    @Inject('RABBIT_SERVICE') private rabbitService: RabbitService,
  ) {}

  protected idFieldByRegionCode = {
    '1': 'usEshopId',
    '2': 'euEshopId',
    '3': 'jpEshopId',
    '4': 'hkEshopId',
  };

  async getAndSavePriceData(
    games: {
      _id: string;
      usEshopId: string;
      euEshopId: string;
      jpEshopId: string;
      hkEshopId: string;
    }[],
  ) {
    const prices = [];
    for (const country of countries) {
      const gamesInThisRegion = games.reduce(
        (acc, game) =>
          game[this.idFieldByRegionCode[country.region]]
            ? [...acc, game[this.idFieldByRegionCode[country.region]]]
            : acc,
        [] as string[],
      );
      if (gamesInThisRegion.length) {
        const reponse = await this.eshopService.getPrices(
          gamesInThisRegion,
          country.code,
        );
        const pricesFormated = reponse.prices.map((item) => ({
          country: country.code,
          gameId: games.find(
            (game) =>
              game[this.idFieldByRegionCode[country.region]] ===
              item.title_id.toString(),
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
        prices.push(...pricesFormated);
      }
    }

    const gameIds = games.map((item) => item._id);

    const oldPrices = await this.repository.getPriceByGameIds(gameIds);

    await this.repository.deletePrices(gameIds);
    await this.repository.savePrices(prices);

    await this.rabbitService.sendBatchToGameUpdated(
      games.map((item) => ({
        gameId: item._id,
        oldPrice: oldPrices
          .filter((price) => price.gameId === item._id)
          .reduce(
            (acc, price) => ({
              ...acc,
              [price.country]:
                price.salesStatus !== 'not_found'
                  ? price?.discountPrice?.rawValue ||
                    price?.regularPrice?.rawValue ||
                    null
                  : null,
            }),
            {},
          ),
      })),
    );
  }

  async getPriceHistoryMessages() {
    const games = await this.gameRepository.getAllIds();

    await this.rabbitService.sendBatchToGamePriceHistory(
      games.map((item) => ({ gameId: item._id })),
    );
    return { status: 'success' };
  }

  async getPriceMessages() {
    const games = await this.gameRepository.getAllEshopIds();

    const priceMessages = this.chunkGameArray(games);

    await this.rabbitService.sendBatchToGamePrice(priceMessages);
    return { status: 'success' };
  }

  protected chunkGameArray(gamesArray: any[]) {
    const perChunk = 50;

    return gamesArray.reduce((resultArray, item, index) => {
      const chunkIndex = Math.floor(index / perChunk);
      if (!resultArray[chunkIndex]) {
        resultArray[chunkIndex] = [];
      }
      resultArray[chunkIndex].push(item);
      return resultArray;
    }, []) as any[][];
  }

  protected verifyRegion(game: Game, region: number) {
    return !!game[this.idFieldByRegionCode[region]];
  }
}
