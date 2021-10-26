import { Model } from 'mongoose';
import { getModelToken } from '@nestjs/mongoose';
import { Test, TestingModule } from '@nestjs/testing';
import { PriceHistoryController } from './price-history.controller';
import { PriceHistoryService } from './price-history.service';
import { CacheModule } from '@nestjs/common';
import { InfraModule } from '@infra/infra';
import {
  PriceHistory,
  PriceHistoryDocument,
} from '@infra/infra/game-history-repository/priceHistory.schema';
import { getPriceHistory } from './mocks/price-history';
import { format, subDays } from 'date-fns';

describe('PriceHistoryController', () => {
  let controller: PriceHistoryController;
  let model: Model<PriceHistoryDocument>;
  const gameId = '614be0065c60a0ac3c5ba781';
  const RefDate = new Date();

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [InfraModule, CacheModule.register()],
      controllers: [PriceHistoryController],
      providers: [PriceHistoryService],
    }).compile();

    controller = module.get<PriceHistoryController>(PriceHistoryController);
    model = module.get<Model<PriceHistoryDocument>>(
      getModelToken(PriceHistory.name),
    );
  });

  afterAll(async () => {
    await model.deleteMany({});
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should getMany', async () => {
    await model.insertMany(getPriceHistory(RefDate));

    const prices = await controller.getOnePriceHistory(gameId, {});

    expect(prices).toStrictEqual(
      [
        {
          prices: [
            { country: 'BR', value: 31.99 },
            { country: 'US', value: 29 },
          ],
        },
        {
          prices: [
            { country: 'BR', value: 31.99 },
            { country: 'US', value: 29 },
          ],
        },
        {
          prices: [
            { country: 'BR', value: 31.99 },
            { country: 'US', value: 29 },
          ],
        },
        {
          prices: [
            { country: 'BR', value: 50 },
            { country: 'US', value: 29 },
          ],
        },
        {
          prices: [
            { country: 'BR', value: 50 },
            { country: 'US', value: 29 },
          ],
        },
        {
          prices: [
            { country: 'BR', value: 50 },
            { country: 'US', value: 29 },
          ],
        },
        {
          prices: [
            { country: 'BR', value: 99 },
            { country: 'US', value: 29 },
          ],
        },
        {
          prices: [
            { country: 'BR', value: 99 },
            { country: 'US', value: 12 },
          ],
        },
        {
          prices: [
            { country: 'BR', value: 99 },
            { country: 'US', value: 12 },
          ],
        },
        {
          prices: [
            { country: 'BR', value: 99 },
            { country: 'US', value: 12 },
          ],
        },
        {
          prices: [
            { country: 'BR', value: 99 },
            { country: 'US', value: 29 },
          ],
        },
        {
          prices: [
            { country: 'BR', value: 99 },
            { country: 'US', value: 29 },
          ],
        },
        { prices: [{ country: 'US', value: 29 }] },
        { prices: [{ country: 'US', value: 29 }] },
        { prices: [{ country: 'US', value: 29 }] },
        { prices: [{ country: 'US', value: 49 }] },
        { prices: [{ country: 'US', value: 49 }] },
      ].map((item, index) => ({
        ...item,
        date: format(subDays(RefDate, index), 'yyyy-MM-dd'),
      })),
    );
  });
});
