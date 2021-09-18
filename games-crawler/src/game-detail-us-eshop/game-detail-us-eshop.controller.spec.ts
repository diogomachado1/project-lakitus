import { Test, TestingModule } from '@nestjs/testing';
import { GameDetailUsEshopController } from './game-detail-us-eshop.controller';

describe('GameDetailUsEshopController', () => {
  let controller: GameDetailUsEshopController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [GameDetailUsEshopController],
    }).compile();

    controller = module.get<GameDetailUsEshopController>(
      GameDetailUsEshopController,
    );
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
