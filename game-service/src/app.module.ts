import { Module } from '@nestjs/common';
import { ProducerGameDetailModule } from './producer-game-detail/producer-game-detail.module';
import { InfraModule } from './infra/infra.module';

@Module({
  imports: [ProducerGameDetailModule, InfraModule],
})
export class AppModule {}
