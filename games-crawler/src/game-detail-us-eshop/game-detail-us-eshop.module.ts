import { CacheModule, Module } from '@nestjs/common';
import { EshopServicesModule } from 'src/eshop/eshop.module';
import { GameDetailUsEshopController } from './game-detail-us-eshop.controller';
import { GameDetailUsEshopService } from './game-detail-us-eshop.service';

const GameRepository = {
  save: async (games) => {
    return;
  },
};
@Module({
  imports: [EshopServicesModule],
  controllers: [GameDetailUsEshopController],
  providers: [
    GameDetailUsEshopService,
    { useValue: GameRepository, provide: 'GAME_REPOSITORY' },
  ],
})
export class GameDetailUsEshopModule {
  static id = 'game-detail-us-eshop';
}
