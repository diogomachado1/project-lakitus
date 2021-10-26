import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';
import { GameService } from './game.service';

@Controller('game')
export class GameController {
  constructor(private service: GameService) {}
  @MessagePattern('game-detail')
  async getDetail(message: { usId: string; euId: string }) {
    await this.service.getAndSaveGameData(message.usId, message.euId);
  }
}
