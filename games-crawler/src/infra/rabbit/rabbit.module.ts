import { Module } from '@nestjs/common';
import { RabbitService } from './rabbit.service';

@Module({
  providers: [{ useClass: RabbitService, provide: 'RABBIT_SERVICE' }],
  exports: ['RABBIT_SERVICE'],
})
export class RabbitModule {}
