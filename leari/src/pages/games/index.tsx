import { NextPage } from "next";

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

import { Search2Icon } from "@chakra-ui/icons";
import { useRouter } from "next/router";
import { useState } from "react";
import Navbar from "../../components/navbar";
import GameItem from "../../components/GameItem";
import { http } from "../../util/http";

interface GamesProps {
  data: { title: string; image: string; id: string }[];
  payload: any;
}

const Games: NextPage<GamesProps> = (props) => {
  const router = useRouter();
  const [searchField, setSearchField] = useState(router.query.search || "");
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

        <Box
          minW="340px"
          flexGrow={1}
          px={[4, 8, 12]}
          py="8"
          backgroundColor="blue.900"
          boxShadow="md"
          rounded="md"
          m="2"
        >
          <List>
            {props.data.map((item, index) => (
              <GameItem key={item.id} game={item} />
            ))}
          </List>
        </Box>
      </Container>
    </>
  );
};

export default Games;

export const getServerSideProps = async (ctx: any) => {
  const { data } = await http.get("game/search", {
    params: { q: ctx.query.search },
  });
  return {
    props: { data },
  };
};
