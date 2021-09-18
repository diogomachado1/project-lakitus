import { CacheModule, Module } from '@nestjs/common';
import { EshopService } from './eshop.service';

@Module({
  imports: [CacheModule.register({ ttl: 60 * 60 * 5 })],
  providers: [EshopService],
  exports: [EshopService],
})
export class EshopServicesModule {}
