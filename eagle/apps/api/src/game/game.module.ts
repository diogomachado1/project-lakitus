import { InfraModule } from '@infra/infra';
import { CacheModule, Module } from '@nestjs/common';

import { GameController } from './game.controller';
import { GameService } from './game.service';

@Module({
  imports: [InfraModule, CacheModule.register()],
  controllers: [GameController],
  providers: [GameService],
})
export class GameModule {}
