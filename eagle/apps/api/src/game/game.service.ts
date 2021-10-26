import { CACHE_MANAGER, Inject, Injectable } from '@nestjs/common';
import { GameRepositoryService } from '@infra/infra/game-repository/game-repository.service';
import { Cache } from 'cache-manager';
import { Document, LeanDocument } from 'mongoose';
import { Game } from '@infra/infra/game-repository/game.schema';
import { SimpleDetail } from '@infra/infra/game-repository/SimpleDetail';

@Injectable()
export class GameService {
  constructor(
    @Inject(CACHE_MANAGER) private cacheManager: Cache,
    @Inject('GAME_REPOSITORY') private gameRepository: GameRepositoryService,
  ) {}

  async getOneGame(id: string) {
    const cached = await this.cacheManager.get<SimpleDetail>(`game:${id}`);
    if (cached) return cached;
    const game = await this.gameRepository.findOneGameSimple(id);
    await this.cacheManager.set(`game:${id}`, game, { ttl: 60 * 5 });
    return game;
  }

  async getOneGameFull(id: string) {
    const cached = await this.cacheManager.get<
      LeanDocument<
        Game &
          Document<any, any, any> & {
            _id: any;
          }
      >
    >(`game-full:${id}`);
    if (cached) return cached;
    const game = await this.gameRepository.findOneGame(id);
    await this.cacheManager.set(`game-full:${id}`, game, { ttl: 60 * 5 });
    return game;
  }

  async getManyGame(ids?: string[], search?: string, page?: number) {
    return this.gameRepository.findGamesSimpleDetail({ ids, search }, page);
  }

  async getManyGameFull(ids?: string[], search?: string, page?: number) {
    return this.gameRepository.findGames({ ids, search }, page);
  }
}
