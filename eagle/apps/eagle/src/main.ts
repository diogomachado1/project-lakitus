// eslint-disable-next-line @typescript-eslint/no-var-requires
require('dotenv').config();
import 'newrelic';
import { NestFactory } from '@nestjs/core';
import { MicroserviceOptions } from '@nestjs/microservices';
import { RabbitClient } from './RabbitClient';
import { AllExceptionsFilter } from './AllExceptionsFilter';
import { AppModule } from './app.module';

async function bootstrap() {
  if (process.env.APPS.split(',').includes('REST')) {
    const restApi = await NestFactory.create(AppModule);

    await restApi.listen(3000);
  }

  if (process.env.APPS.split(',').includes('JOB')) {
    const healthCheck = await NestFactory.create(HealthModule);
    const rabbit = new RabbitClient();

    const app = await NestFactory.createMicroservice<MicroserviceOptions>(
      AppModule,
      {
        strategy: rabbit,
      },
    );

    app.useGlobalFilters(new AllExceptionsFilter());
    await app.listen();
    await healthCheck.listen(3000);
  }
}
bootstrap();
