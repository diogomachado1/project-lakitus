import { NextPage } from "next";
import Link from "next/link";
import Image from "next/image";
import { http } from "../../util/http";
import { useRouter } from "next/router";
import getSymbolFromCurrency from "currency-symbol-map";

import { Text, Container, Flex, Heading, IconButton } from "@chakra-ui/react";
import Navbar from "../../components/navbar";
import { ChevronLeftIcon } from "@chakra-ui/icons";
import { useEffect } from "react";

interface Price {
  country: string;
  regularPrice: { amount: string; rawValue: string; currency: string };
  discountPrice: { amount: string; rawValue: string; currency: string };
}
interface GamesHomeProps {
  game: {
    title: string;
    image: string;
    horizontalImage: string;
    description: string;
    prices: Price[];
  };
  currency: { [x: string]: number };
  payload: any;
}

const GamesHome: NextPage<GamesHomeProps> = ({ game, currency }) => {
  const router = useRouter();
  if (!game) return <></>;
  const filter = router.query.currency as string;

  const convertMoney = (value: string, priceCurrency: string) => {
    const priceInDollar = Number(value) / (currency[priceCurrency] || 1);
    console.log(currency[filter?.toUpperCase()]);
    return (
      Math.round(priceInDollar * (currency[filter?.toUpperCase()] || 1) * 100) /
      100
    );
  };
  const pricesConverteds = game.prices
    .map((item) => ({
      ...item,
      lastValue: convertMoney(
        item?.discountPrice?.rawValue || item?.regularPrice?.rawValue,
        item?.regularPrice?.currency
      ),
    }))
    .sort((a, b) => a.lastValue - b.lastValue);
  const getFormatedPrice = (
    price: Price & { lastValue: number },
    priceType: "regularPrice" | "discountPrice"
  ) => {
    return filter
      ? `${getSymbolFromCurrency(filter)} ${price?.lastValue}`
      : `${getSymbolFromCurrency(price?.[priceType].currency)} ${
          price?.[priceType].rawValue
        }`;
  };
  return (
    <>
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
                alt=""
                width="1200px"
                height="700px"
                src={game?.horizontalImage}
              />
            )}
          </Flex>
          <Flex mb="8" p="4" backgroundColor="gray.700" rounded="md">
            <Text>{game?.description}</Text>
          </Flex>
          <Flex
            flexDir="column"
            mb="8"
            p="4"
            backgroundColor="gray.700"
            rounded="md"
          >
            {pricesConverteds.map(
              (price) =>
                price?.regularPrice && (
                  <Text display="flex">
                    {price.country}:{" "}
                    {price?.discountPrice ? (
                      <Flex>
                        <Text ml="2" opacity="0.3" fontSize="sm" as="del">
                          {getFormatedPrice(price, "regularPrice")}
                        </Text>
                        <Text ml="2">
                          {getFormatedPrice(price, "discountPrice")}
                        </Text>
                        <Text color="red" ml="2">
                          {Math.round(
                            100 -
                              (Number(price?.discountPrice.rawValue) /
                                Number(price?.regularPrice.rawValue)) *
                                100
                          )}
                          %
                        </Text>
                      </Flex>
                    ) : (
                      <Text ml="2">
                        {getFormatedPrice(price, "regularPrice")}
                      </Text>
                    )}
                  </Text>
                )
            )}
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
  const game = (await http.get(`game/detail/${params.id}`)).data;
  const currency = (
    await http.get<{ rates: { [x: string]: number }[] }>(`game/currency`)
  ).data.rates;
  return {
    props: {
      game,
      currency,
    },
    revalidate: 60 * 60,
  };
}
