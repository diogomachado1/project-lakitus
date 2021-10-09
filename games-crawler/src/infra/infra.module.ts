import { Module } from '@nestjs/common';
import { GameRepositoryModule } from './game-repository/game-repository.module';
import { PriceRepositoryModule } from './price-repository/price-repository.module';
import { RabbitModule } from './rabbit/rabbit.module';

@Module({
  imports: [GameRepositoryModule, PriceRepositoryModule, RabbitModule],
  exports: [GameRepositoryModule, PriceRepositoryModule, RabbitModule],
})
export class InfraModule {}
