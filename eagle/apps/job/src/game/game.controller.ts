import { Controller } from '@nestjs/common';
import { MessagePattern } from '@nestjs/microservices';
import { GameService } from './game.service';

@Controller('game')
export class GameController {
  constructor(private service: GameService) {}

  @MessagePattern('new-game-detail-nintendo')
  async getNintendoGameDetail() {
    await this.service.verifyNewNintendoGame();
  }

  @MessagePattern('metacritic-score-nintendo-switch-game')
  async getNintendoMetacriticScore({ page = 0 }: { page: number }) {
    await this.service.getNintendoMetacriticScore(page);
  }

  @MessagePattern('game-sonic-index')
  async gameIndex() {
    await this.service.gameIndex();
  }

  @MessagePattern('game-elastic-index')
  async gameElasticIndex() {
    await this.service.gameElasticIndex();
  }
}
