import { CacheModule, CACHE_MANAGER } from '@nestjs/common';
import { Test, TestingModule } from '@nestjs/testing';
import { Cache } from 'cache-manager';
import { GameService } from './game.service';
import { euGameDetail } from './mocks/euGameDetail';
import { hkGameDetail } from './mocks/hkGameDetail';
import { jpGameDetail } from './mocks/jpGameDetail';
import { usGameDetail } from './mocks/usGameDetail';

describe('GameService', () => {
  let service: GameService;
  let cacheService: Cache;
  const GameRepository = {
    saveGameDetailUS: async () => {
      return;
    },
    saveGameDetail: async () => {
      return;
    },
    findOneGame: async () => ({ _id: 'test' }),
    findOneGameSimple: async () => ({ id: 'test' }),
    findGames: async () => [{ _id: 'test' }],
    findGamesSimpleDetail: async () => [{ id: 'test' }],
  };
  const EshoService = {
    findGameByUsId: async () => usGameDetail,
    findGameByEuId: async () => euGameDetail,
    findGameByJpId: async () => jpGameDetail,
    findGameByHkId: async () => hkGameDetail,
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [CacheModule.register()],
      providers: [
        { useValue: EshoService, provide: 'ESHOP_SERVICE' },
        { useValue: GameRepository, provide: 'GAME_REPOSITORY' },
        GameService,
      ],
    }).compile();

    service = module.get(GameService);
    cacheService = module.get<Cache>(CACHE_MANAGER);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should getOneGame data', async () => {
    const findOneGameSimpleSpy = jest.spyOn(
      GameRepository,
      'findOneGameSimple',
    );
    const getCacheSpy = jest.spyOn(cacheService, 'get');
    const setCacheSpy = jest.spyOn(cacheService, 'set');
    await service.getOneGame('test');

    expect(findOneGameSimpleSpy).toHaveBeenCalledTimes(1);
    expect(findOneGameSimpleSpy).toHaveBeenNthCalledWith(1, 'test');
    expect(getCacheSpy).toHaveBeenCalledTimes(1);
    expect(getCacheSpy).toHaveBeenNthCalledWith(1, 'game:test');
    expect(setCacheSpy).toHaveBeenCalledTimes(1);
    expect(setCacheSpy).toHaveBeenNthCalledWith(
      1,
      'game:test',
      { id: 'test' },
      { ttl: 300 },
    );
  });

  it('should getOneGame data with cache', async () => {
    const findOneGameSimpleSpy = jest.spyOn(
      GameRepository,
      'findOneGameSimple',
    );
    const getCacheSpy = jest.spyOn(cacheService, 'get');
    const setCacheSpy = jest.spyOn(cacheService, 'set');

    getCacheSpy.mockResolvedValueOnce({ id: 'test' });
    const value = await service.getOneGame('test');
    expect(value).toHaveProperty('id', 'test');

    expect(findOneGameSimpleSpy).toHaveBeenCalledTimes(0);
    expect(getCacheSpy).toHaveBeenCalledTimes(1);
    expect(getCacheSpy).toHaveBeenNthCalledWith(1, 'game:test');
    expect(setCacheSpy).toHaveBeenCalledTimes(0);
  });

  it('should getOneGameFull data', async () => {
    const findOneGameSpy = jest.spyOn(GameRepository, 'findOneGame');
    const getCacheSpy = jest.spyOn(cacheService, 'get');
    const setCacheSpy = jest.spyOn(cacheService, 'set');
    await service.getOneGameFull('test');

    expect(findOneGameSpy).toHaveBeenCalledTimes(1);
    expect(findOneGameSpy).toHaveBeenNthCalledWith(1, 'test');
    expect(getCacheSpy).toHaveBeenCalledTimes(1);
    expect(getCacheSpy).toHaveBeenNthCalledWith(1, 'game-full:test');
    expect(setCacheSpy).toHaveBeenCalledTimes(1);
    expect(setCacheSpy).toHaveBeenNthCalledWith(
      1,
      'game-full:test',
      { _id: 'test' },
      { ttl: 300 },
    );
  });

  it('should getOneGameFull data with cache', async () => {
    const findOneGameSpy = jest.spyOn(GameRepository, 'findOneGame');
    const getCacheSpy = jest.spyOn(cacheService, 'get');
    const setCacheSpy = jest.spyOn(cacheService, 'set');

    getCacheSpy.mockResolvedValueOnce({ _id: 'test' });
    const value = await service.getOneGameFull('test');
    expect(value).toHaveProperty('_id', 'test');

    expect(findOneGameSpy).toHaveBeenCalledTimes(0);
    expect(getCacheSpy).toHaveBeenCalledTimes(1);
    expect(getCacheSpy).toHaveBeenNthCalledWith(1, 'game-full:test');
    expect(setCacheSpy).toHaveBeenCalledTimes(0);
  });

  it('should getManyGame data', async () => {
    const findGamesSimpleDetailSpy = jest.spyOn(
      GameRepository,
      'findGamesSimpleDetail',
    );
    await service.getManyGame(['test1', 'test2'], 'test', 1);

    expect(findGamesSimpleDetailSpy).toHaveBeenCalledTimes(1);
    expect(findGamesSimpleDetailSpy).toHaveBeenNthCalledWith(
      1,
      { ids: ['test1', 'test2'], search: 'test' },
      1,
    );
  });

  it('should getManyGameFull data', async () => {
    const findGamesGameSpy = jest.spyOn(GameRepository, 'findGames');
    await service.getManyGameFull(['test1', 'test2'], 'test', 1);

    expect(findGamesGameSpy).toHaveBeenCalledTimes(1);
    expect(findGamesGameSpy).toHaveBeenNthCalledWith(
      1,
      {
        ids: ['test1', 'test2'],
        search: 'test',
      },
      1,
    );
  });

  it('should getUsGameDetail data', async () => {
    const findGameSpy = jest.spyOn(EshoService, 'findGameByUsId');
    await service.getUsGameDetail('70010000007606');

    expect(findGameSpy).toHaveBeenCalledTimes(1);
    expect(findGameSpy).toHaveBeenNthCalledWith(1, '70010000007606');
  });

  it('should getEuGameDetail data', async () => {
    const findGameSpy = jest.spyOn(EshoService, 'findGameByEuId');
    await service.getEuGameDetail('70010000007606');

    expect(findGameSpy).toHaveBeenCalledTimes(1);
    expect(findGameSpy).toHaveBeenNthCalledWith(1, '70010000007606');
  });

  it('should getJpGameDetail data', async () => {
    const findGameSpy = jest.spyOn(EshoService, 'findGameByJpId');
    await service.getJpGameDetail('70010000007606');

    expect(findGameSpy).toHaveBeenCalledTimes(1);
    expect(findGameSpy).toHaveBeenNthCalledWith(1, '70010000007606');
  });

  it('should getHkGameDetail data', async () => {
    const findGameSpy = jest.spyOn(EshoService, 'findGameByHkId');
    await service.getHkGameDetail('70010000007606');

    expect(findGameSpy).toHaveBeenCalledTimes(1);
    expect(findGameSpy).toHaveBeenNthCalledWith(1, '70010000007606');
  });

  it('should tryGetJPandHKDetail data', async () => {
    const getHkGameDetailSpy = jest.spyOn(service, 'getHkGameDetail');
    const getJpGameDetailSpy = jest.spyOn(service, 'getJpGameDetail');
    const data = await service.tryGetJPandHKDetail(euGameDetail);

    expect(data).toStrictEqual({
      jpEshopDetail: jpGameDetail,
      hkEshopDetail: hkGameDetail,
      hkEshopId: '70010000021361',
      jpEshopId: '70010000007607',
    });

    expect(getHkGameDetailSpy).toHaveBeenCalledTimes(1);
    expect(getHkGameDetailSpy).toHaveBeenNthCalledWith(1, 'ANVY');

    expect(getJpGameDetailSpy).toHaveBeenCalledTimes(1);
    expect(getJpGameDetailSpy).toHaveBeenNthCalledWith(1, 'ANVY');
  });

  it('should tryGetJPandHKDetail return undefiend with not have euGameDetail', async () => {
    const data = await service.tryGetJPandHKDetail(undefined);

    expect(data).toStrictEqual(undefined);
  });

  it('should getAndSaveGameData', async () => {
    const getUsGameDetailSpy = jest.spyOn(service, 'getUsGameDetail');
    const getEuGameDetailSpy = jest.spyOn(service, 'getEuGameDetail');
    const tryGetJPandHKDetailSpy = jest.spyOn(service, 'tryGetJPandHKDetail');

    const saveGameDetailSpy = jest.spyOn(GameRepository, 'saveGameDetail');

    const data = await service.getAndSaveGameData('usId', 'euId');

    expect(data).toStrictEqual(undefined);
    expect(saveGameDetailSpy).toHaveBeenCalledTimes(1);
    expect(saveGameDetailSpy).toHaveBeenNthCalledWith(1, {
      euEshopDetail: euGameDetail,
      euEshopId: 'euId',
      hkEshopDetail: hkGameDetail,
      hkEshopId: '70010000021361',
      jpEshopDetail: jpGameDetail,
      jpEshopId: '70010000007607',
      usEshopDetail: usGameDetail,
      usEshopId: 'usId',
    });

    expect(getUsGameDetailSpy).toHaveBeenCalledTimes(1);
    expect(getUsGameDetailSpy).toHaveBeenNthCalledWith(1, 'usId');

    expect(getEuGameDetailSpy).toHaveBeenCalledTimes(1);
    expect(getEuGameDetailSpy).toHaveBeenNthCalledWith(1, 'euId');

    expect(tryGetJPandHKDetailSpy).toHaveBeenCalledTimes(1);
    expect(tryGetJPandHKDetailSpy).toHaveBeenNthCalledWith(1, euGameDetail);
  });

  it('should getAndSaveGameData without jp and hk dames detail', async () => {
    jest.spyOn(service, 'tryGetJPandHKDetail').mockResolvedValueOnce(undefined);

    const saveGameDetailSpy = jest.spyOn(GameRepository, 'saveGameDetail');

    const data = await service.getAndSaveGameData('usId', 'euId');

    expect(data).toStrictEqual(undefined);
    expect(saveGameDetailSpy).toHaveBeenCalledTimes(1);
    expect(saveGameDetailSpy).toHaveBeenNthCalledWith(1, {
      euEshopDetail: euGameDetail,
      euEshopId: 'euId',
      usEshopDetail: usGameDetail,
      usEshopId: 'usId',
    });
  });

  it('should getAndSaveGameData without data', async () => {
    const getUsGameDetailSpy = jest
      .spyOn(service, 'getUsGameDetail')
      .mockResolvedValueOnce(undefined);
    const getEuGameDetailSpy = jest
      .spyOn(service, 'getEuGameDetail')
      .mockResolvedValueOnce(undefined);
    const tryGetJPandHKDetailSpy = jest.spyOn(service, 'tryGetJPandHKDetail');

    const saveGameDetailSpy = jest.spyOn(GameRepository, 'saveGameDetail');

    const data = await service.getAndSaveGameData('usId', 'euId');

    expect(data).toStrictEqual(undefined);
    expect(saveGameDetailSpy).toHaveBeenCalledTimes(1);
    expect(saveGameDetailSpy).toHaveBeenNthCalledWith(1, {
      euEshopId: 'euId',
      usEshopId: 'usId',
    });

    expect(getUsGameDetailSpy).toHaveBeenCalledTimes(1);
    expect(getUsGameDetailSpy).toHaveBeenNthCalledWith(1, 'usId');

    expect(getEuGameDetailSpy).toHaveBeenCalledTimes(1);
    expect(getEuGameDetailSpy).toHaveBeenNthCalledWith(1, 'euId');

    expect(tryGetJPandHKDetailSpy).toHaveBeenCalledTimes(0);
  });
});
