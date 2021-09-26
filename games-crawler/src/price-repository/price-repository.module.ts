import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';
import { PriceRepositoryService } from './price-repository.service';
import { Price, PriceSchema } from './price.schema';

@Module({
  imports: [
    ConfigModule.forRoot(),
    MongooseModule.forRoot(process.env.MONGO_URL),
    MongooseModule.forFeature([{ name: Price.name, schema: PriceSchema }]),
  ],
  providers: [
    { useClass: PriceRepositoryService, provide: 'PRICE_REPOSITORY' },
  ],
  exports: ['PRICE_REPOSITORY'],
})
export class PriceRepositoryModule {}
