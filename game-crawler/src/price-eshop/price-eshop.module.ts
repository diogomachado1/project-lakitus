import { Module } from '@nestjs/common';
import { InfraModule } from '../infra/infra.module';
import { EshopServicesModule } from '../eshop/eshop.module';
import { PriceEshopController } from './price-eshop.controller';
import { PriceEshopService } from './price-eshop.service';

@Module({
  imports: [EshopServicesModule, InfraModule],
  controllers: [PriceEshopController],
  providers: [PriceEshopService],
})
export class PriceEshopModule {}
