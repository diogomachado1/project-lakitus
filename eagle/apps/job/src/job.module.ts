import { Module } from '@nestjs/common';
import { GameModule } from './game/game.module';

import { JobController } from './job.controller';
import { PriceHistoryModule } from './price-history/price-history.module';
import { PriceModule } from './price/price.module';

@Module({
  imports: [GameModule, PriceModule, PriceHistoryModule],
  controllers: [JobController],
})
export class JobModule {}
