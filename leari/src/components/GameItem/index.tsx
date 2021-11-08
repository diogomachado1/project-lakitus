import React from "react";

import { ListItem, Flex, Box, Heading } from "@chakra-ui/react";
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
    <ListItem color="black">
      <Flex h="70px" backgroundColor="white" mb="3" rounded="3xl">
        <Link href={`/games/${game.id}`} passHref>
          <Flex w="100%" as="a">
            {game.image && (
              <Box
                flexShrink={0}
                minW="70px"
                rounded="3xl"
                mr="2"
                overflow="hidden"
              >
                <Image
                  alt=""
                  width="70px"
                  height="70px"
                  placeholder="blur"
                  blurDataURL={`data:image/svg+xml;base64,${toBase64(
                    shimmer(70, 70)
                  )}`}
                  src={game.image}
                />
              </Box>
            )}
            <Flex w="100%" overflow="hidden" p="2" alignItems="center">
              <Heading
                whiteSpace="nowrap"
                textOverflow="ellipsis"
                size="sm"
                overflow="hidden"
              >
                {game.title}
              </Heading>
            </Flex>
          </Flex>
        </Link>
      </Flex>
    </ListItem>
  );
};

export default GameItem;
