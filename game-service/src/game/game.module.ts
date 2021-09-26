import { Module } from '@nestjs/common';
import { InfraModule } from 'src/infra/infra.module';
import { GameController } from './game.controller';
import { GameService } from './game.service';

@Module({
  imports: [InfraModule],
  controllers: [GameController],
  providers: [GameService],
})
export class GameModule {}
