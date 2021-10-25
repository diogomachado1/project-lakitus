import { CacheModule, Module } from '@nestjs/common';
import { EshopService } from './eshop.service';

@Module({
  imports: [
    CacheModule.register([
      {
        store: 'memory',
        ttl: 60 * 60 * 1,
      },
    ]),
  ],
  providers: [{ useClass: EshopService, provide: 'ESHOP_SERVICE' }],
  exports: ['ESHOP_SERVICE'],
})
export class EshopServicesModule {}
