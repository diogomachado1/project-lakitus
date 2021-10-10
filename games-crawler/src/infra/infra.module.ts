import { Module } from '@nestjs/common';
import { GameRepositoryModule } from './game-repository/game-repository.module';
import { PriceRepositoryModule } from './price-repository/price-repository.module';
import { RabbitModule } from './rabbit/rabbit.module';
import { S3Module } from './s3/s3.module';

@Module({
  imports: [
    GameRepositoryModule,
    PriceRepositoryModule,
    S3Module,
    RabbitModule,
  ],
  exports: [
    GameRepositoryModule,
    PriceRepositoryModule,
    S3Module,
    RabbitModule,
  ],
})
export class InfraModule {}
