import { NextPage } from "next";

import { http } from "../util/http";
import {
  Box,
  Text,
  Flex,
  Heading,
  Center,
  Container,
  Input,
  InputGroup,
  InputRightElement,
  IconButton,
  List,
} from "@chakra-ui/react";

import Navbar from "../components/navbar";
import { Search2Icon } from "@chakra-ui/icons";
import { useRouter } from "next/router";
import { useState } from "react";
import GameItem from "../components/GameItem";

interface GamesHomeProps {
  data: { title: string; image: string; id: string }[];
  payload: any;
}

const GamesHome: NextPage<GamesHomeProps> = (props) => {
  const router = useRouter();
  const [searchField, setSearchField] = useState("");
  console.log(props.data.length);
  return (
    <>
      <Navbar />
      <Container maxW="container.xl">
        <Center
          color="white"
          my="4"
          mx="2"
          py="6"
          px="2"
          backgroundColor="blue.900"
          boxShadow="md"
          rounded="md"
          flexDir="column"
        >
          <Heading textAlign="center" fontWeight="extrabold" mb="4">
            Look for good games and find cheap prices!
          </Heading>
          <Text
            fontSize="lg"
            maxW="400px"
            textAlign="center"
            fontWeight="bold"
            mb="4"
          >
            Search all world Nitendo’s prices. Choose the best eshop to buy and
            be happy!
          </Text>
          <InputGroup color="black" maxW="75%">
            <Input
              _placeholder={{ color: "blackAlpha.600" }}
              backgroundColor="white"
              placeholder="Enter amount"
              value={searchField}
              onChange={(e) => setSearchField(e.target.value)}
              onKeyUp={(e) => {
                if (e.key === "Enter") {
                  router.push(`/games?search=${searchField}`);
                }
              }}
            />
            <InputRightElement>
              <IconButton
                background="blackAlpha.100"
                _hover={{ background: "blackAlpha.300" }}
                _active={{ background: "blackAlpha.400" }}
                aria-label="search"
                h="1.75rem"
                size="sm"
                onClick={() => router.push(`/games?search=${searchField}`)}
                icon={<Search2Icon color="black" />}
              />
            </InputRightElement>
          </InputGroup>
        </Center>
        <Flex flexWrap="wrap" alignItems="center">
          {[
            "BEST PRICES",
            "POP ‘n’ CHEAP",
            "Top reviews",
            "NEW GAMES",
            "EDITOR’S CHOICE",
            "Last Reviews",
          ].map((category) => (
            <Box
              minW="340px"
              w="30%"
              flexGrow={1}
              px={[4, 8, 12]}
              py="8"
              backgroundColor="blue.900"
              boxShadow="md"
              rounded="md"
              key={category}
              m="2"
            >
              <Heading color="white" size="md" mb="6">
                {category}
              </Heading>
              <List>
                {props.data.map((item, index) => (
                  <GameItem key={item.id} game={item} />
                ))}
              </List>
            </Box>
          ))}
        </Flex>
      </Container>
    </>
  );
};

export default GamesHome;

export async function getStaticProps() {
  console.log("aaa");
  return {
    props: {
      data: (await http.get<any[]>("game/detail")).data.slice(0, 10),
    },
    revalidate: 60 * 60,
  };
}

// export const getServerSideProps = async (ctx: any) => {
//   const { data } = await http.get("game/detail", { params: ctx.query });
//   return {
//     props: { data },
//   };
// };
