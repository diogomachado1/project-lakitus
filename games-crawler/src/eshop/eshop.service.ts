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
  getPrices,
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
        'eshop:games:europa',
      );
      const games = cached || (await getGamesEurope());
      if (!cached) {
        await this.cacheManager.set('eshop:games:europa', games);
      }
      return games.find((item) => parseNSUID(item, 2) === id?.toString());
    }
  }

  async findGameByJpId(productCode: string) {
    const cached = await this.cacheManager.get<GameJP[]>('eshop:games:japan');
    const games = cached || (await getGamesJapan());
    if (!cached) {
      await this.cacheManager.set('eshop:games:japan', games);
    }
    return games.find((item) => parseGameCode(item, 3) === productCode);
  }

  async findGameByHkId(productCode: string) {
    const cached = await this.cacheManager.get<GameHk[]>('eshop:games:hk');
    try {
      const games =
        cached ||
        (
          await axios.get<GameHk[]>(
            'https://www.nintendo.com.hk/data/json/switch_software.json',
          )
        ).data.filter((item) => item.media === 'eshop');
      if (!cached) {
        await this.cacheManager.set('eshop:games:hk', games);
      }
      return games.find(
        (item) => this.parseGameHkCode(item.product_code) === productCode,
      );
    } catch (error) {
      return undefined;
    }
  }

  async getPrices(ids: string[], contry: string) {
    return getPrices(contry.toUpperCase(), ids);
  }

  parseGameHkCode(productCode: string) {
    const codeParse = /HAC\w(\w{4})/.exec(productCode);
    return codeParse && codeParse.length > 1 ? codeParse[1] : null;
  }
}
