import { Module } from '@nestjs/common';
import { EshopServicesModule } from '../eshop/eshop.module';
import { PriceRepositoryModule } from '../price-repository/price-repository.module';
import { PriceEshopController } from './price-eshop.controller';
import { PriceEshopService } from './price-eshop.service';

@Module({
  imports: [EshopServicesModule, PriceRepositoryModule],
  controllers: [PriceEshopController],
  providers: [PriceEshopService],
})
export class PriceEshopModule {}
