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
import { useState } from "react";
import GameItem from "../components/GameItem";
import Image from "next/image";
import Link from "next/link";

interface IGame {
  horizontalImage: string;
  title: string;
  image: string;
  id: string;
}

interface GamesHomeProps {
  data: IGame[];
  newReleased: IGame[];
  bestDiscount: IGame[];
  bestGames: IGame[];
}

const GamesHome: NextPage<GamesHomeProps> = (props) => {
  return (
    <>
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
            <Heading size="md" mb="6">
              BEST GAMES
            </Heading>
            <Box px="8">
              <Box>
                <Slider
                  dots
                  infinite
                  speed={500}
                  slidesToShow={1}
                  slidesToScroll={1}
                >
                  {props.bestGames.map((game, index) => (
                    <Flex key={game.id} w="100%" px="4" rounded="3xl">
                      <Link href={`/games/${game.id}`} passHref>
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
                              mb="2"
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
                          <Flex
                            rounded="3xl"
                            overflow="hidden"
                            position="absolute"
                            maxH="100%"
                            top="0"
                            left="0"
                            backgroundColor="blackAlpha.300"
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
                          </Flex>
                        </Grid>
                      </Link>
                    </Flex>
                  ))}
                </Slider>
              </Box>
            </Box>
          </Box>
          <Box flexGrow={1} py="2" rounded="md" key="NEW GAMES" m="2">
            <Heading size="md" mb="6">
              NEW GAMES
            </Heading>
            <Grid templateColumns="repeat(5, 1fr)" as={List} display="flex">
              {props.newReleased.map((item, index) => (
                <GameItem key={item.id} game={item} />
              ))}
            </Grid>
          </Box>
          <Box flexGrow={1} py="2" rounded="md" key="BEST PRICES" m="2">
            <Heading size="md" mb="6">
              BEST PRICES
            </Heading>
            <Grid templateColumns="repeat(5, 1fr)" as={List} display="flex">
              {props.bestDiscount.map((item, index) => (
                <GameItem key={item.id} game={item} />
              ))}
            </Grid>
          </Box>
        </Flex>
      </Container>
    </>
  );
};

export default GamesHome;

export async function getStaticProps() {
  return {
    props: {
      data: (await http.get<any[]>("game/detail")).data.slice(0, 5),
      newReleased: (
        await http.get<any[]>("game/detail?sort=release&asc=desc")
      ).data.slice(0, 5),
      bestDiscount: (
        await http.get<any[]>("game/detail?sort=bestDiscount&asc=desc")
      ).data.slice(0, 5),
      bestGames: (
        await http.get<any[]>("game/detail?sort=metacritics&asc=desc")
      ).data.slice(0, 5),
    },
    revalidate: 60 * 60,
  };
}
