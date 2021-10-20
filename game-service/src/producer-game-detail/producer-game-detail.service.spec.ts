import { Test, TestingModule } from '@nestjs/testing';
import { nsgResponseMock } from './mocks/nsgResponse';
import { ProducerGameDetailService } from './producer-game-detail.service';

const gamesUsId = [
  { usEshopId: '70010000033731' },
  { usEshopId: '70010000045157' },
  { usEshopId: '70010000045348' },
  { usEshopId: '70010000038924' },
  { usEshopId: '70010000044778' },
  { usEshopId: '70010000045759' },
  { usEshopId: '70010000033499' },
  { usEshopId: '70010000040371' },
  { usEshopId: '70010000043052' },
  { usEshopId: '70010000037238' },
  { usEshopId: '70010000045391' },
  { usEshopId: '70010000037532' },
  { usEshopId: '70010000041461' },
  { usEshopId: '70010000043167' },
  { usEshopId: '70010000028255' },
  { usEshopId: '70010000046033' },
  { usEshopId: '70010000039353' },
  { usEshopId: '70010000044091' },
  { usEshopId: '70010000044750' },
  { usEshopId: '70010000022882' },
];

describe('ProducerGameDetailService', () => {
  let service: ProducerGameDetailService;

  const GameRepository = {
    getAllUsId: async () => {
      return gamesUsId;
    },
  };
  const NsgService = {
    getGames: async () => nsgResponseMock.rows,
  };

  const RabbitService = {
    sendBatchToGameDetail: async () => {
      return;
    },
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        ProducerGameDetailService,
        { useValue: NsgService, provide: 'NSG_SERVICE' },
        { useValue: GameRepository, provide: 'GAME_REPOSITORY' },
        { useValue: RabbitService, provide: 'RABBIT_SERVICE' },
      ],
    }).compile();

    service = module.get<ProducerGameDetailService>(ProducerGameDetailService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should generate hash table', () => {
    const gameHash = service.createHatableUsIdEshop(gamesUsId);
    const gameHashExpected = [
      '70010000033731',
      '70010000045157',
      '70010000045348',
      '70010000038924',
      '70010000044778',
      '70010000045759',
      '70010000033499',
      '70010000040371',
      '70010000043052',
      '70010000037238',
      '70010000045391',
      '70010000037532',
      '70010000041461',
      '70010000043167',
      '70010000028255',
      '70010000046033',
      '70010000039353',
      '70010000044091',
      '70010000044750',
      '70010000022882',
    ];
    expect(gameHash).toStrictEqual(gameHashExpected);
  });

  it('should get new games', () => {
    const newGames = service.getNewGames(nsgResponseMock.rows, gamesUsId);

    expect(newGames.length).toBe(5);
    expect(newGames).toStrictEqual([
      {
        euId: 70010000043568,
        usId: 70010000043567,
      },
      {
        euId: 70010000044027,
        usId: 70010000044024,
      },
      {
        euId: 70010000041322,
        usId: 70010000041321,
      },
      {
        euId: 70010000044853,
        usId: 70010000044852,
      },
      {
        euId: 70010000044026,
        usId: 70010000044025,
      },
    ]);
  });

  it('should get new games', () => {
    const newGames = service.getAllGames(nsgResponseMock.rows);

    expect(newGames.length).toBe(25);
  });

  it('should get all games', () => {
    const newGames = service.getAllGames(nsgResponseMock.rows);

    expect(newGames.length).toBe(25);
  });

  it('should send new games message', async () => {
    const sendBatchToGameDetailSpy = jest.spyOn(
      RabbitService,
      'sendBatchToGameDetail',
    );
    const messages = await service.sendGamesMessage();

    expect(sendBatchToGameDetailSpy).toHaveBeenCalledTimes(1);
    expect(messages.length).toBe(5);
  });

  it('should send all games message', async () => {
    const sendBatchToGameDetailSpy = jest.spyOn(
      RabbitService,
      'sendBatchToGameDetail',
    );
    const messages = await service.sendGamesMessage(true);

    expect(sendBatchToGameDetailSpy).toHaveBeenCalledTimes(1);
    expect(messages.length).toBe(25);
  });
});
