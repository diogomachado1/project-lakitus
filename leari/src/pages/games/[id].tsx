import { NextPage } from "next";
import Link from "next/link";
import Image from "next/image";
import { http } from "../../util/http";
import { useRouter } from "next/router";

import { Button } from "@chakra-ui/react";

interface GamesHomeProps {
  game: {
    title: string;
    image: string;
    description: string;
    prices: {
      country: string;
      regularPrice: { amount: string; value: number };
    }[];
  };
  payload: any;
}

const GamesHome: NextPage<GamesHomeProps> = ({ game }) => {
  const router = useRouter();

  return (
    <div>
      <Button onClick={() => router.back()}>Voltar</Button>
      <h1>{game?.title}</h1>
      <ul>
        <li>
          <div>
            {game?.image && (
              <Image alt="" width="200px" height="200px" src={game?.image} />
            )}
            <h3>{game?.title}</h3>
            <p>{game?.description}</p>
            <p>
              {game?.prices.map(
                (price) =>
                  price?.regularPrice && (
                    <li>
                      {price.country}: {price?.regularPrice?.amount}
                    </li>
                  )
              )}
            </p>
          </div>
        </li>
      </ul>
    </div>
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
  return {
    props: {
      game: (await http.get(`game/detail/${params.id}`)).data,
    },
    revalidate: 60 * 60,
  };
}
