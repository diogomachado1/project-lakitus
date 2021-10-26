import { subDays } from 'date-fns';

export const getPriceHistory = (refDate: Date, country = 'all') => {
  return [
    {
      country: 'BR',
      gameId: '614be0065c60a0ac3c5ba781',
      date: subDays(refDate, 2),
      oldPrice: 50,
      newPrice: 31.99,
      __v: 0,
    },
    {
      country: 'BR',
      gameId: '614be0065c60a0ac3c5ba781',
      date: subDays(refDate, 5),
      oldPrice: 99,
      newPrice: 50,
      __v: 0,
    },
    {
      country: 'BR',
      gameId: '614be0065c60a0ac3c5ba781',
      date: subDays(refDate, 11),
      oldPrice: null,
      newPrice: 99,
      __v: 0,
    },

    {
      country: 'US',
      gameId: '614be0065c60a0ac3c5ba781',
      date: subDays(refDate, 6),
      oldPrice: 12,
      newPrice: 29,
      __v: 0,
    },
    {
      country: 'US',
      gameId: '614be0065c60a0ac3c5ba781',
      date: subDays(refDate, 9),
      oldPrice: 29,
      newPrice: 12,
      __v: 0,
    },
    {
      country: 'US',
      gameId: '614be0065c60a0ac3c5ba781',
      date: subDays(refDate, 14),
      oldPrice: 49,
      newPrice: 29,
      __v: 0,
    },
    {
      country: 'US',
      gameId: '614be0065c60a0ac3c5ba781',
      date: subDays(refDate, 16),
      oldPrice: null,
      newPrice: 49,
      __v: 0,
    },
  ].filter((priceHistory) =>
    country !== 'all' ? priceHistory.country === country : true,
  );
};
