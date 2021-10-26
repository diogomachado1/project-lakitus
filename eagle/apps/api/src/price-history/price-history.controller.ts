import { Controller, Param, Get, Query } from '@nestjs/common';
import { PriceHistoryService } from './price-history.service';

@Controller('game/price-history')
export class PriceHistoryController {
  constructor(private service: PriceHistoryService) {}
  @Get('/:gameId')
  async getOnePriceHistory(
    @Param('gameId') gameId: string,
    @Query()
    { country }: { country?: string },
  ) {
    return this.service.getPriceHistoryByGameIdAndCountry(gameId, country);
  }
}
