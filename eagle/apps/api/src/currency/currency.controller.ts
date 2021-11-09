import {
  CacheInterceptor,
  Controller,
  Get,
  UseInterceptors,
} from '@nestjs/common';
import { CurrencyService } from './currency.service';

@Controller('currency')
export class CurrencyController {
  constructor(private service: CurrencyService) {}

  @Get()
  @UseInterceptors(CacheInterceptor)
  async getCurrency() {
    return await this.service.getCurrency();
  }
}
