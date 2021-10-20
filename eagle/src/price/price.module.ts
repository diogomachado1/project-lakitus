import { Module } from '@nestjs/common';
import { InfraModule } from '../infra/infra.module';
import { EshopServicesModule } from '../infra/eshop/eshop.module';
import { PriceEshopController } from './price.controller';
import { PriceEshopService } from './price.service';

@Module({
  imports: [EshopServicesModule, InfraModule],
  controllers: [PriceEshopController],
  providers: [PriceEshopService],
})
export class PriceEshopModule {}
