import { useKeycloak } from "@react-keycloak/ssr";
import { KeycloakInstance } from "keycloak-js";
import { NextPage } from "next";
import { Token, validateAuth } from "../util/auth";
import { http } from "../util/http";

interface PrivatePageProps {
  data: {usEshopDetail:{title:string}}[];
  payload: any;
}

const PrivatePage: NextPage<PrivatePageProps> = (props) => {
  const { initialized, keycloak  } = useKeycloak<KeycloakInstance>();
  console.log(props.payload);
  return (
  <div>Pagina privada {props.data.map(item=>item?.usEshopDetail?.title).join(',')}
  <button onClick={()=>keycloak?.logout({redirectUri:'http://localhost:3000/login'})}>logout</button>
  </div>);
};

export default PrivatePage;

export const getServerSideProps = async (ctx: any) => {
  const auth = validateAuth(ctx.req);
  console.log(auth)
  if (!auth) {
    return {
      redirect: {
        permanent: false,
        destination: "/login",
      },
    };
  }
  const token = auth.token;
  console.log(token)
  const { data } = await http.get("games", {
    headers: {
      Authorization: `Bearer ${token}`,
    },
  });

  return {
    props: {data},
  };
};