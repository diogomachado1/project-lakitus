import React from "react";

import { ListItem, Flex, Box, Heading, Grid } from "@chakra-ui/react";
import Link from "next/link";
import Image from "next/image";

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
  game: { title: string; image: string; id: string };
}> = ({ game }) => {
  return (
    <ListItem w="100%" maxW="250px" m={[1, 2, 3]}>
      <Flex w="100%" rounded="3xl">
        <Link href={`/games/${game.id}`} passHref>
          <Grid templateRows="1fr, 50px" flexDir="column" w="100%" as="a">
            {game.image && (
              <Flex
                maxW="250px"
                rounded="3xl"
                mb="2"
                overflow="hidden"
                boxShadow="lg"
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
            )}
            <Flex
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
            </Flex>
          </Grid>
        </Link>
      </Flex>
    </ListItem>
  );
};

export default GameItem;
