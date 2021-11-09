import { CacheModule, Module } from '@nestjs/common';
import { CurrencyController } from './currency.controller';
import { CurrencyService } from './currency.service';
import * as redisStore from 'cache-manager-redis-store';

@Module({
  imports: [
    CacheModule.register({
      store: redisStore,
      host: process.env.REDIS_HOST,
      port: 6379,
      ttl: 60 * 60 * 8,
    }),
  ],
  controllers: [CurrencyController],
  providers: [CurrencyService],
})
export class CurrencyModule {}
