import { Module } from '@nestjs/common';
import { PriceHistoryRepositoryModule } from './game-history-repository/price-history-repository.module';
import { GameRepositoryModule } from './game-repository/game-repository.module';
import { NsgModule } from './nsg/nsg.module';
import { RabbitModule } from './rabbit/rabbit.module';

@Module({
  imports: [
    GameRepositoryModule,
    PriceHistoryRepositoryModule,
    NsgModule,
    RabbitModule,
  ],
  exports: [
    GameRepositoryModule,
    PriceHistoryRepositoryModule,
    NsgModule,
    RabbitModule,
  ],
})
export class InfraModule {}
