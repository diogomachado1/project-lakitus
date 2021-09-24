import { Module } from '@nestjs/common';
import { GameRepositoryModule } from './game-repository/game-repository.module';
import { NsgModule } from './nsg/nsg.module';
import { RabbitModule } from './rabbit/rabbit.module';

@Module({
  imports: [GameRepositoryModule, NsgModule, RabbitModule],
  exports: [GameRepositoryModule, NsgModule, RabbitModule],
})
export class InfraModule {}
