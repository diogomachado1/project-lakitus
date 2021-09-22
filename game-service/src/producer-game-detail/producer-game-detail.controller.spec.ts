import { Test, TestingModule } from '@nestjs/testing';
import { ProducerGameDetailController } from './producer-game-detail.controller';

describe('ProducerGameDetailController', () => {
  let controller: ProducerGameDetailController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ProducerGameDetailController],
    }).compile();

    controller = module.get<ProducerGameDetailController>(ProducerGameDetailController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
