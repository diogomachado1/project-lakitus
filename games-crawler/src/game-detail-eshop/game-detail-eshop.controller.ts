import { Controller } from '@nestjs/common';
import { MessagePattern, Payload } from '@nestjs/microservices';
import { CatchCustom } from '../kafka.decorator';
import { GameDetailEshopService } from './game-detail-eshop.service';

@Controller('game-detail')
export class GameDetailEshopController {
  constructor(private gameService: GameDetailEshopService) {}

  @MessagePattern('game-detail')
  @CatchCustom('game-detail-eshop')
  async getDetail(
    @Payload() message: { value: { usId: string; euId: string } },
  ) {
    console.log(message.value);
    await this.gameService.getAndSaveGameData(
      message.value.usId,
      message.value.euId,
    );
    console.log('finish', message.value);
  }
}
