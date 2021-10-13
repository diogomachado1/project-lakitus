import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';
import { PriceHistoryRepositoryService } from './price-history-repository.service';
import { PriceHistory, PriceHistorySchema } from './priceHistory.schema';

@Module({
  imports: [
    ConfigModule.forRoot(),
    MongooseModule.forRoot(process.env.MONGO_URL),
    MongooseModule.forFeature([
      { name: PriceHistory.name, schema: PriceHistorySchema },
    ]),
  ],
  providers: [
    {
      useClass: PriceHistoryRepositoryService,
      provide: 'PRICE_HISTORY_REPOSITORY',
    },
  ],
  exports: ['PRICE_HISTORY_REPOSITORY'],
})
export class PriceHistoryRepositoryModule {}
