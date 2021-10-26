import { NestFactory } from '@nestjs/core';
import { MicroserviceOptions } from '@nestjs/microservices';
import { AllExceptionsFilter } from './AllExceptionsFilter';
import { JobModule } from './job.module';
import { RabbitClient } from './RabbitClient';

async function bootstrap() {
  const healthCheck = await NestFactory.create(JobModule);
  const rabbit = new RabbitClient();

  const app = await NestFactory.createMicroservice<MicroserviceOptions>(
    JobModule,
    {
      strategy: rabbit,
    },
  );

  app.useGlobalFilters(new AllExceptionsFilter());
  await app.listen();
  await healthCheck.listen(3000);
}
bootstrap();
