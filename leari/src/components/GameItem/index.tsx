import React, { useContext } from "react";

import { ListItem, Flex, Box, Heading, Grid, Text } from "@chakra-ui/react";
import Link from "next/link";
import Image from "next/image";
import { IListGame } from "../../Interface/IListGame";
import { context } from "../currencyContext";

const shimmer = (w: number, h: number) => `
<svg width="${w}" height="${h}" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <defs>
    <linearGradient id="g">
      <stop stop-color="#333" offset="20%" />
      <stop stop-color="#222" offset="50%" />
      <stop stop-color="#333" offset="70%" />
    </linearGradient>
  </defs>
  <rect width="${w}" height="${h}" fill="#333" />
  <rect id="r" width="${w}" height="${h}" fill="url(#g)" />
  <animate xlink:href="#r" attributeName="x" from="-${w}" to="${w}" dur="1s" repeatCount="indefinite"  />
</svg>`;

const toBase64 = (str: string) =>
  typeof window === "undefined"
    ? Buffer.from(str).toString("base64")
    : window.btoa(str);

const GameItem: React.FC<{
  game: IListGame;
}> = ({ game }) => {
  const { formatedPrice, bestPrice } = useContext(context);

  return (
    <ListItem w="100%" p="1">
      <Flex w="100%" rounded="3xl">
        <Link href={`/games/${game.id}`} passHref>
          <Grid
            templateRows="100px"
            templateColumns="100px 240px"
            flexDir="column"
            color="whiteAlpha.700"
            _hover={{ color: "white" }}
            transition="ease-in-out"
            transitionDuration="0.1s"
            w="100%"
            as="a"
            borderRadius="50px"
            background="linear-gradient(90deg, rgba(0,0,0,1) 0%, rgba(50,50,50,1) 80%);"
          >
            <Flex
              maxW="250px"
              rounded="50%"
              overflow="hidden"
              boxShadow="lg"
              alignItems="center"
            >
              <Image
                priority
                quality="40"
                alt=""
                width="250px"
                height="250px"
                placeholder="blur"
                blurDataURL={`data:image/svg+xml;base64,${toBase64(
                  shimmer(250, 250)
                )}`}
                src={game.image}
              />
            </Flex>
            <Flex
              borderBottomRadius="3xl"
              maxH="100%"
              w="100%"
              bottom="0"
              left="0"
              p="2"
              px="3"
              maxW="100%"
            >
              <Flex maxW="200px" justifyContent="center" flexDir="column">
                <Heading
                  mb="2"
                  textOverflow="ellipsis"
                  whiteSpace="nowrap"
                  size="sm"
                  overflow="hidden"
                >
                  {game.title}
                </Heading>
                {game?.bestPrice?.regularPrice && (
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
                    {game.metacritics && (
                      <>
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
                      </>
                    )}
                  </Flex>
                )}
                {game?.bestPrice?.discountPrice && (
                  <Flex my="1" alignItems="center">
                    <Text
                      as="del"
                      fontStyle="oblique"
                      opacity="0.5"
                      fontSize="md"
                      mr="2"
                    >
                      {formatedPrice(game.bestPrice, "regularPrice")}
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
            {/* <Flex
              overflow="hidden"
              maxH="50px"
              p="2"
              maxW="100%"
              justifyContent="center"
            >
              <Heading
                maxW="100%"
                textOverflow="ellipsis"
                whiteSpace="nowrap"
                size="sm"
                overflow="hidden"
                textAlign="center"
              >
                {game.title}
              </Heading>
            </Flex> */}
          </Grid>
        </Link>
      </Flex>
    </ListItem>
  );
};

export default GameItem;
