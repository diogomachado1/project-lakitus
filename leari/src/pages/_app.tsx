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
import React from "react";
import CurrencyContext from "../components/currencyContext";
import theme from "../util/theme";

Router.events.on("routeChangeStart", () => NProgress.start());
Router.events.on("routeChangeComplete", () => NProgress.done());
Router.events.on("routeChangeError", () => NProgress.done());

function MyApp({ Component, pageProps, cookies }: AppProps & { cookies: any }) {
  return (
    <SSRKeycloakProvider
      keycloakConfig={KEYCLOAK_CONFIG as any}
      persistor={SSRCookies(cookies)}
      initOptions={{
        onLoad: "check-sso",
        silentCheckSsoRedirectUri:
          typeof window !== "undefined"
            ? `${window.location.origin}/silent-check-sso.html`
            : null,
      }}
    >
      <SimpleBar style={{ maxHeight: "100vh" }}>
        <ChakraProvider theme={theme}>
          <CurrencyContext>
            <Component {...pageProps} />
          </CurrencyContext>
        </ChakraProvider>
      </SimpleBar>
    </SSRKeycloakProvider>
  );
}

MyApp.getInitialProps = async (appContext: AppContext) => {
  return {
    cookie: parseCookies(appContext.ctx.req),
  };
};
export default MyApp;
