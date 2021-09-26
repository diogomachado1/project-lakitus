import { Module } from '@nestjs/common';
import { ProducerGameDetailModule } from './producer-game-detail/producer-game-detail.module';
import { InfraModule } from './infra/infra.module';
import { GameModule } from './game/game.module';

@Module({
  imports: [ProducerGameDetailModule, InfraModule, GameModule],
})
export class AppModule {}
