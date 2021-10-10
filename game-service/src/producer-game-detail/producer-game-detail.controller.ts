import { Controller, Post, Body } from '@nestjs/common';
import { ProducerGameDetailService } from './producer-game-detail.service';

@Controller('send-games-ids')
export class ProducerGameDetailController {
  constructor(private producerGameDetailService: ProducerGameDetailService) {}
  @Post('/')
  async sendGamesIds(@Body() body: { sendAll: boolean }) {
    const sendsIds = await this.producerGameDetailService.sendGamesMessage(
      body.sendAll,
    );
    return sendsIds;
  }

  @Post('/prices')
  async sendPricesMessages() {
    const sendsIds = await this.producerGameDetailService.getPriceMessages();
    return sendsIds;
  }

  @Post('/prices-history')
  async sendPricesHistoryMessages() {
    const sendsIds =
      await this.producerGameDetailService.getPriceHistoryMessages();
    return sendsIds;
  }
}
