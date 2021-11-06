import { CACHE_MANAGER, Inject, Injectable } from '@nestjs/common';
import axios from 'axios';
import { Cache } from 'cache-manager';
import {
  getGamesAmerica,
  GameUS,
  GameEU,
  getGamesEurope,
  parseNSUID,
  getGamesJapan,
  parseGameCode,
  GameJP,
} from 'nintendo-switch-eshop';

export interface GameHk {
  r_date: number;
  release_date: string;
  r_date_tw: string;
  release_date_tw: string;
  title: string;
  title_sc: string;
  sale_until: string;
  pickup: string;
  only_for: string;
  media: string;
  lang: string;
  maker_publisher: string;
  thumb_img: string;
  thumb_img_sc: string;
  thumb_img_tw: string;
  link: string;
  link_sc: string;
  link_tw: string;
  link_target: string;
  platform: string;
  rating: string;
  adult_hk: string;
  category: string;
  category_sc: string;
  copyright: string;
  copyright_sc: string;
  memo1: string;
  memo2: string;
  memo1_sc: string;
  memo2_sc: string;
  memo1_tw: string;
  memo2_tw: string;
  product_code: string;
  item_code: string;
  price: string;
}

@Injectable()
export class EshopService {
  constructor(@Inject(CACHE_MANAGER) public cacheManager: Cache) {}

  async getGamesUs() {
    const cached = await this.cacheManager.get<
      (GameUS & { nintendoId: string })[]
    >('eshop:games:america');
    const games =
      cached ||
      (await getGamesAmerica()).map<GameUS & { nintendoId: string }>(
        (item) => ({
          ...item,
          nintendoId: parseNSUID(item, 1),
        }),
      );
    if (!cached) {
      await this.cacheManager.set('eshop:games:america', games);
    }
    return games;
  }

  async getGamesEu() {
    const cached = await this.cacheManager.get<
      (GameEU & { nintendoId: string })[]
    >('eshop:games:europe');
    const games =
      cached ||
      (await getGamesEurope()).map<GameEU & { nintendoId: string }>((item) => ({
        ...item,
        nintendoId: parseNSUID(item, 2),
      }));
    if (!cached) {
      await this.cacheManager.set('eshop:games:europe', games);
    }
    return games;
  }

  async getGamesJp() {
    const cached = await this.cacheManager.get<
      (GameJP & { nintendoId: string })[]
    >('eshop:games:japan');
    const games =
      cached ||
      (await getGamesJapan()).map<GameJP & { nintendoId: string }>((item) => ({
        ...item,
        nintendoId: parseNSUID(item, 3),
      }));
    if (!cached) {
      await this.cacheManager.set('eshop:games:japan', games);
    }
    return games;
  }

  async getGamesHk() {
    const cached = await this.cacheManager.get<
      (GameHk & { nintendoId: string })[]
    >('eshop:games:hk');
    const games =
      cached ||
      (
        await axios.get<(GameHk & { nintendoId: string })[]>(
          'https://www.nintendo.com.hk/data/json/switch_software.json',
        )
      ).data
        .filter((item) => item.media === 'eshop')
        .map<GameHk & { nintendoId: string }>((item) => ({
          ...item,
          nintendoId: parseNSUID({ LinkURL: item.link } as GameJP, 3),
        }));
    if (!cached) {
      await this.cacheManager.set('eshop:games:hk', games);
    }
    return games;
  }

  async findGameByUsId(id: string) {
    const cached = await this.cacheManager.get<GameUS[]>('eshop:games:america');
    const games = cached || (await getGamesAmerica());
    if (!cached) {
      await this.cacheManager.set('eshop:games:america', games);
    }
    return games.find((item) => item.nsuid === id?.toString());
  }

  async findGameByEuId(id: string) {
    if (id) {
      const cached = await this.cacheManager.get<GameEU[]>(
        'eshop:games:europe',
      );
      const games = cached || (await getGamesEurope());
      if (!cached) {
        await this.cacheManager.set('eshop:games:europe', games);
      }
      return games.find((item) => parseNSUID(item, 2) === id?.toString());
    }
  }

  findGameByJpId(productCode: string, games: GameJP[]) {
    return games.find((item) => parseGameCode(item, 3) === productCode);
  }

  findGameByHkId(productCode: string, gameHk: GameHk[]) {
    return gameHk.find(
      (item) => this.parseGameHkCode(item.product_code) === productCode,
    );
  }

  async getPrices(ids: string[], country: string) {
    const reponse = await axios.get('https://api.ec.nintendo.com/v1/price', {
      params: {
        country: country.toUpperCase(),
        ids: ids.join(','),
        limit: 50,
        lang: 'en',
      },
    });
    return reponse.data;
  }

  parseGameHkCode(productCode: string) {
    const codeParse = /HAC\w(\w{4})/.exec(productCode);
    return codeParse && codeParse.length > 1 ? codeParse[1] : null;
  }
}
