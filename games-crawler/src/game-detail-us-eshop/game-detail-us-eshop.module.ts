import { Module } from '@nestjs/common';
import { GameDetailUsEshopController } from './game-detail-us-eshop.controller';
import { GameDetailUsEshopService } from './game-detail-us-eshop.service';

@Module({
  controllers: [GameDetailUsEshopController],
  providers: [GameDetailUsEshopService],
})
export class GameDetailUsEshopModule {
  static id = 'game-detail-us-eshop';
}
