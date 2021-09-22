import { Module } from '@nestjs/common';
import { InfraModule } from 'src/infra/infra.module';
import { ProducerGameDetailController } from './producer-game-detail.controller';
import { ProducerGameDetailService } from './producer-game-detail.service';

@Module({
  imports: [InfraModule],
  controllers: [ProducerGameDetailController],
  providers: [ProducerGameDetailService],
})
export class ProducerGameDetailModule {}
