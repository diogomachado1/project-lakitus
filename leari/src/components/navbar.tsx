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
  Input,
  InputGroup,
  InputRightElement,
  Drawer,
  DrawerBody,
  DrawerHeader,
  DrawerOverlay,
  DrawerContent,
  DrawerCloseButton,
  useDisclosure,
} from "@chakra-ui/react";
import React, { useContext, useState } from "react";
import {
  MoonIcon,
  SunIcon,
  ChevronDownIcon,
  HamburgerIcon,
  Search2Icon,
} from "@chakra-ui/icons";
import { useKeycloak } from "@react-keycloak/ssr";
import { KeycloakInstance } from "keycloak-js";
import Link from "next/link";
import { useRouter } from "next/router";
import { context } from "./currencyContext";
import { countries } from "../util/countries";
import Image from "next/image";

const Navbar: React.FC<{ search?: boolean }> = ({ search = true }) => {
  const { colorMode, toggleColorMode } = useColorMode();
  const { keycloak } = useKeycloak<KeycloakInstance>();
  const { currency: defaultCurrency, changeCurrency } = useContext(context);
  const { isOpen, onOpen, onClose } = useDisclosure();

  const router = useRouter();
  const [searchField, setSearchField] = useState("");

  const { login = () => {}, authenticated } = keycloak || {};

  const Links: React.FC<{ href: string }> = ({ children, href }) => (
    <Link href={href} passHref>
      <Box
        as="a"
        background={router.asPath === href ? "whiteAlpha.200" : "gray.900"}
        _hover={{ background: "whiteAlpha.300" }}
        _active={{ background: "whiteAlpha.400" }}
        mr="2"
        p={[2]}
        rounded="md"
        transition="0.2s ease-in-out"
        justifyContent="center"
        alignItems="center"
      >
        {children}
      </Box>
    </Link>
  );
  const ConfigButtons: React.FC<{ mobile?: boolean }> = ({
    mobile = false,
  }) => (
    <Flex
      display={
        mobile
          ? ["flex", "flex", "flex", "none"]
          : ["none", "none", "none", "flex"]
      }
    >
      <Menu>
        <MenuButton m="2" as={Button} rightIcon={<ChevronDownIcon />}>
          {defaultCurrency === "all" ? "Select Currency" : defaultCurrency}
        </MenuButton>
        <MenuList maxH="300px" overflowY="scroll">
          <MenuItem onClick={() => changeCurrency("all")} key={"all"}>
            {"None"}
          </MenuItem>
          {countries
            .map((item) => item.currency)
            .filter((v, i, a) => a.indexOf(v) === i)
            .map((item) => (
              <MenuItem onClick={() => changeCurrency(item)} key={item}>
                {item}
              </MenuItem>
            ))}
        </MenuList>
      </Menu>
      <IconButton
        aria-label="toggle color mode"
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
    </Flex>
  );
  return (
    <>
      <Box
        position="sticky"
        top="0px"
        zIndex="999"
        boxShadow="md"
        backgroundColor="gray.900"
        as="nav"
        p="3"
        color="white"
      >
        <Container maxW="container.xl">
          <Flex flexDir="column">
            <Flex justifyContent="space-between">
              <Link href="/" passHref>
                <Box
                  as="a"
                  display="flex"
                  justifyContent="center"
                  alignItems="center"
                  maxW="50px"
                >
                  <Image
                    alt="logo"
                    width="200px"
                    height="200px"
                    src="/logo.svg"
                  />
                </Box>
              </Link>
              {search && (
                <Flex
                  mx="2"
                  alignItems="center"
                  flexGrow={1}
                  justifyContent="center"
                >
                  <InputGroup color="black" maxW="600px">
                    <Input
                      _placeholder={{ color: "blackAlpha.600" }}
                      backgroundColor="white"
                      placeholder="Search"
                      value={searchField}
                      onChange={(e) => setSearchField(e.target.value)}
                      onKeyUp={(e) => {
                        if (e.key === "Enter") {
                          router.push(`/games?search=${searchField}`);
                        }
                      }}
                    />
                    <InputRightElement>
                      <IconButton
                        background="blackAlpha.100"
                        _hover={{ background: "blackAlpha.300" }}
                        _active={{ background: "blackAlpha.400" }}
                        aria-label="search"
                        h="1.75rem"
                        size="sm"
                        onClick={() =>
                          router.push(`/games?search=${searchField}`)
                        }
                        icon={<Search2Icon color="black" />}
                      />
                    </InputRightElement>
                  </InputGroup>
                </Flex>
              )}
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
                  <ConfigButtons />
                </DarkMode>
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
            <Flex
              display={["none", "none", "none", "flex"]}
              alignItems="center"
              pt="1"
            >
              <Links href="/onsale">On sale</Links>
              <Links href="/best-games">Best Games</Links>
              <Links href="/newest">Newest</Links>
            </Flex>
          </Flex>
        </Container>
      </Box>
      <Drawer isOpen={isOpen} onClose={onClose} placement="left">
        <DrawerOverlay />
        <DrawerContent backgroundColor="gray.900">
          <DrawerCloseButton />
          <DrawerBody pr="12" flexDir="column" display="flex">
            <Links href="/onsale">On sale</Links>
            <Links href="/best-games">Best Games</Links>
            <Links href="/newest">Newest</Links>
            <ConfigButtons mobile />
          </DrawerBody>
        </DrawerContent>
      </Drawer>
    </>
  );
};

export default Navbar;
