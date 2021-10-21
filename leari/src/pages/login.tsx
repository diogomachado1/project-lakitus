import { useKeycloak } from "@react-keycloak/ssr";
import { KeycloakInstance } from "keycloak-js";
import { useEffect } from "react";
import Router from 'next/router';

const LoginPage = () => {
  const { initialized, keycloak } = useKeycloak<KeycloakInstance>();

  const { login = () => {}, authenticated } = keycloak || {};
  useEffect(() => {
    console.log(initialized, authenticated)
    if (!initialized) {
      return;
    }
    if (!authenticated) {
      login();
    }
  }, [login, authenticated, initialized]);

  useEffect(() => {
    if(!initialized){
      return;
    }

    if(authenticated){
      Router.replace('/games');
    }
  })

  return null;
};

export default LoginPage;