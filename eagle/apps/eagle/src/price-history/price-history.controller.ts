import { Controller, Param, Get, Query } from '@nestjs/common';
import { PriceHistoryService } from './price-history.service';
import { MessagePattern } from '@nestjs/microservices';

@Controller('game/price-history')
export class PriceHistoryController {
  constructor(private service: PriceHistoryService) {}
  @Get('/:gameId')
  async getOnePriceHistory(
    @Param('gameId') gameId: string,
    @Query()
    { country }: { country: string },
  ) {
    return this.service.getPriceHistoryByGameIdAndCountry(gameId, country);
  }

  @MessagePattern('game-price-history')
  async saveHistoryPrice({
    gameId,
    oldPrice,
  }: {
    gameId: string;
    oldPrice: any;
  }) {
    await this.service.saveHistoryPrice(gameId, oldPrice);
  }
}
