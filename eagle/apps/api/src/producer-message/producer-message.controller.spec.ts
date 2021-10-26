import { Model } from 'mongoose';
import { getModelToken } from '@nestjs/mongoose';
import { Test, TestingModule } from '@nestjs/testing';
import {
  PriceHistory,
  PriceHistoryDocument,
} from '@infra/infra/game-history-repository/priceHistory.schema';
import { ProducerGameDetailService } from './producer-message.service';
import { ProducerGameDetailController } from './producer-message.controller';

describe('PriceHistoryController', () => {
  let controller: ProducerGameDetailController;

  const producerGameDetailServiceMock = {
    sendGamesMessage: async () => [
      {
        usId: 'test1',
        euId: 'test2',
      },
      {
        usId: 'test3',
        euId: 'test4',
      },
    ],
    sendPricesMessages: async () => ({ status: 'success' }),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [],
      controllers: [ProducerGameDetailController],
      providers: [ProducerGameDetailService],
    })
      .overrideProvider(ProducerGameDetailService)
      .useValue(producerGameDetailServiceMock)
      .compile();

    controller = module.get<ProducerGameDetailController>(
      ProducerGameDetailController,
    );
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should sendGamesIds', async () => {
    const sendGamesMessageSpy = jest.spyOn(
      producerGameDetailServiceMock,
      'sendGamesMessage',
    );

    const prices = await controller.sendGamesIds();

    expect(prices).toStrictEqual([
      { euId: 'test2', usId: 'test1' },
      { euId: 'test4', usId: 'test3' },
    ]);
    expect(sendGamesMessageSpy).toHaveBeenCalledTimes(1);
    expect(sendGamesMessageSpy).toHaveBeenNthCalledWith(1, undefined);
  });
});
