import { Module } from '@nestjs/common';
import { InfraModule } from '@infra/infra/infra.module';
import { EshopServicesModule } from '@infra/infra/eshop/eshop.module';
import { PriceController } from './price.controller';
import { PriceService } from './price.service';

@Module({
  imports: [EshopServicesModule, InfraModule],
  controllers: [PriceController],
  providers: [PriceService],
})
export class PriceModule {}
