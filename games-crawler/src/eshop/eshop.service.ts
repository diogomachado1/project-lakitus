import { CACHE_MANAGER, Inject, Injectable } from '@nestjs/common';
import { Cache } from 'cache-manager';
import { getGamesAmerica, GameUS } from 'nintendo-switch-eshop';
import { EshopServiceUsEshopService } from 'src/game-detail-us-eshop/game-detail-us-eshop.service';

@Injectable()
export class EshopService implements EshopServiceUsEshopService {
  constructor(@Inject(CACHE_MANAGER) public cacheManager: Cache) {}

  async findGameByUsId(id: string) {
    const cached = await this.cacheManager.get<GameUS[]>('eshop:games:america');
    const games = cached || (await getGamesAmerica());
    if (!cached) {
      await this.cacheManager.set('eshop:games:america', games);
    }
    return games.find((item) => item.nsuid === id);
  }
}
