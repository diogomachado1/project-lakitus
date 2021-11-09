import React, { useState } from "react";

export const context = React.createContext({
  currency: "all",
  changeCurrency: (newValue: string) => {},
});
// import { Container } from './styles';

const CurrencyContext: React.FC = ({ children }) => {
  const [currency, setCurrency] = useState("all");

  const changeCurrency = (newCurrency: string) => {
    setCurrency(newCurrency);
  };
  return (
    <context.Provider value={{ currency, changeCurrency }}>
      {children}
    </context.Provider>
  );
};

export default CurrencyContext;
