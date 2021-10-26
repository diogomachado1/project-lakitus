import { Model } from 'mongoose';
import { getModelToken } from '@nestjs/mongoose';
import { Test, TestingModule } from '@nestjs/testing';
import { GameController } from './game.controller';
import { GameService } from './game.service';
import { CacheModule } from '@nestjs/common';
import { Game, GameDocument } from '@infra/infra/game-repository/game.schema';
import { InfraModule } from '@infra/infra';
import { game } from './mocks/game';

describe('GameController', () => {
  let controller: GameController;
  let model: Model<GameDocument>;
  let gameId;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [InfraModule, CacheModule.register()],
      controllers: [GameController],
      providers: [GameService],
    }).compile();

    controller = module.get<GameController>(GameController);
    model = module.get<Model<GameDocument>>(getModelToken(Game.name));
  });

  afterAll(async () => {
    await model.deleteMany({});
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should getMany', async () => {
    const { _id } = await model.create(game);
    gameId = _id;
    const games = await controller.getMany({});

    expect(games.length).toBe(1);
    expect(games[0].externalIds).toHaveProperty('usEshopId', '70010000007606');
    expect(games[0].externalIds).toHaveProperty('euEshopId', '70010000007605');
  });

  it('should getMany use ids', async () => {
    const games = await controller.getMany({ ids: `${gameId}` });

    expect(games.length).toBe(1);
    expect(games[0].externalIds).toHaveProperty('usEshopId', '70010000007606');
    expect(games[0].externalIds).toHaveProperty('euEshopId', '70010000007605');
  });

  it('should getManyFull', async () => {
    const games = await controller.getManyFull({});

    expect(games.length).toBe(1);
    expect(games[0]).toHaveProperty('usEshopId', '70010000007606');
    expect(games[0]).toHaveProperty('euEshopId', '70010000007605');
  });

  it('should getManyFull use ids', async () => {
    const games = await controller.getManyFull({ ids: `${gameId}` });

    expect(games.length).toBe(1);
    expect(games[0]).toHaveProperty('usEshopId', '70010000007606');
    expect(games[0]).toHaveProperty('euEshopId', '70010000007605');
  });

  it('should getOneGame', async () => {
    const games = await controller.getOneGame(gameId);

    expect(games.externalIds).toHaveProperty('usEshopId', '70010000007606');
    expect(games.externalIds).toHaveProperty('euEshopId', '70010000007605');
  });

  it('should getFullGame', async () => {
    const games = await controller.getFullGame(gameId);

    expect(games).toHaveProperty('usEshopId', '70010000007606');
    expect(games).toHaveProperty('euEshopId', '70010000007605');
  });
});
