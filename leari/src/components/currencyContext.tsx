import React, { useEffect, useState } from "react";
import { IListGame } from "../Interface/IListGame";
import { Price } from "../Interface/IPrice";
import { convertMoney, getFormatedPrice } from "../util/currency";
import { http } from "../util/http";

export const context = React.createContext<{
  currency: string;
  allCurrency?: { [x: string]: number };
  setAllCurrency: (newValue: { [x: string]: number }) => void;
  changeCurrency: (newValue: string) => void;
  convertCurrency: (value: string, priceCurrency: string) => number;
  formatedPrice: (
    price: Price,
    priceType: "regularPrice" | "discountPrice"
  ) => string;
  bestPrice: (game: IListGame) => string;
}>({
  currency: "all",
  allCurrency: {},
  setAllCurrency: (newValue: { [x: string]: number }) => {},
  changeCurrency: (newValue: string) => {},
  convertCurrency: (value: string, priceCurrency: string) => 0,
  formatedPrice: (price: Price, priceType: "regularPrice" | "discountPrice") =>
    "",
  bestPrice: (game: IListGame) => "",
});
// import { Container } from './styles';

const CurrencyContext: React.FC = ({ children }) => {
  const [currency, setCurrency] = useState("all");
  const [allCurrency, setAllCurrency] = useState<any>();

  const changeCurrency = (newCurrency: string) => {
    setCurrency(newCurrency);
  };

  const convertCurrency = (value: string, priceCurrency: string) => {
    if (currency && allCurrency) {
      return convertMoney(value, priceCurrency, allCurrency, currency);
    }
    return 0;
  };

  function bestPrice(game: IListGame) {
    if (currency && allCurrency) {
      return game.bestPrice.discountPrice
        ? getFormatedPrice(
            game.bestPrice,
            "discountPrice",
            allCurrency,
            currency
          )
        : getFormatedPrice(
            game.bestPrice,
            "regularPrice",
            allCurrency,
            currency
          );
    }
    return "";
  }

  const formatedPrice = (
    price: Price,
    priceType: "regularPrice" | "discountPrice"
  ) => {
    if (currency && allCurrency) {
      return getFormatedPrice(price, priceType, allCurrency, currency);
    }
    return "";
  };

  return (
    <context.Provider
      value={{
        currency,
        allCurrency,
        setAllCurrency,
        changeCurrency,
        convertCurrency,
        formatedPrice,
        bestPrice,
      }}
    >
      {children}
    </context.Provider>
  );
};

export default CurrencyContext;
