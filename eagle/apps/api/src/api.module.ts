import { Module } from '@nestjs/common';
import { ApiController } from './api.controller';
import { GameModule } from './game/game.module';
import { PriceHistoryModule } from './price-history/price-history.module';
import { ProducerGameDetailModule } from './producer-message/producer-message.module';
import { CurrencyModule } from './currency/currency.module';

@Module({
  imports: [
    GameModule,
    PriceHistoryModule,
    ProducerGameDetailModule,
    CurrencyModule,
  ],
  controllers: [ApiController],
})
export class ApiModule {}
