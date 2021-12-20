import { NextPage } from "next";

import {
  Box,
  Flex,
  Center,
  Container,
  Input,
  InputGroup,
  InputRightElement,
  IconButton,
  List,
  LightMode,
  Select,
} from "@chakra-ui/react";

import { Search2Icon } from "@chakra-ui/icons";
import { useRouter } from "next/router";
import { useState, useMemo, useEffect, useContext } from "react";
import Navbar from "../../components/navbar";
import GameItem from "../../components/GameItem";
import { http } from "../../util/http";
import { IListGame } from "../../Interface/IListGame";
import { Select as SelectMulti } from "chakra-react-select";
import { genres } from "../../util/genres";
import { context } from "../../components/currencyContext";
import PaginationButtons from "../../components/PaginationButtons";
import Head from "next/head";

interface GamesProps {
  data: IListGame[];
  currency: { [x: string]: number };
  payload: any;
}

const Games: NextPage<GamesProps> = (props) => {
  const router = useRouter();
  const { setAllCurrency } = useContext(context);
  const [page, setPage] = useState(Number(router.query.page) || 1);
  useEffect(() => {
    setAllCurrency(props.currency);
  }, [props.currency]);
  const [searchField, setSearchField] = useState<string>(
    (router.query.search as string) || ""
  );
  const [orderBy, setOrderBy] = useState(
    router.query.sort
      ? `${router.query.sort as string} ${router.query.asc as string}`
      : ""
  );

  const [genresSelected, setGenresSelected] = useState(
    (router.query?.genres as string)
      ?.split(",")
      .map((item) => ({ label: item, value: item }))
  );

  const { sort, asc } = useMemo(
    () => ({
      sort: orderBy.split(" ")[0],
      asc: orderBy.split(" ")[1],
    }),
    [orderBy]
  );

  useEffect(() => {
    if (sort || asc || page) {
      onSearch();
    }
  }, [sort, asc, page]);

  const onSearch = () => {
    const query = new URLSearchParams();
    if (searchField) {
      query.set("search", searchField);
    }
    if (page) {
      query.set("page", page.toString());
    }
    if (sort && asc) {
      query.set("sort", sort);
      query.set("asc", asc);
    }
    if (genresSelected?.length) {
      query.set(
        "genres",
        genresSelected?.reduce((acc, item) => `${acc},${item.value}`, "")
      );
    }
    router.push(`/games?${query.toString()}`);
  };
  return (
    <>
      <Head>
        <title>Search</title>
      </Head>
      <Navbar search={false} />
      <Container maxW="container.xl">
        <Flex
          color="white"
          my="4"
          mx="2"
          py="6"
          px="4"
          backgroundColor="gray.900"
          boxShadow="md"
          rounded="md"
          display="flex"
          flexDir="column"
        >
          <LightMode>
            <Flex mb="4">
              <InputGroup color="black">
                <Input
                  _placeholder={{ color: "blackAlpha.600" }}
                  backgroundColor="white"
                  placeholder="Search"
                  value={searchField}
                  onChange={(e) => setSearchField(e.target.value)}
                  onKeyUp={(e) => {
                    if (e.key === "Enter") {
                      onSearch();
                    }
                  }}
                />
              </InputGroup>

              <Select
                ml="2"
                color="black"
                _placeholder={{ color: "blackAlpha.600" }}
                backgroundColor="white"
                value={orderBy}
                defaultValue="bestDiscount asc"
                onChange={(e) => setOrderBy(e.target.value)}
                placeholder="Order by"
              >
                <option value="bestDiscount asc">Discounted Price ↑</option>
                <option value="bestDiscount desc">Discounted Price ↓</option>
                <option value="metacritics asc">Metacritics ↑</option>
                <option value="metacritics desc">Metacritics ↓</option>
                <option value="release asc">Release Date ↑</option>
                <option value="release desc">Release Date ↓</option>
                <option value="title asc">Name ↑</option>
                <option value="title desc">Name ↓</option>
              </Select>
            </Flex>
            <Flex>
              <Box backgroundColor="white" rounded="5px" color="black" w="100%">
                <SelectMulti
                  isClearable
                  isMulti
                  value={genresSelected}
                  onChange={(e: any[]) => setGenresSelected(e)}
                  onBlur={() => onSearch()}
                  name="genres"
                  placeholder="Select some colors..."
                  options={genres.map((item) => ({ label: item, value: item }))}
                  closeMenuOnSelect={false}
                />
              </Box>
            </Flex>
          </LightMode>
        </Flex>
        <Flex py="2" px="8" justifyContent="flex-end">
          <PaginationButtons
            page={page}
            onChange={(newPage) => {
              setPage(newPage);
            }}
            totalPages={100}
          />
        </Flex>

        <Box minW="340px" flexGrow={1} px="4" py="4" rounded="md" m="2">
          <List display="flex" flexWrap="wrap">
            {props.data.map((item, index) => (
              <GameItem key={item.id} game={item} />
            ))}
          </List>
        </Box>
        <Flex p="4" px="8" justifyContent="flex-end">
          <PaginationButtons
            page={page}
            onChange={(newPage) => {
              setPage(newPage);
            }}
            totalPages={100}
          />
        </Flex>
      </Container>
    </>
  );
};
export default Games;

export const getServerSideProps = async (ctx: any) => {
  const [
    { data },
    {
      data: { rates: currency },
    },
  ] = await Promise.all([
    http.get("game/detail", { params: ctx.query }),
    http.get<{ rates: { [x: string]: number }[] }>(`game/currency`),
  ]);
  return {
    props: { data, currency },
  };
};
