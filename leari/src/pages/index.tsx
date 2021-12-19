import { NextPage } from "next";

import { http } from "../util/http";
import {
  Box,
  Text,
  Flex,
  Heading,
  Center,
  Container,
  List,
  Grid,
} from "@chakra-ui/react";
import Slider from "react-slick";
import Navbar from "../components/navbar";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import { useRouter } from "next/router";
import { useContext, useEffect, useState } from "react";
import GameItem from "../components/GameItem";
import Image from "next/image";
import Link from "next/link";
import { IListGame } from "../Interface/IListGame";
import Head from "next/head";
import { context } from "../components/currencyContext";
interface GamesHomeProps {
  data: IListGame[];
  newReleased: IListGame[];
  bestDiscount: IListGame[];
  bestGames: IListGame[];
  bestDiscountActions: IListGame[];
  bestDiscountIndie: IListGame[];
  bestDiscountMultiplayer: IListGame[];
  bestDiscountAdventure: IListGame[];
  currency: { [x: string]: number };
}

const GamesHome: NextPage<GamesHomeProps> = ({
  currency,
  newReleased,
  bestGames,
  bestDiscount,
  bestDiscountActions,
  bestDiscountIndie,
  bestDiscountAdventure,
  bestDiscountMultiplayer,
}) => {
  const { setAllCurrency, formatedPrice, convertCurrency, bestPrice } =
    useContext(context);
  useEffect(() => {
    setAllCurrency(currency);
  }, [currency]);
  console.log(bestDiscountAdventure);
  const lists = [
    {
      title: "NEW GAMES",
      games: newReleased,
      link: "sort=release&asc=desc",
    },
    {
      title: "BEST PRICES",
      games: bestDiscount,
      link: "sort=bestDiscount&asc=desc",
    },
    {
      title: "BEST ACTIONS PRICE",
      games: bestDiscountActions,
      link: "sort=bestDiscount&asc=desc&genres=Action",
    },
    {
      title: "BEST ADVENTURES PRICE",
      games: bestDiscountAdventure,
      link: "sort=bestDiscount&asc=desc&genres=Adventure",
    },
    {
      title: "BEST INDIES PRICE",
      games: bestDiscountIndie,
      link: "sort=bestDiscount&asc=desc&genres=Indie",
    },
    {
      title: "BEST MULTIPLAYERS PRICE",
      games: bestDiscountMultiplayer,
      link: "sort=bestDiscount&asc=desc&genres=Multiplayer",
    },
  ];
  return (
    <>
      <Head>
        <title>Sheepprices</title>
      </Head>
      <Navbar />
      <Container maxW="container.xl">
        <Flex flexDir="column" alignItems="center">
          <Box
            flexGrow={1}
            maxW="100%"
            py="2"
            rounded="md"
            key="BEST GAMES"
            m="2"
          >
            <Box>
              <Box>
                <Slider
                  dots={false}
                  infinite
                  speed={500}
                  slidesToShow={1}
                  slidesToScroll={1}
                  arrows={false}
                >
                  {bestGames.map((game, index) => (
                    <Flex key={game.id} w="100%" px="1" rounded="3xl">
                      <Grid
                        templateRows="1fr, 50px"
                        w="100%"
                        as="a"
                        position="relative"
                      >
                        {game.image && (
                          <Flex
                            maxW="1400px"
                            rounded="3xl"
                            overflow="hidden"
                            boxShadow="lg"
                          >
                            <Image
                              alt=""
                              width="1400px"
                              height="800px"
                              src={game?.horizontalImage}
                            />
                          </Flex>
                        )}
                        <Link href={`/games/${game.id}`} passHref>
                          <Flex
                            as="a"
                            borderBottomRadius="3xl"
                            overflow="hidden"
                            position="absolute"
                            maxH="100%"
                            w="100%"
                            bottom="0"
                            left="0"
                            backgroundColor="blackAlpha.800"
                            p="2"
                            px="3"
                            maxW="100%"
                          >
                            <Flex flexDir="column">
                              <Heading
                                mb="2"
                                maxW="100%"
                                textOverflow="ellipsis"
                                whiteSpace="nowrap"
                                size="lg"
                                overflow="hidden"
                              >
                                {game.title}
                              </Heading>
                              <Flex alignItems="center" mb="1"></Flex>
                              <Flex alignItems="center">
                                <Text fontSize="md" mr="2" fontWeight="bold">
                                  {bestPrice(game)}
                                </Text>
                                <Image
                                  priority
                                  width="25px"
                                  height="25px"
                                  alt="United States"
                                  src={`http://purecatamphetamine.github.io/country-flag-icons/3x2/${game.bestPrice.country}.svg`}
                                />
                                <Flex maxH="20px" ml="3" mr="1">
                                  <Image
                                    alt="metacritics"
                                    src="/Metacritic.svg"
                                    width="20"
                                    height="20"
                                  />
                                </Flex>
                                <Text fontSize="md" fontWeight="extrabold">
                                  {game.metacritics.score}
                                </Text>
                              </Flex>
                              {game.bestPrice.discountPrice && (
                                <Flex my="1" alignItems="center">
                                  <Text
                                    as="del"
                                    fontStyle="oblique"
                                    opacity="0.5"
                                    fontSize="md"
                                    mr="2"
                                  >
                                    {formatedPrice(
                                      game.bestPrice,
                                      "regularPrice"
                                    )}
                                  </Text>
                                  <Text
                                    backgroundColor="red.600"
                                    px="2"
                                    borderRadius="lg"
                                    fontSize="md"
                                    mr="2"
                                    fontWeight="bold"
                                  >
                                    {game.bestPrice.discountPercentage}% OFF
                                  </Text>
                                </Flex>
                              )}
                            </Flex>
                          </Flex>
                        </Link>
                      </Grid>
                    </Flex>
                  ))}
                </Slider>
              </Box>
            </Box>
          </Box>
          <Flex w="100%" flexWrap="wrap" justifyContent="space-around">
            {lists.map((list, index) => (
              <Box
                flexGrow={1}
                py="2"
                rounded="md"
                key={`${index}+${list.title}`}
                m="2"
              >
                <Flex px="4" mb="6" justifyContent="space-between">
                  <Heading size="md">{list.title}</Heading>
                  <Link href={`/games?${list.link}`} passHref>
                    <Heading
                      as="a"
                      color="whiteAlpha.700"
                      size="md"
                      _hover={{ color: "white" }}
                      transition="ease-in-out"
                    >
                      See all
                    </Heading>
                  </Link>
                </Flex>
                <Grid templateRows="repeat(5, 1fr)" as={List}>
                  {list.games.map((item, index) => (
                    <GameItem key={item.id} game={item} />
                  ))}
                </Grid>
              </Box>
            ))}
          </Flex>
        </Flex>
      </Container>
    </>
  );
};

export default GamesHome;

export async function getStaticProps() {
  const [
    newReleased,
    bestDiscount,
    bestGames,
    bestDiscountActions,
    bestDiscountAdventure,
    bestDiscountIndie,
    bestDiscountMultiplayer,
    {
      data: { rates: currency },
    },
  ] = await Promise.all([
    http.get<IListGame[]>("game/detail?sort=release&asc=desc"),
    http.get<IListGame[]>("game/detail?sort=bestDiscount&asc=desc"),
    http.get<IListGame[]>("game/detail?sort=metacritics&asc=desc"),
    http.get<IListGame[]>(
      "game/detail?sort=bestDiscount&asc=desc&genres=Action"
    ),
    http.get<IListGame[]>(
      "game/detail?sort=bestDiscount&asc=desc&genres=Adventure"
    ),
    http.get<IListGame[]>(
      "game/detail?sort=bestDiscount&asc=desc&genres=Indie"
    ),
    http.get<IListGame[]>(
      "game/detail?sort=bestDiscount&asc=desc&genres=Multiplayer"
    ),
    http.get<{ rates: { [x: string]: number }[] }>(`game/currency`),
  ]);
  return {
    props: {
      currency,
      newReleased: newReleased.data.slice(0, 5),
      bestDiscount: bestDiscount.data.slice(0, 5),
      bestDiscountActions: bestDiscountActions.data.slice(0, 5),
      bestDiscountIndie: bestDiscountIndie.data.slice(0, 5),
      bestDiscountAdventure: bestDiscountAdventure.data.slice(0, 5),
      bestDiscountMultiplayer: bestDiscountMultiplayer.data.slice(0, 5),
      bestGames: bestGames.data.slice(0, 5),
    },
    revalidate: 60 * 60,
  };
}
