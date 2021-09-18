import { Controller, Inject } from '@nestjs/common';
import {
  Client,
  ClientKafka,
  ClientProxy,
  MessagePattern,
  Payload,
  Transport,
} from '@nestjs/microservices';

@Controller('game-detail-us-eshop')
export class GameDetailUsEshopController {
  @MessagePattern('game.detail')
  getDetail(@Payload() message: { value: { usId: string; euId: string } }) {
    console.log('message us', message.value);
  }
}
