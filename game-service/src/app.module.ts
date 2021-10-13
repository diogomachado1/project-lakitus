import { Module } from '@nestjs/common';
import { ProducerGameDetailModule } from './producer-game-detail/producer-game-detail.module';
import { InfraModule } from './infra/infra.module';
import { GameModule } from './game/game.module';
import { PriceHistoryModule } from './price-history/price-history.module';

@Module({
  imports: [
    ProducerGameDetailModule,
    PriceHistoryModule,
    InfraModule,
    GameModule,
  ],
})
export class AppModule {}
