import { Module } from '@nestjs/common';
import { InfraModule } from '../infra/infra.module';
import { PriceHistoryController } from './price-history.controller';
import { PriceHistoryService } from './price-history.service';

@Module({
  imports: [InfraModule],
  controllers: [PriceHistoryController],
  providers: [PriceHistoryService],
})
export class PriceHistoryModule {}
