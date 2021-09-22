import { Module } from '@nestjs/common';
import { KafkaService } from './kafka.service';

@Module({
  providers: [{ useClass: KafkaService, provide: 'KAFKA_SERVICE' }],
  exports: ['KAFKA_SERVICE'],
})
export class KafkaModule {}
