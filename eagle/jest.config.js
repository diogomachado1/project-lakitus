/* eslint-disable @typescript-eslint/no-var-requires */
/** @type {import('ts-jest/dist/types').InitialOptionsTsJest} */
const { pathsToModuleNameMapper } = require('ts-jest/utils');
const { compilerOptions } = require('./tsconfig');

module.exports = {
  testEnvironment: 'node',
  moduleFileExtensions: ['js', 'json', 'ts'],
  clearMocks: true,
  preset: '@shelf/jest-mongodb',
  testRegex: '.*\\.spec\\.ts$',
  transform: {
    '^.+\\.(t|j)s$': 'ts-jest',
  },
  collectCoverageFrom: ['./apps/**/*.(t|j)s', './libs/**/*.(t|j)s'],
  moduleNameMapper: pathsToModuleNameMapper(compilerOptions.paths, {
    prefix: '<rootDir>/',
  }),
  coverageDirectory: './coverage',
  testEnvironment: 'node',
};
