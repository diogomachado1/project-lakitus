import { Inject, Injectable } from '@nestjs/common';
import { GameRepositoryService } from 'src/infra/game-repository/game-repository.service';

@Injectable()
export class GameService {
  constructor(
    @Inject('GAME_REPOSITORY') private gameRepository: GameRepositoryService,
  ) {}

  async getOneGame(id: string) {
    return this.gameRepository.findOneGame(id);
  }

  async getManyGame(ids: string[], search: string, page: number) {
    return this.gameRepository.findGames({ ids, search }, page);
  }
}
