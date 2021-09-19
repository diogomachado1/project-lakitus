import { Test, TestingModule } from '@nestjs/testing';
import { GameDetailUsEshopService } from './game-detail-us-eshop.service';

describe('GameDetailUsEshopService', () => {
  let service: GameDetailUsEshopService;
  const GameRepository = {
    saveGameDetailUS: async () => {
      return;
    },
  };
  const EshoService = {
    findGameByUsId: async () => ({ nsuid: '70010000040947' }),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        { useValue: EshoService, provide: 'ESHOP_SERVICE' },
        { useValue: GameRepository, provide: 'GAME_REPOSITORY' },
        GameDetailUsEshopService,
      ],
    }).compile();

    service = module.get(GameDetailUsEshopService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should get data', async () => {
    const saveGameDetailUSSpy = jest.spyOn(GameRepository, 'saveGameDetailUS');
    const findGameSpy = jest.spyOn(EshoService, 'findGameByUsId');
    await service.getAndSaveGameData('70010000040947');

    expect(findGameSpy).toHaveBeenCalledTimes(1);
    expect(saveGameDetailUSSpy).toHaveBeenCalledTimes(1);
  });
});
