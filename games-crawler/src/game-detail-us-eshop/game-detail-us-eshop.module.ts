import { Module } from '@nestjs/common';
import { EshopServicesModule } from 'src/eshop/eshop.module';
import { GameRepositoryModule } from 'src/game-repository/game-repository.module';
import { GameDetailUsEshopController } from './game-detail-us-eshop.controller';
import { GameDetailUsEshopService } from './game-detail-us-eshop.service';

@Module({
  imports: [EshopServicesModule, GameRepositoryModule],
  controllers: [GameDetailUsEshopController],
  providers: [GameDetailUsEshopService],
})
export class GameDetailUsEshopModule {
  static id = 'game-detail-us-eshop';
}
