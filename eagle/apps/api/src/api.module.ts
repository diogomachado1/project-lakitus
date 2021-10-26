import { Module } from '@nestjs/common';
import { ApiController } from './api.controller';
import { GameModule } from './game/game.module';
import { PriceHistoryModule } from './price-history/price-history.module';
import { ProducerGameDetailModule } from './producer-message/producer-message.module';

@Module({
  imports: [GameModule, PriceHistoryModule, ProducerGameDetailModule],
  controllers: [ApiController],
})
export class ApiModule {}
