export interface SimpleDetail {
  id: string;
  externalIds: {
    usEshopId: string;
    euEshopId: string;
    hkEshopId: string;
    jpEshopId: string;
  };
  title: string;
  prices: any;
  description: string;
  developer: string;
  publisher: string;
  image: string;
  releaseDate: string;
  popularity: string;
  createdAt: Date;
  updatedAt: Date;
}
