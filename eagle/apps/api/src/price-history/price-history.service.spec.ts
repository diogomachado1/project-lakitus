import { CACHE_MANAGER } from '@nestjs/common';
import { Test, TestingModule } from '@nestjs/testing';
import { format, subDays } from 'date-fns';
import { getPriceHistory } from './mocks/price-history';
import { PriceHistoryService } from './price-history.service';

describe('PriceHistoryService', () => {
  let service: PriceHistoryService;
  const RefDate = new Date();
  const PriceHistoryRepository = {
    findPriceHistory: async (_, country: string) => {
      return getPriceHistory(RefDate, country);
    },
  };

  const cache = {
    get: async () => undefined,
    set: async () => undefined,
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        PriceHistoryService,
        {
          useValue: PriceHistoryRepository,
          provide: 'PRICE_HISTORY_REPOSITORY',
        },
        {
          useValue: cache,
          provide: CACHE_MANAGER,
        },
      ],
    }).compile();

    service = module.get<PriceHistoryService>(PriceHistoryService);
  });

  it('should get price-history one country', async () => {
    const newGames = await service.getPriceHistoryByGameIdAndCountry(
      '6165d450e5f322fc05fa2333',
      'BR',
    );

    expect(newGames).toStrictEqual(
      [
        { prices: [{ country: 'BR', value: 31.99 }] },
        { prices: [{ country: 'BR', value: 31.99 }] },
        { prices: [{ country: 'BR', value: 31.99 }] },
        { prices: [{ country: 'BR', value: 50 }] },
        { prices: [{ country: 'BR', value: 50 }] },
        { prices: [{ country: 'BR', value: 50 }] },
        { prices: [{ country: 'BR', value: 99 }] },
        { prices: [{ country: 'BR', value: 99 }] },
        { prices: [{ country: 'BR', value: 99 }] },
        { prices: [{ country: 'BR', value: 99 }] },
        { prices: [{ country: 'BR', value: 99 }] },
        { prices: [{ country: 'BR', value: 99 }] },
      ].map((item, index) => ({
        ...item,
        date: format(subDays(RefDate, index), 'yyyy-MM-dd'),
      })),
    );
  });

  it('should get price-history many country', async () => {
    const newGames = await service.getPriceHistoryByGameIdAndCountry(
      '6165d450e5f322fc05fa2333',
    );
    expect(newGames).toStrictEqual(
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
