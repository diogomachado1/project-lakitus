import { Controller, Inject } from '@nestjs/common';
import { MessagePattern, Payload } from '@nestjs/microservices';

@Controller('game-detail-eu-eshop')
export class GameDetailEuEshopController {
  @MessagePattern('game.detail')
  async getDetail(
    @Payload() message: { value: { usId: string; euId: string } },
  ) {
    console.log('message eu', message.value);
  }
}
