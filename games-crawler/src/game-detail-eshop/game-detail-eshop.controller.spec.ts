import { getModelToken } from '@nestjs/mongoose';
import { Test, TestingModule } from '@nestjs/testing';
import { Model } from 'mongoose';
import { Game, GameDocument } from '../game-repository/game.schema';
import { EshopServicesModule } from '../eshop/eshop.module';
import { GameRepositoryModule } from '../game-repository/game-repository.module';
import { GameDetailUsEshopController } from './game-detail-us-eshop.controller';
import { GameDetailUsEshopService } from './game-detail-us-eshop.service';

describe('GameDetailUsEshopController', () => {
  let controller: GameDetailUsEshopController;
  let model: Model<GameDocument>;

  afterAll(async () => {
    await model.deleteMany({});
  });

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [EshopServicesModule, GameRepositoryModule],
      controllers: [GameDetailUsEshopController],
      providers: [GameDetailUsEshopService],
    }).compile();

    controller = module.get<GameDetailUsEshopController>(
      GameDetailUsEshopController,
    );

    model = module.get<Model<GameDocument>>(getModelToken(Game.name));
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should save UsGameDetail', async () => {
    await controller.getDetail({
      value: { usId: '70010000040947', euId: '70010000040947' },
    });

    const game = await model.findOne({ usEshopId: '70010000040947' });
    expect(game).toHaveProperty('usEshopId', '70010000040947');
  });
});
