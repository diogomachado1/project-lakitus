import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { Ingest, Search } from 'sonic-channel';

@Injectable()
export class SonicService {
  sonicIngest: Ingest;
  sonicSearch: Search;
  constructor(private configService: ConfigService) {
    const host = this.configService.get<string>('SONIC_HOST');
    const auth = this.configService.get<string>('SONIC_PASSWORD');
    const port = Number(this.configService.get<string>('SONIC_PORT'));
    this.sonicIngest = new Ingest({ host, port, auth }).connect({
      connected: function () {
        console.info('Sonic Channel succeeded to connect to host (Ingest).');
      },
    });

    this.sonicSearch = new Search({ host, port, auth }).connect({
      connected: function () {
        console.info('Sonic Channel succeeded to connect to host (search).');
      },
    });
  }
  async saveGameDetail(data) {
    const sentence = `${data?.usEshopDetail?.title || ''} ${
      data?.usEshopDetail?.description || ''
    } ${data?.euEshopDetail?.title || ''} ${
      data?.jpEshopDetail?.TitleName || ''
    } ${data?.hkEshopDetail?.title || ''} ${
      data?.hkEshopDetail?.release_date || ''
    } ${data?.jpEshopDetail?.SalesDate || ''} ${data?.usEshopId || ''} ${
      data?.euEshopId || ''
    }${data?.jpEshopId || ''} ${data?.hkEshopId || ''}`.trim();
    sentence &&
      (await this.sonicIngest.push(
        'games',
        'default',
        data._id.toString(),
        sentence,
      ));
  }
  async searchGames(q: string, page = 1) {
    return await this.sonicSearch.query('games', 'default', q, {
      limit: 10,
      offset: (page - 1) * 10,
    });
  }
}
