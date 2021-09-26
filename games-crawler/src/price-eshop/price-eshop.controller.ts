import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';
import { PriceEshopService } from './price-eshop.service';

@Controller('game-price')
export class PriceEshopController {
  constructor(private gameService: PriceEshopService) {}

  @MessagePattern('game-price')
  async getDetail({
    games,
    region,
    country,
  }: {
    country: string;
    games: { _id: string; externalId: string }[];
    region: number;
  }) {
    await this.gameService.getAndSavePriceData(games, region, country);
  }
}
