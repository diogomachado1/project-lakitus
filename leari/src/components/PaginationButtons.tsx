import { Box, Flex } from "@chakra-ui/react";
import React, { useState } from "react";

// import { Container } from './styles';

const PaginationButtons: React.FC<{
  page: number;
  onChange: (newPage: number) => void;
  totalPages: number;
}> = ({ page, totalPages, onChange }) => {
  const iconPage = (pageNumber: number) => (
    <Box
      cursor="pointer"
      _hover={{ background: "gray.600" }}
      transition="ease-in-out"
      transitionDuration="0.15s"
      minW="30px"
      minH="30px"
      m="1"
      borderRadius="50%"
      backgroundColor={page === pageNumber ? "gray.700" : "gray.500"}
      display="flex"
      justifyContent="center"
      alignItems="center"
      onClick={() => onChange(pageNumber)}
    >
      {pageNumber}
    </Box>
  );
  return (
    <>
      <Flex>
        {page >= 6 && iconPage(1)}
        {
          //@ts-ignore
          [...Array(totalPages).keys()]
            .filter((item) => item > 0)
            .filter((item) => item >= -4 + page && item <= page + 5)
            .map((item) => iconPage(item))
        }
        {totalPages >= 10 && page <= totalPages && iconPage(totalPages)}
      </Flex>
    </>
  );
};

export default PaginationButtons;
