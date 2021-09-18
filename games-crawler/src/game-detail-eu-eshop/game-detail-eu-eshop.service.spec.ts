import { Test, TestingModule } from '@nestjs/testing';
import { GameDetailEuEshopService } from './game-detail-eu-eshop.service';

describe('GameDetailEuEshopService', () => {
  let service: GameDetailEuEshopService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [GameDetailEuEshopService],
    }).compile();

    service = module.get<GameDetailEuEshopService>(GameDetailEuEshopService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
