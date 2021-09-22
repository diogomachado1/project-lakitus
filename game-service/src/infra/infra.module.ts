import { Module } from '@nestjs/common';
import { GameRepositoryModule } from './game-repository/game-repository.module';
import { NsgModule } from './nsg/nsg.module';
import { KafkaModule } from './kafka/kafka.module';

@Module({
  imports: [GameRepositoryModule, NsgModule, KafkaModule],
  exports: [GameRepositoryModule, NsgModule, KafkaModule],
})
export class InfraModule {}
