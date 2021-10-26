import { CacheModule } from '@nestjs/common';
import { Test, TestingModule } from '@nestjs/testing';
import { GameService } from './game.service';
import { euGameDetail } from './mocks/euGameDetail';
import { hkGameDetail } from './mocks/hkGameDetail';
import { jpGameDetail } from './mocks/jpGameDetail';
import { usGameDetail } from './mocks/usGameDetail';

describe('GameService', () => {
  let service: GameService;
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
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
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
