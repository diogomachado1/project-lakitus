import { CACHE_MANAGER, Inject, Injectable } from '@nestjs/common';
import { GameRepositoryService } from '@infra/infra/game-repository/game-repository.service';
import { Cache } from 'cache-manager';
import { Document, LeanDocument } from 'mongoose';
import { Game } from '@infra/infra/game-repository/game.schema';
import { SimpleDetail } from '@infra/infra/game-repository/SimpleDetail';
import { SonicService } from '@infra/infra/sonic/sonic.service';

@Injectable()
export class GameService {
  constructor(
    @Inject(CACHE_MANAGER) private cacheManager: Cache,
    @Inject('GAME_REPOSITORY') private gameRepository: GameRepositoryService,
    @Inject('SONIC_SERVICE') private sonicService: SonicService,
  ) {}

  async search(search: string, page: number, full: boolean) {
    const ids = await this.sonicService.searchGames(search, page);
    return full
      ? this.gameRepository.findGames({ ids }, undefined, true)
      : this.gameRepository.findGamesSimpleDetail({ ids });
  }

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
