import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';
import { GameDetailEshopService } from './game-detail-eshop.service';

@Controller('game-detail')
export class GameDetailEshopController {
  constructor(private gameService: GameDetailEshopService) {}

  @MessagePattern('game-detail')
  async getDetail(message: { usId: string; euId: string }) {
    await this.gameService.getAndSaveGameData(message.usId, message.euId);
  }
}
