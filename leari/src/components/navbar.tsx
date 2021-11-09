import {
  Box,
  Container,
  Flex,
  Heading,
  Text,
  IconButton,
  useColorMode,
  Button,
} from "@chakra-ui/react";
import React from "react";
import { MoonIcon, SunIcon } from "@chakra-ui/icons";
import { useKeycloak } from "@react-keycloak/ssr";
import { KeycloakInstance } from "keycloak-js";
import Link from "next/link";
import { useRouter } from "next/router";

const Navbar: React.FC = () => {
  const { colorMode, toggleColorMode } = useColorMode();
  const { keycloak } = useKeycloak<KeycloakInstance>();
  const router = useRouter();

  const { login = () => {}, authenticated } = keycloak || {};

  const Links: React.FC<{ href: string }> = ({ children, href }) => (
    <Button
      background={router.asPath === href ? "whiteAlpha.200" : "gray.700"}
      _hover={{ background: "whiteAlpha.300" }}
      _active={{ background: "whiteAlpha.400" }}
      onClick={() => router.push(href)}
      display="flex"
      mx="2"
      justifyContent="center"
      alignItems="center"
    >
      {children}
    </Button>
  );
  return (
    <Box
      position="sticky"
      top="0px"
      zIndex="999"
      boxShadow="md"
      backgroundColor="gray.700"
      as="nav"
      p="3"
      color="white"
    >
      <Container maxW="container.xl">
        <Flex text justifyContent="space-between">
          <Heading
            onClick={() => router.push("/")}
            display="flex"
            justifyContent="center"
            alignItems="center"
          >
            Logo
          </Heading>
          <Flex justifyContent="center" alignItems="center">
            <Links href="/onsale">On sale</Links>
            <Links href="/best-games">Best Games</Links>
            <Links href="/newest">Newest</Links>
            <Links href="/wishlist">My Wishlist</Links>
          </Flex>
          <Flex>
            <IconButton
              aria-label="toggle color mode"
              colorScheme="blue"
              background="whiteAlpha.200"
              _hover={{ background: "whiteAlpha.300" }}
              _active={{ background: "whiteAlpha.400" }}
              _focus={{ boxShadow: undefined }}
              m="2"
              onClick={toggleColorMode}
              icon={
                colorMode === "light" ? (
                  <MoonIcon color="white" />
                ) : (
                  <SunIcon color="white" />
                )
              }
            />
            {!authenticated ? (
              <Button
                m="2"
                background="whiteAlpha.200"
                _hover={{ background: "whiteAlpha.300" }}
                _active={{ background: "whiteAlpha.400" }}
                onClick={() => router.push("/login")}
              >
                <h2>Fazer Login</h2>
              </Button>
            ) : (
              <Button
                m="2"
                onClick={() =>
                  keycloak?.logout({
                    redirectUri: "http://localhost:3000/",
                  })
                }
              >
                Logout
              </Button>
            )}
          </Flex>
        </Flex>
      </Container>
    </Box>
  );
};

export default Navbar;
