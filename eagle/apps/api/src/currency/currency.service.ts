import { Injectable } from '@nestjs/common';
import axios from 'axios';

@Injectable()
export class CurrencyService {
  async getCurrency() {
    const { data } = await axios.get(
      `https://openexchangerates.org/api/latest.json?app_id=${process.env.OPEN_EXCHANGE_TOKEN}`,
    );
    return data;
  }
}
