import { Controller } from '@nestjs/common';
import { MessagePattern, Payload } from '@nestjs/microservices';
import { CatchCustom } from 'src/kafka.decorator';
import { GameDetailUsEshopService } from './game-detail-us-eshop.service';

@Controller('game-detail-us-eshop')
export class GameDetailUsEshopController {
  constructor(private gameService: GameDetailUsEshopService) {}

  @MessagePattern('game.detail')
  @CatchCustom('game-detail-us-eshop')
  async getDetail(
    @Payload() message: { value: { usId: string; euId: string } },
  ) {
    await this.gameService.getAndSaveGameData(message.value.usId);
  }
}
