import { Module } from '@nestjs/common';
import { EshopServicesModule } from '../eshop/eshop.module';
import { GameRepositoryModule } from '../game-repository/game-repository.module';
import { GameDetailEshopController } from './game-detail-eshop.controller';
import { GameDetailEshopService } from './game-detail-eshop.service';

@Module({
  imports: [EshopServicesModule, GameRepositoryModule],
  controllers: [GameDetailEshopController],
  providers: [GameDetailEshopService],
})
export class GameDetailEshopModule {
  static id = 'game-detail-eshop';
}
