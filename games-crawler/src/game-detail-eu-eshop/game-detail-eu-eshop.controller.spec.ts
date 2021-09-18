import { Test, TestingModule } from '@nestjs/testing';
import { GameDetailEuEshopController } from './game-detail-eu-eshop.controller';

describe('GameDetailEuEshopController', () => {
  let controller: GameDetailEuEshopController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [GameDetailEuEshopController],
    }).compile();

    controller = module.get<GameDetailEuEshopController>(
      GameDetailEuEshopController,
    );
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
