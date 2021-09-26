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
    console.log(code);
    await this.gameService.getAndSavePriceData(games, code);
  }
}
