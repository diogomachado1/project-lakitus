import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Client as ElasticClient } from '@elastic/elasticsearch';
import { Game } from '../game-repository/game.schema';

@Injectable()
export class ElasticService {
  elasticClient: ElasticClient;
  constructor(private configService: ConfigService) {
    // const host = this.configService.get<string>('ELASTIC_HOST');
    this.elasticClient = new ElasticClient({
      node: 'http://elasticsearch:9200',
      auth: {
        username: 'elastic',
        password: 'changeme',
      },
    });
  }
  async deleteAll() {
    await this.elasticClient.deleteByQuery({
      index: 'games',
      body: {
        query: {
          match_all: {},
        },
      },
    });
  }

  async saveGameDetail(datas: (Game & { _id: string })[]) {
    const fomatedDatas = datas.flatMap((data) => [
      { index: { _index: 'games' } },
      {
        usTitle: data.usEshopDetail?.title,
        usDescription: data.usEshopDetail?.description,
        euTitle: data.euEshopDetail?.title,
        usEshopId: data.usEshopId,
        euEshopId: data.euEshopId,
        jpEshopId: data.jpEshopId,
        hkEshopId: data.hkEshopId,
        internalId: data._id,
      },
    ]);
    await this.elasticClient.bulk({
      refresh: true,
      body: fomatedDatas,
    });
  }
  async searchGames(q: string, page = 1) {
    const search = q.trim();
    return await this.elasticClient.search({
      index: 'games',
      body: {
        query: {
          match: {
            usEshopDetail: {
              title: `*${search}*`,
              description: `*${search}*`,
            },
            euEshopDetail: {
              TitleName: `*${search}*`,
            },
          },
        },
      },
    });
  }
}
