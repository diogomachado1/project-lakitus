import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';
import { PriceService } from './price.service';

@Controller('price')
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
}
