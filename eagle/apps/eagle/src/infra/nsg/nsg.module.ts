import { Module } from '@nestjs/common';
import { NsgService } from './nsg.service';

@Module({
  providers: [{ useClass: NsgService, provide: 'NSG_SERVICE' }],
  exports: ['NSG_SERVICE'],
})
export class NsgModule {}
