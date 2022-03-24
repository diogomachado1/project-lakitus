import type { AppContext, AppProps } from "next/app";
import { ChakraProvider } from "@chakra-ui/react";
import { SSRKeycloakProvider, SSRCookies } from "@react-keycloak/ssr";
import { KEYCLOAK_CONFIG } from "../util/auth";
import { parseCookies } from "../util/cookies";
import NProgress from "nprogress";
import "nprogress/nprogress.css";

import "simplebar/dist/simplebar.min.css";
import "./style.css";
import SimpleBar from "simplebar-react";
import Router from "next/router";
import React, { useEffect, useRef } from "react";
import CurrencyContext from "../components/currencyContext";
import theme from "../util/theme";

Router.events.on("routeChangeStart", () => NProgress.start());
Router.events.on("routeChangeComplete", () => NProgress.done());
Router.events.on("routeChangeError", () => NProgress.done());

function MyApp({ Component, pageProps, cookies }: AppProps & { cookies: any }) {
  const ref = useRef<any>();

  useEffect(() => {
    const scrollEl = ref?.current.getScrollElement();
    scrollEl.scrollTop = 0;
  });
  return (
    <SimpleBar ref={ref} style={{ maxHeight: "100vh" }}>
      <ChakraProvider theme={theme}>
        <CurrencyContext>
          <Component {...pageProps} />
        </CurrencyContext>
      </ChakraProvider>
    </SimpleBar>
  );
}

MyApp.getInitialProps = async (appContext: AppContext) => {
  return {
    cookie: parseCookies(appContext.ctx.req),
  };
};
export default MyApp;
