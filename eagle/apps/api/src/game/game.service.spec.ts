import { CacheModule, CACHE_MANAGER } from '@nestjs/common';
import { Test, TestingModule } from '@nestjs/testing';
import { Cache } from 'cache-manager';
import { GameService } from './game.service';

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

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [CacheModule.register()],
      providers: [
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
});
