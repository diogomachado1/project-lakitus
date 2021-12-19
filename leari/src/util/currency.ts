import getSymbolFromCurrency from "currency-symbol-map";
import { IListGame } from "../Interface/IListGame";
import { Price } from "../Interface/IPrice";
import { countryToCurrency } from "./countries";

export function convertMoney(
  value: string,
  priceCurrency: string,
  currency: { [x: string]: number },
  defaultCurrency: string
) {
  const priceInDollar = Number(value) / (currency[priceCurrency] || 1);
  return (
    Math.round(
      priceInDollar * (currency[defaultCurrency?.toUpperCase()] || 1) * 100
    ) / 100
  );
}

export const getFormatedPrice = (
  price: Price,
  priceType: "regularPrice" | "discountPrice",
  currency: { [x: string]: number },
  defaultCurrency: string
) => {
  return defaultCurrency !== "all"
    ? `${getSymbolFromCurrency(defaultCurrency)} ${convertMoney(
        price?.[priceType].rawValue,
        price?.regularPrice?.currency,
        currency,
        defaultCurrency
      )}`
    : `${getSymbolFromCurrency(price?.[priceType]?.currency)} ${
        price?.[priceType]?.rawValue
      }`;
};
