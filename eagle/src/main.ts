// eslint-disable-next-line @typescript-eslint/no-var-requires
require('dotenv').config();
import 'newrelic';
import { NestFactory } from '@nestjs/core';
import { MicroserviceOptions } from '@nestjs/microservices';
import { RabbitClient } from './RabbitClient';
import { AllExceptionsFilter } from './AllExceptionsFilter';
import { AppModule } from './app.module';

async function bootstrap() {
  const rabbit = new RabbitClient();
  const app = await NestFactory.createMicroservice<MicroserviceOptions>(
    AppModule,
    {
      strategy: rabbit,
    },
  );

  app.useGlobalFilters(new AllExceptionsFilter());
  await app.listen();
}
bootstrap();
