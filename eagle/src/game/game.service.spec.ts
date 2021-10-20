import { Test, TestingModule } from '@nestjs/testing';
import { GameService } from './game.service';
import { usGameDetail } from './mocks/usGameDetail';

describe('GameService', () => {
  let service: GameService;
  const GameRepository = {
    saveGameDetailUS: async () => {
      return;
    },
  };
  const EshoService = {
    findGameByUsId: async () => usGameDetail,
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
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

  it('should get data', async () => {
    const findGameSpy = jest.spyOn(EshoService, 'findGameByUsId');
    await service.getUsGameDetail('70010000007606');

    expect(findGameSpy).toHaveBeenCalledTimes(1);
  });
});
