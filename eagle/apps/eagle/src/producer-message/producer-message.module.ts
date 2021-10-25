import { Module } from '@nestjs/common';
import { InfraModule } from '../infra/infra.module';
import { ProducerGameDetailController } from './producer-message.controller';
import { ProducerGameDetailService } from './producer-message.service';

@Module({
  imports: [InfraModule],
  controllers: [ProducerGameDetailController],
  providers: [ProducerGameDetailService],
})
export class ProducerGameDetailModule {}
