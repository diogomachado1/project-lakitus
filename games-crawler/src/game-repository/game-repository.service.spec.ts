import { getModelToken, MongooseModule } from '@nestjs/mongoose';
import { Test, TestingModule } from '@nestjs/testing';
import { Model } from 'mongoose';
import { GameRepositoryService } from './game-repository.service';
import { Game, GameDocument, GameSchema } from './game.schema';
import { usGameDetail } from './mock/usGameDetail';

describe('GameRepositoryService', () => {
  let service: GameRepositoryService;
  let model: Model<GameDocument>;

  afterAll(async () => {
    await model.deleteMany({});
  });

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [
        MongooseModule.forRoot(process.env.MONGO_URL),
        MongooseModule.forFeature([{ name: Game.name, schema: GameSchema }]),
      ],
      providers: [GameRepositoryService],
    }).compile();

    service = module.get<GameRepositoryService>(GameRepositoryService);
    model = module.get<Model<GameDocument>>(getModelToken(Game.name));
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should save data(create)', async () => {
    const oldGames = await model.find({ usEshopId: '70010000040947' });
    expect(oldGames.length).toBe(0);

    await service.saveGameDetailUS({
      usEshopDetail: usGameDetail,
      usEshopId: '70010000040947',
    });

    const game = await model.findOne({ usEshopId: '70010000040947' });
    expect(game).toHaveProperty('usEshopId', '70010000040947');
  });

  it('should save data(update)', async () => {
    const oldGames = await model.find({ usEshopId: '70010000040947' });
    expect(oldGames.length).toBe(1);

    await service.saveGameDetailUS({
      usEshopDetail: usGameDetail,
      usEshopId: '70010000040947',
    });

    const game = await model.findOne({ usEshopId: '70010000040947' });
    expect(game).toHaveProperty('usEshopId', '70010000040947');
    const newGames = await model.find({ usEshopId: '70010000040947' });
    expect(newGames.length).toBe(1);
  });
});
