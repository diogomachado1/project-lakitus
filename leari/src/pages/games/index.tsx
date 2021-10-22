import { NextPage } from "next";
import Link from "next/link";
import Image from "next/image";
import { http } from "../../util/http";
import { useKeycloak } from "@react-keycloak/ssr";
import { KeycloakInstance } from "keycloak-js";

interface GamesHomeProps {
  data: { title: string; image: string; id: string }[];
  payload: any;
}

const GamesHome: NextPage<GamesHomeProps> = (props) => {
  const { keycloak } = useKeycloak<KeycloakInstance>();
  const { login = () => {}, authenticated } = keycloak || {};

  return (
    <div>
      <h1>Home</h1>
      {!authenticated ? (
        <Link href={`/login`}>
          <a>
            <h2>Fazer Login</h2>
          </a>
        </Link>
      ) : (
        <button
          onClick={() =>
            keycloak?.logout({ redirectUri: "http://localhost:3000/games" })
          }
        >
          Logout
        </button>
      )}
      <ul>
        {props.data.map((item, index) => (
          <li key={item.id}>
            <Link href={`/games/${item.id}`}>
              <a>
                <div>
                  {item.image && (
                    <Image
                      alt=""
                      width="200px"
                      height="200px"
                      src={item.image}
                    />
                  )}
                  <h3>{item.title}</h3>
                </div>
              </a>
            </Link>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default GamesHome;

export const getServerSideProps = async (ctx: any) => {
  const { data } = await http.get("game/detail", { params: ctx.query });
  return {
    props: { data },
  };
};
