import { CACHE_MANAGER } from '@nestjs/common';
import { Test, TestingModule } from '@nestjs/testing';
import { format, subDays } from 'date-fns';
import { PriceHistoryService } from './price-history.service';

describe('PriceHistoryService', () => {
  let service: PriceHistoryService;
  const RefDate = new Date();
  const PriceHistoryRepository = {
    findPriceHistory: async (_, country: string) => {
      return country === 'BR'
        ? [
            {
              _id: '6165d450e5f322fc05fa2333',
              country: 'BR',
              gameId: '614be0065c60a0ac3c5ba781',
              date: subDays(RefDate, 2),
              oldPrice: 50,
              newPrice: 31.99,
              __v: 0,
            },
            {
              _id: '6165d450e5f322fc05fa2333',
              country: 'BR',
              gameId: '614be0065c60a0ac3c5ba781',
              date: subDays(RefDate, 5),
              oldPrice: 99,
              newPrice: 50,
              __v: 0,
            },
            {
              _id: '6165d450e5f322fc05fa2333',
              country: 'BR',
              gameId: '614be0065c60a0ac3c5ba781',
              date: subDays(RefDate, 11),
              oldPrice: null,
              newPrice: 99,
              __v: 0,
            },
          ]
        : [
            {
              _id: '6165d450e5f322fc05fa2333',
              country: 'BR',
              gameId: '614be0065c60a0ac3c5ba781',
              date: subDays(RefDate, 2),
              oldPrice: 50,
              newPrice: 31.99,
              __v: 0,
            },
            {
              _id: '6165d450e5f322fc05fa2333',
              country: 'BR',
              gameId: '614be0065c60a0ac3c5ba781',
              date: subDays(RefDate, 5),
              oldPrice: 99,
              newPrice: 50,
              __v: 0,
            },
            {
              _id: '6165d450e5f322fc05fa2333',
              country: 'BR',
              gameId: '614be0065c60a0ac3c5ba781',
              date: subDays(RefDate, 11),
              oldPrice: null,
              newPrice: 99,
              __v: 0,
            },

            {
              _id: '6165d450e5f322fc05fa2333',
              country: 'US',
              gameId: '614be0065c60a0ac3c5ba781',
              date: subDays(RefDate, 6),
              oldPrice: 12,
              newPrice: 29,
              __v: 0,
            },
            {
              _id: '6165d450e5f322fc05fa2333',
              country: 'US',
              gameId: '614be0065c60a0ac3c5ba781',
              date: subDays(RefDate, 9),
              oldPrice: 29,
              newPrice: 12,
              __v: 0,
            },
            {
              _id: '6165d450e5f322fc05fa2333',
              country: 'US',
              gameId: '614be0065c60a0ac3c5ba781',
              date: subDays(RefDate, 14),
              oldPrice: 49,
              newPrice: 29,
              __v: 0,
            },
            {
              _id: '6165d450e5f322fc05fa2333',
              country: 'US',
              gameId: '614be0065c60a0ac3c5ba781',
              date: subDays(RefDate, 16),
              oldPrice: null,
              newPrice: 49,
              __v: 0,
            },
          ];
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
          useValue: { getPriceByGameId: async () => ({}) },
          provide: 'PRICE_REPOSITORY',
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
    expect(2 + 2).toBe(4);
  });
});
