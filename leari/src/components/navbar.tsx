import {
  Box,
  Container,
  Flex,
  Heading,
  DarkMode,
  IconButton,
  useColorMode,
  Button,
  Menu,
  MenuButton,
  MenuList,
  MenuItem,
  Drawer,
  DrawerBody,
  DrawerHeader,
  DrawerOverlay,
  DrawerContent,
  DrawerCloseButton,
  useDisclosure,
} from "@chakra-ui/react";
import React, { useContext } from "react";
import {
  MoonIcon,
  SunIcon,
  ChevronDownIcon,
  HamburgerIcon,
} from "@chakra-ui/icons";
import { useKeycloak } from "@react-keycloak/ssr";
import { KeycloakInstance } from "keycloak-js";
import Link from "next/link";
import { useRouter } from "next/router";
import { context } from "./currencyContext";
import { countries } from "../util/countries";

const Navbar: React.FC = () => {
  const { colorMode, toggleColorMode } = useColorMode();
  const { keycloak } = useKeycloak<KeycloakInstance>();
  const router = useRouter();
  const { currency: defaultCurrency, changeCurrency } = useContext(context);
  const { isOpen, onOpen, onClose } = useDisclosure();

  const { login = () => {}, authenticated } = keycloak || {};

  const Links: React.FC<{ href: string }> = ({ children, href }) => (
    <Link href={href} passHref>
      <Heading
        size="sm"
        as="a"
        background={router.asPath === href ? "whiteAlpha.200" : "gray.700"}
        _hover={{ background: "whiteAlpha.300" }}
        _active={{ background: "whiteAlpha.400" }}
        mx="2"
        p={[1, 1, 2, 4]}
        rounded="md"
        transition="0.2s ease-in-out"
        justifyContent="center"
        alignItems="center"
      >
        {children}
      </Heading>
    </Link>
  );
  return (
    <>
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
            <Link href="/" passHref>
              <Heading
                as="a"
                display="flex"
                justifyContent="center"
                alignItems="center"
              >
                Logo
              </Heading>
            </Link>
            <Flex
              display={["none", "none", "none", "flex"]}
              justifyContent="center"
              alignItems="center"
            >
              <Links href="/onsale">On sale</Links>
              <Links href="/best-games">Best Games</Links>
              <Links href="/newest">Newest</Links>
              <Links href="/wishlist">My Wishlist</Links>
            </Flex>
            <Flex>
              <DarkMode>
                <IconButton
                  aria-label="show menu"
                  display={["flex", "flex", "flex", "none"]}
                  m="2"
                  onClick={onOpen}
                  icon={<HamburgerIcon color="white" />}
                >
                  Open
                </IconButton>
                <Menu>
                  <MenuButton m="2" as={Button} rightIcon={<ChevronDownIcon />}>
                    {defaultCurrency === "all"
                      ? "Select Currency"
                      : defaultCurrency}
                  </MenuButton>
                  <MenuList maxH="300px" overflowY="scroll">
                    <MenuItem onClick={() => changeCurrency("all")} key={"all"}>
                      {"None"}
                    </MenuItem>
                    {countries
                      .map((item) => item.currency)
                      .filter((v, i, a) => a.indexOf(v) === i)
                      .map((item) => (
                        <MenuItem
                          onClick={() => changeCurrency(item)}
                          key={item}
                        >
                          {item}
                        </MenuItem>
                      ))}
                  </MenuList>
                </Menu>
              </DarkMode>
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
              {/* {!authenticated ? (
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
            )} */}
            </Flex>
          </Flex>
        </Container>
      </Box>
      <Drawer isOpen={isOpen} onClose={onClose} placement="left">
        <DrawerOverlay />
        <DrawerContent>
          <DrawerCloseButton />
          <DrawerHeader>Topics</DrawerHeader>

          <DrawerBody flexDir="column" display="flex">
            <Links href="/onsale">On sale</Links>
            <Links href="/best-games">Best Games</Links>
            <Links href="/newest">Newest</Links>
            <Links href="/wishlist">My Wishlist</Links>
          </DrawerBody>
        </DrawerContent>
      </Drawer>
    </>
  );
};

export default Navbar;
