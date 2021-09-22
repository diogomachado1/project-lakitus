import { Controller, Post } from '@nestjs/common';
import { ProducerGameDetailService } from './producer-game-detail.service';

@Controller('send-games-ids')
export class ProducerGameDetailController {
  constructor(private producerGameDetailService: ProducerGameDetailService) {}
  @Post('/')
  async sendGamesIds() {
    const sendsIds = await this.producerGameDetailService.sendGamesMessage();
    return sendsIds;
  }
}
