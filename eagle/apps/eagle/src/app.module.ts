import { Module } from '@nestjs/common';
import { GameModule } from './game/game.module';
import { InfraModule } from './infra/infra.module';
import { PriceHistoryModule } from './price-history/price-history.module';
import { PriceModule } from './price/price.module';
import { ProducerGameDetailModule } from './producer-message/producer-message.module';

@Module({
  imports: [
    ProducerGameDetailModule,
    PriceHistoryModule,
    PriceModule,
    InfraModule,
    GameModule,
  ],
})
export class AppModule {}
