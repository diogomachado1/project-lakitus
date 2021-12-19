import { Price } from "./IPrice";

export interface IListGame {
  horizontalImage: string;
  title: string;
  image: string;
  id: string;
  externalIds: {
    usEshopId: string;
    euEshopId: string;
    hkEshopId: string;
    jpEshopId: string;
  };
  description: string;
  developer: string;
  publisher: string;
  releaseDate: string;
  popularity: number;
  bestPrice: Price & {
    priceInDollar: number;
    discountPercentage: number | null;
    discountedValue: number | null;
  };
  genres: ["Platformer", "Action"];
  metacritics: {
    title: string;
    url: string;
    score: number;
  };
  createdAt: string;
  updatedAt: string;
}
