import * as redisStore from 'cache-manager-redis-store';
import { CacheModule, Module } from '@nestjs/common';
import { EshopService } from './eshop.service';

@Module({
  imports: [
    CacheModule.register([
      {
        store: 'memory',
        ttl: 60 * 60 * 1,
      },
      {
        store: redisStore,
        host: process.env.REDIS_HOST,
        port: 6379,
        ttl: 60 * 60 * 5,
      },
    ]),
  ],
  providers: [{ useClass: EshopService, provide: 'ESHOP_SERVICE' }],
  exports: ['ESHOP_SERVICE'],
})
export class EshopServicesModule {}
