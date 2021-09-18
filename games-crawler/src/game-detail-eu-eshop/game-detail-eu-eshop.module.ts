import { Module } from '@nestjs/common';
import { GameDetailEuEshopController } from './game-detail-eu-eshop.controller';
import { GameDetailEuEshopService } from './game-detail-eu-eshop.service';

@Module({
  controllers: [GameDetailEuEshopController],
  providers: [GameDetailEuEshopService],
})
export class GameDetailEuEshopModule {
  static id = 'game-detail-eu-eshop';
}
