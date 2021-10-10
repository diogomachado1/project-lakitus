import { Inject, Injectable } from '@nestjs/common';
import { GameRepositoryService } from '../infra/game-repository/game-repository.service';
import { Game } from '../infra/game-repository/game.schema';
import { RabbitService } from '../infra/rabbit/rabbit.service';

import { EshopService } from '../eshop/eshop.service';
import { PriceRepositoryService } from '../infra/price-repository/price-repository.service';
import { contries } from './contries';
import { S3Service } from 'src/infra/s3/s3.service';

@Injectable()
export class PriceEshopService {
  constructor(
    @Inject('PRICE_REPOSITORY') private repository: PriceRepositoryService,
    @Inject('ESHOP_SERVICE') private eshopService: EshopService,
    @Inject('GAME_REPOSITORY') private gameRepository: GameRepositoryService,
    @Inject('RABBIT_SERVICE') private rabbitService: RabbitService,
    @Inject('S3_SERVICE') private s3Service: S3Service,
  ) {}

  protected idFieldByRegionCode = {
    '1': 'usEshopId',
    '2': 'euEshopId',
    '3': 'jpEshopId',
    '4': 'hkEshopId',
  };

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

  async saveHistoryPrice(gameId: string) {
    const prices = await this.repository.getPriceByGameId(gameId);
    const datas = prices.reduce(
      (acc, item) => ({
        ...acc,
        [item.country]: Number(
          item?.discountPrice?.rawValue || item?.regularPrice?.rawValue,
        ),
      }),
      {},
    );

    const newPriceDate = prices.reduce(
      (acc, item) =>
        Number(item.createdAt) > Number(acc) ? item.createdAt : acc,
      new Date(1),
    );

    await this.s3Service.append(
      { prices: datas, date: newPriceDate },
      `prices-history/${gameId}`,
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
    const contriesWithGames = contries.map((item) => ({ ...item, games: [] }));
    const games = await this.gameRepository.getAllEshopIds();
    games.forEach((game) => {
      contriesWithGames.forEach((country, index) => {
        if (this.verifyRegion(game, country.region))
          contriesWithGames[index].games.push({
            externalId: game[this.idFieldByRegionCode[country.region]],
            _id: game._id,
          });
      });
    });

    const priceMessages = contriesWithGames.reduce(
      (acc, item) => [
        ...acc,
        ...this.chunkGameArray(item.games).map((gamesIds) => ({
          ...item,
          games: gamesIds,
        })),
      ],
      [],
    );

    await this.rabbitService.sendBatchToGamePrice(priceMessages);
    return { status: 'success' };
  }

  protected chunkGameArray(gamesArray: string[]) {
    const perChunk = 50;

    return gamesArray.reduce((resultArray, item, index) => {
      const chunkIndex = Math.floor(index / perChunk);
      if (!resultArray[chunkIndex]) {
        resultArray[chunkIndex] = [];
      }
      resultArray[chunkIndex].push(item);
      return resultArray;
    }, []) as string[][];
  }

  protected verifyRegion(game: Game, region: number) {
    return !!game[this.idFieldByRegionCode[region]];
  }
}
