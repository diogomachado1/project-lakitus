import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';
import { PriceService } from './price.service';

@Controller('game/price')
export class PriceController {
  constructor(private gameService: PriceService) {}

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

  @MessagePattern('save-best-price')
  async saveBestPrice({ gameId }: { gameId: string }) {
    await this.gameService.saveBestPrice(gameId);
  }

  @MessagePattern('save-best-price-starter')
  async startBestPrice() {
    await this.gameService.getBestPriceMessages();
  }
}
