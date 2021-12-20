import { NextPage } from "next";
import Link from "next/link";
import Image from "next/image";
import { http } from "../../util/http";
import { useRouter } from "next/router";
import getSymbolFromCurrency from "currency-symbol-map";
import {
  AreaChart,
  Area,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
} from "recharts";

import {
  Text,
  Container,
  Flex,
  Heading,
  IconButton,
  Stat,
  StatLabel,
  StatNumber,
  StatHelpText,
  StatArrow,
  DarkMode,
} from "@chakra-ui/react";
import Navbar from "../../components/navbar";
import { ChevronLeftIcon, WarningIcon } from "@chakra-ui/icons";
import { useContext, useEffect, useState } from "react";
import { context } from "../../components/currencyContext";
import { countryCodeToName, countryToCurrency } from "../../util/countries";
import { Price } from "../../Interface/IPrice";
import Head from "next/head";

interface GamesHomeProps {
  game: {
    title: string;
    image: string;
    horizontalImage: string;
    description: string;
    prices?: Price[];
  };
  priceHistory: {
    prices: { country: string; value: number }[];
    date: string;
  }[];
  currency: { [x: string]: number };
  payload: any;
}

const GamesHome: NextPage<GamesHomeProps> = ({
  game,
  currency,
  priceHistory,
}) => {
  const router = useRouter();
  const { setAllCurrency, formatedPrice, convertCurrency } =
    useContext(context);
  const [selectedHistoryPrice, setSelectedHistoryPrice] =
    useState<{ date: string; price?: number; country?: string }[]>();
  const [selectedCountry, setSelectedCountry] = useState<string>("");
  useEffect(() => {
    setAllCurrency(currency);
  }, [currency]);
  useEffect(() => {
    if (priceHistory && !selectedCountry) {
      const prices = priceHistory
        .map((item) => {
          const bestPrice = item.prices.reduce(
            (acc, x) =>
              x.value / currency[countryToCurrency[x.country]] < acc.value
                ? {
                    ...x,
                    value:
                      Math.round(
                        (x.value / currency[countryToCurrency[x.country]]) * 100
                      ) / 100,
                  }
                : acc,
            { value: 99999999999999, country: "" }
          );
          return {
            date: item.date,
            price: bestPrice.value,
            country: bestPrice.country,
          };
        })
        .reverse();
      setSelectedHistoryPrice(prices);
    } else if (selectedCountry) {
      const prices = priceHistory
        .map((item) => {
          const price = item.prices.find((x) => x.country === selectedCountry);
          return {
            date: item.date,
            price: price?.value || 0,
            country: price?.country,
          };
        })
        .reverse();
      setSelectedHistoryPrice(prices);
    }
  }, [priceHistory, selectedCountry]);
  useEffect(() => console.log(priceHistory), [priceHistory]);
  if (!game || !priceHistory) return <></>;

  const pricesConverteds = game.prices
    ?.map((item) => ({
      ...item,
      lastValue: convertCurrency(
        item?.discountPrice?.rawValue || item?.regularPrice?.rawValue,
        item?.regularPrice?.currency
      ),
    }))
    .sort((a, b) => a.lastValue - b.lastValue);

  return (
    <>
      <Head>
        <title>{game.title}</title>
      </Head>
      <Navbar />
      <Container p="4" maxW="container.xl">
        <Flex flexDir="column">
          <Flex mb="8" alignItems="center">
            <IconButton
              aria-label="back"
              mr="2"
              icon={<ChevronLeftIcon />}
              rounded="50%"
              onClick={() => router.back()}
            >
              Voltar
            </IconButton>
            <Heading size="xl">{game?.title}</Heading>
          </Flex>
          <Flex
            mb="8"
            flexGrow={1}
            w="50%"
            alignSelf="center"
            justifyContent="center"
            overflow="hidden"
            rounded="md"
          >
            {game?.horizontalImage && (
              <Image
                priority
                alt=""
                width="1200px"
                height="700px"
                src={game?.horizontalImage}
              />
            )}
          </Flex>
          <Flex
            color="white"
            mb="8"
            p="4"
            backgroundColor="gray.900"
            rounded="md"
          >
            <Text>{game?.description}</Text>
          </Flex>
          {!!selectedHistoryPrice?.length && (
            <Flex h="400px" justifyContent="center">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart
                  width={500}
                  height={400}
                  data={selectedHistoryPrice}
                  margin={{
                    top: 10,
                    right: 30,
                    left: 0,
                    bottom: 0,
                  }}
                >
                  <XAxis dataKey="date" />
                  <YAxis />
                  <Tooltip
                    content={(data) => {
                      const payload = data?.payload?.[0];
                      return (
                        <Flex
                          color="blackAlpha.700"
                          flexDirection="column"
                          p="2"
                          backgroundColor="whiteAlpha.600"
                          rounded="md"
                        >
                          <Text>{payload?.payload?.date}</Text>
                          <Text>{payload?.payload?.price}</Text>
                          <Text>
                            {countryCodeToName[payload?.payload?.country]}
                          </Text>
                        </Flex>
                      );
                    }}
                  />
                  <Area
                    type="monotone"
                    dataKey="price"
                    stroke="#8884d8"
                    fill="#8884d8"
                  />
                </AreaChart>
              </ResponsiveContainer>
            </Flex>
          )}
          <Flex>
            <Flex
              flexDir="column"
              mb="8"
              p="4"
              w="100%"
              backgroundColor="gray.900"
              rounded="md"
              color="white"
            >
              {game.prices ? (
                pricesConverteds?.map(
                  (price, index) =>
                    price?.regularPrice && (
                      <Flex
                        key={price.country}
                        display="flex"
                        alignItems="center"
                        justifyContent="space-between"
                        borderBottom="1px"
                        borderColor="whiteAlpha.300"
                      >
                        <Flex alignItems="center">
                          <Heading size="sm" minW="30px" mr="2">
                            {index + 1}
                          </Heading>
                          <Image
                            priority
                            width="50px"
                            height="50px"
                            alt="United States"
                            src={`http://purecatamphetamine.github.io/country-flag-icons/3x2/${price.country}.svg`}
                          />
                          <Text ml="2">
                            {" "}
                            {countryCodeToName[price.country]}{" "}
                          </Text>
                        </Flex>
                        <Flex alignItems="center">
                          <DarkMode>
                            <IconButton
                              col
                              aria-label="back"
                              mr="2"
                              icon={<WarningIcon />}
                              rounded="50%"
                              onClick={() =>
                                setSelectedCountry(
                                  price.country === selectedCountry
                                    ? ""
                                    : price.country
                                )
                              }
                            />
                          </DarkMode>
                          <Stat size="sm">
                            {price?.discountPrice && (
                              <StatLabel>
                                <Text
                                  ml="2"
                                  opacity="0.3"
                                  fontSize="sm"
                                  as="del"
                                >
                                  {formatedPrice(price, "regularPrice")}
                                </Text>
                              </StatLabel>
                            )}
                            <StatNumber>
                              {formatedPrice(
                                price,
                                price?.discountPrice
                                  ? "discountPrice"
                                  : "regularPrice"
                              )}
                            </StatNumber>
                            {price?.discountPrice && (
                              <StatHelpText fontSize="12px">
                                <StatArrow fontSize="12px" type="decrease" />
                                {Math.round(
                                  100 -
                                    (Number(price?.discountPrice.rawValue) /
                                      Number(price?.regularPrice.rawValue)) *
                                      100
                                )}
                                %
                              </StatHelpText>
                            )}
                          </Stat>
                        </Flex>
                      </Flex>
                    )
                )
              ) : (
                <Text>No price data</Text>
              )}
            </Flex>
          </Flex>
        </Flex>
      </Container>
    </>
  );
};

export default GamesHome;

export async function getStaticPaths() {
  return {
    paths: [],
    fallback: true,
  };
}

export async function getStaticProps({ params }: any) {
  const [
    { data: game },
    {
      data: { rates: currency },
    },
    { data: priceHistory },
  ] = await Promise.all([
    http.get(`game/detail/${params.id}`),
    http.get<{ rates: { [x: string]: number }[] }>(`game/currency`),
    http.get(`/game/price-history/${params.id}`),
  ]);

  return {
    props: {
      game,
      currency,
      priceHistory,
    },
    revalidate: 60 * 60,
  };
}
