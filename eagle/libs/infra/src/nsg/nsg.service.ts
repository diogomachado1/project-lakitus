import { Injectable } from '@nestjs/common';
import axios from 'axios';
import { NsgGameResponse } from './interfaces/NsgGameResponse';

@Injectable()
export class NsgService {
  async getGames() {
    return (
      await axios.get<NsgGameResponse>(
        'https://www.nsgreviews.com/search/s?search=&limit=1000000',
      )
    ).data.rows;
  }
}
