import { CacheModule } from '@nestjs/common';
import { Test, TestingModule } from '@nestjs/testing';
import { GameService } from './game.service';
import { euGameDetail } from './mocks/euGameDetail';
import { gameRepository } from './mocks/gameRepository';
import { hkGameDetail } from './mocks/hkGameDetail';
import { jpGameDetail } from './mocks/jpGameDetail';
import { usGameDetail, usGamesDetail } from './mocks/usGameDetail';

describe('GameService', () => {
  let service: GameService;
  const GameRepository = {
    saveGameDetailUS: async () => {
      return;
    },
    saveGameDetail: async () => {
      return;
    },
    findNintendoUsGamesId: async () => gameRepository,
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
    getGameUs: async () => usGamesDetail,
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
});
