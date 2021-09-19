import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { GameRepositoryService } from './game-repository.service';
import { Game } from './game.schema';

@Module({
  imports: [
    MongooseModule.forRoot(process.env.MONGO_URL),
    MongooseModule.forFeature([{ name: Game.name, schema: Game }]),
  ],
  providers: [GameRepositoryService],
})
export class GameRepositoryModule {}
