import { Module } from '@nestjs/common';
import { EshopServicesModule } from './eshop/eshop.module';
import { PriceHistoryRepositoryModule } from './game-history-repository/price-history-repository.module';
import { GameRepositoryModule } from './game-repository/game-repository.module';
import { NsgModule } from './nsg/nsg.module';
import { PriceRepositoryModule } from './price-repository/price-repository.module';
import { RabbitModule } from './rabbit/rabbit.module';
import { S3Module } from './s3/s3.module';
import { SonicModule } from './sonic/sonic.module';

@Module({
  imports: [
    GameRepositoryModule,
    PriceRepositoryModule,
    PriceHistoryRepositoryModule,
    S3Module,
    RabbitModule,
    EshopServicesModule,
    NsgModule,
    SonicModule,
  ],
  exports: [
    GameRepositoryModule,
    PriceRepositoryModule,
    PriceHistoryRepositoryModule,
    S3Module,
    RabbitModule,
    EshopServicesModule,
    NsgModule,
    SonicModule,
  ],
})
export class InfraModule {}
