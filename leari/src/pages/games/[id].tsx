import { NextPage } from "next";
import Link from 'next/link'
import Image from "next/image";
import { http } from "../../util/http";

interface GamesHomeProps {
  game: { title: string, image: string };
  payload: any;
}

const GamesHome: NextPage<GamesHomeProps> = ({ game }) => {
  return (
    <div>
      <Link href={`/games`}>
        <a>
          <h2>Voltar</h2>
        </a>
      </Link>
      <h1>
      {game?.title}
    </h1>
      <ul>
        <li>
          <div>
            {game?.image &&
              <Image
                alt=""
                width="200px"
                height="200px"
                src={game?.image}
              />}
            <h3>{game?.title}</h3>
            <p>{game?.description}</p>
            <p>{game?.prices.map(price=> price?.regularPrice && (<li>{price.country}: {price?.regularPrice?.amount}</li>))}</p>
          </div>
        </li>
      </ul>
    </div>
  );
};

export default GamesHome;

export async function getStaticPaths() {
  return { paths: [{params: {id: '614be0065c60a0ac3c5ba781'}}], fallback: true };
}

export async function getStaticProps({ params }: any) {
  console.log('resquest1')
  return {
    props: {
      game:  (await http.get(`game/detail/${params.id}`)).data,
    },
    revalidate: 60*60,
  };
}