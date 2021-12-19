export interface Price {
  country: string;
  regularPrice: { amount: string; rawValue: string; currency: string };
  discountPrice: { amount: string; rawValue: string; currency: string };
}
