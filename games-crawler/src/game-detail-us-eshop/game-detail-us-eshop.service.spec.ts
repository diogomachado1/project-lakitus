import { Test, TestingModule } from '@nestjs/testing';
import { GameDetailUsEshopService } from './game-detail-us-eshop.service';

describe('GameDetailUsEshopService', () => {
  let service: GameDetailUsEshopService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [GameDetailUsEshopService],
    }).compile();

    service = module.get<GameDetailUsEshopService>(GameDetailUsEshopService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
