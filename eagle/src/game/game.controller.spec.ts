import axios from 'axios';
import { Model } from 'mongoose';
import * as eshop from 'nintendo-switch-eshop';
import { getModelToken } from '@nestjs/mongoose';
import { Test, TestingModule } from '@nestjs/testing';
import { Game, GameDocument } from '../infra/game-repository/game.schema';
import { EshopServicesModule } from '../infra/eshop/eshop.module';
import { GameRepositoryModule } from '../infra/game-repository/game-repository.module';
import { GameController } from './game.controller';
import { GameService } from './game.service';
import { usGameDetail } from './mocks/usGameDetail';
import { euGameDetail } from './mocks/euGameDetail';
import { jpGameDetail } from './mocks/jpGameDetail';
import { hkGameDetail } from './mocks/hkGameDetail';

describe('GameController', () => {
  let controller: GameController;
  let model: Model<GameDocument>;

  const getGamesAmericaSpy = jest
    .spyOn(eshop, 'getGamesAmerica')
    .mockResolvedValue([usGameDetail]);

  const getGamesEuropeSpy = jest
    .spyOn(eshop, 'getGamesEurope')
    .mockResolvedValue([euGameDetail]);

  const getGamesJapanSpy = jest
    .spyOn(eshop, 'getGamesJapan')
    .mockResolvedValue([jpGameDetail]);

  const getGamesHkSpy = jest
    .spyOn(axios, 'get')
    .mockResolvedValue({ data: [hkGameDetail] });

  afterAll(async () => {
    await model.deleteMany({});
  });

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [EshopServicesModule, GameRepositoryModule],
      controllers: [GameController],
      providers: [GameService],
    }).compile();

    controller = module.get<GameController>(GameController);

    model = module.get<Model<GameDocument>>(getModelToken(Game.name));
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  // it('should save UsGameDetail', async () => {
  //   await controller.getDetail({
  //     usId: '70010000007606',
  //     euId: '70010000007605',
  //   });

  //   const game = await model.findOne({ usEshopId: '70010000007606' });
  //   expect(game).toHaveProperty('usEshopId', '70010000007606');
  //   expect(game).toHaveProperty('euEshopId', '70010000007605');
  //   expect(game).toHaveProperty('jpEshopId', '70010000007607');
  //   expect(game).toHaveProperty('hkEshopId', '70010000021361');
  //   expect(game).toHaveProperty('euEshopDetail');
  //   expect(game).toHaveProperty('usEshopDetail');
  //   expect(game).toHaveProperty('hkEshopDetail');
  //   expect(game).toHaveProperty('jpEshopDetail');
  // });
});
