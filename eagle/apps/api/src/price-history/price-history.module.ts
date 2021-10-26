import { CacheModule, Module } from '@nestjs/common';
import { InfraModule } from '@infra/infra/infra.module';
import { PriceHistoryController } from './price-history.controller';
import { PriceHistoryService } from './price-history.service';

@Module({
  imports: [InfraModule, CacheModule.register()],
  controllers: [PriceHistoryController],
  providers: [PriceHistoryService],
})
export class PriceHistoryModule {}
