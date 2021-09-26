import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';
import { Price, PriceSchema } from '../price-repository/price.schema';
import { GameRepositoryService } from './game-repository.service';
import { Game, GameSchema } from './game.schema';

@Module({
  imports: [
    ConfigModule.forRoot(),
    MongooseModule.forRoot(process.env.MONGO_URL),
    MongooseModule.forFeature([
      { name: Game.name, schema: GameSchema },
      { name: Price.name, schema: PriceSchema },
    ]),
  ],
  providers: [{ useClass: GameRepositoryService, provide: 'GAME_REPOSITORY' }],
  exports: ['GAME_REPOSITORY'],
})
export class GameRepositoryModule {}
