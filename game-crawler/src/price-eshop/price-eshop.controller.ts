import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';
import { PriceEshopService } from './price-eshop.service';

@Controller('game-price')
export class PriceEshopController {
  constructor(private gameService: PriceEshopService) {}

  @MessagePattern('game-price')
  async getDetail(
    games: {
      _id: string;
      usEshopId: string;
      euEshopId: string;
      jpEshopId: string;
      hkEshopId: string;
    }[],
  ) {
    await this.gameService.getAndSavePriceData(games);
  }

  @MessagePattern('game-price-starter')
  async startGamePrice() {
    await this.gameService.getPriceMessages();
  }

  @MessagePattern('game-price-history')
  async saveHistoryPrice({
    gameId,
    oldPrice,
  }: {
    gameId: string;
    oldPrice: any;
  }) {
    await this.gameService.saveHistoryPrice(gameId, oldPrice);
  }
}
