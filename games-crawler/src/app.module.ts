import { Module } from '@nestjs/common';
import { GameDetailEshopModule } from './game-detail-eshop/game-detail-eshop.module';
import { PriceEshopModule } from './price-eshop/price-eshop.module';

@Module({
  imports: [GameDetailEshopModule, PriceEshopModule],
})
export class AppModule {}
