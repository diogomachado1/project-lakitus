import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';
import { PriceEshopService } from './price-eshop.service';

@Controller('game-price')
export class PriceEshopController {
  constructor(private gameService: PriceEshopService) {}

  @MessagePattern('game-price')
  async getDetail({
    games,
    code,
  }: {
    code: string;
    games: { _id: string; externalId: string }[];
    region: number;
  }) {
    await this.gameService.getAndSavePriceData(games, code);
  }

  @MessagePattern('game-price-starter')
  async startGamePrice() {
    await this.gameService.getPriceMessages();
  }

  @MessagePattern('game-price-history')
  async saveHistoryPrice({ gameId }: { gameId: string }) {
    await this.gameService.saveHistoryPrice(gameId);
  }

  @MessagePattern('game-price-history-starter')
  async startGamePriceHistory() {
    await this.gameService.getPriceHistoryMessages();
  }
}
