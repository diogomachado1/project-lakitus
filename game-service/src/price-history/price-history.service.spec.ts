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

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        PriceHistoryService,
        {
          useValue: PriceHistoryRepository,
          provide: 'PRICE_HISTORY_REPOSITORY',
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
