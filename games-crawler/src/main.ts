// eslint-disable-next-line @typescript-eslint/no-var-requires
require('dotenv').config();
import 'newrelic';
import { NestFactory } from '@nestjs/core';
import { MicroserviceOptions } from '@nestjs/microservices';
import { GameDetailEshopModule } from './game-detail-eshop/game-detail-eshop.module';
import { RabbitClient } from './RabbitClient';
import { AllExceptionsFilter } from './AllExceptionsFilter';

async function bootstrap() {
  [GameDetailEshopModule].map(async (item) => {
    const app = await NestFactory.createMicroservice<MicroserviceOptions>(
      item,
      {
        strategy: new RabbitClient(),
      },
    );
    app.useGlobalFilters(new AllExceptionsFilter());
    await app.listen();
  });
}
bootstrap();
