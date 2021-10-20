import axios from 'axios';
import { Test, TestingModule } from '@nestjs/testing';
import { EshopService } from './eshop.service';
import * as eshop from 'nintendo-switch-eshop';
import { usGamesDetails } from './mocks/usGamesDetails';
import { CacheModule } from '@nestjs/common';
import { euGameDetail } from './mocks/euGameDetail';
import { jpGameDetail } from './mocks/jpGameDetail';
import { hkGameDetail } from './mocks/hkGameDetail';

describe('EshopService', () => {
  let service: EshopService;
  let getCacheSpy: jest.SpyInstance<Promise<unknown>, [key: string]>;
  let setCacheSpy: jest.SpyInstance<
    void,
    [key: string, value: unknown, ttl: number, callback: (error: any) => void]
  >;

  const getGamesAmericaSpy = jest
    .spyOn(eshop, 'getGamesAmerica')
    .mockResolvedValue(usGamesDetails);

  const getGamesEuropeSpy = jest
    .spyOn(eshop, 'getGamesEurope')
    .mockResolvedValue([euGameDetail]);

  const getGamesJapanSpy = jest
    .spyOn(eshop, 'getGamesJapan')
    .mockResolvedValue([jpGameDetail]);

  const getGamesHkSpy = jest
    .spyOn(axios, 'get')
    .mockResolvedValue({ data: [hkGameDetail] });

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [CacheModule.register({ ttl: 60 * 60 * 5 })],
      providers: [EshopService],
    }).compile();

    service = module.get<EshopService>(EshopService);
    getCacheSpy = jest.spyOn(service.cacheManager, 'get');
    setCacheSpy = jest.spyOn(service.cacheManager, 'set');
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should get usGameDetail from endpoint', async () => {
    const game = await service.findGameByUsId('70010000007606');
    expect(getGamesAmericaSpy).toHaveBeenCalledTimes(1);
    expect(getCacheSpy).toHaveBeenCalledTimes(1);
    expect(setCacheSpy).toHaveBeenCalledTimes(1);
    expect(game).toHaveProperty('nsuid', '70010000007606');
  });

  it('should get usGameDetail from cache', async () => {
    await service.findGameByUsId('70010000007606');

    expect(getCacheSpy).toHaveBeenCalledTimes(1);
    expect(setCacheSpy).toHaveBeenCalledTimes(1);
    getGamesAmericaSpy.mockClear();
    getCacheSpy.mockClear();
    setCacheSpy.mockClear();

    const game = await service.findGameByUsId('70010000007606');
    expect(getGamesAmericaSpy).toHaveBeenCalledTimes(0);
    expect(getCacheSpy).toHaveBeenCalledTimes(1);
    expect(setCacheSpy).toHaveBeenCalledTimes(0);
    expect(game).toHaveProperty('nsuid', '70010000007606');
  });

  // it('should get euGameDetail from endpoint', async () => {
  //   const game = await service.findGameByEuId('70010000040948');
  //   expect(getGamesEuropeSpy).toHaveBeenCalledTimes(1);
  //   expect(getCacheSpy).toHaveBeenCalledTimes(1);
  //   expect(setCacheSpy).toHaveBeenCalledTimes(1);
  //   expect(eshop.parseNSUID(game, 2)).toBe('70010000040948');
  // }, 30000);

  // it('should get euGameDetail from cache', async () => {
  //   await service.findGameByEuId('70010000040948');

  //   expect(getCacheSpy).toHaveBeenCalledTimes(1);
  //   expect(setCacheSpy).toHaveBeenCalledTimes(1);
  //   getGamesEuropeSpy.mockClear();
  //   getCacheSpy.mockClear();
  //   setCacheSpy.mockClear();

  //   const game = await service.findGameByEuId('70010000040948');
  //   expect(getGamesEuropeSpy).toHaveBeenCalledTimes(0);
  //   expect(getCacheSpy).toHaveBeenCalledTimes(1);
  //   expect(setCacheSpy).toHaveBeenCalledTimes(0);
  //   expect(eshop.parseNSUID(game, 2)).toBe('70010000040948');
  // }, 30000);
});
