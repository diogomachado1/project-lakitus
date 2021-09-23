import 'newrelic';
import { NestFactory } from '@nestjs/core';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';
import { GameDetailEshopModule } from './game-detail-eshop/game-detail-eshop.module';

async function bootstrap() {
  [GameDetailEshopModule].map(async (item) => {
    const app = await NestFactory.createMicroservice<MicroserviceOptions>(
      item,
      {
        transport: Transport.KAFKA,
        options: {
          client: {
            clientId: item.id,
            brokers: [process.env.KAFKA_HOST],
          },
          consumer: {
            groupId: item.id,
          },
        },
      },
    );
    app.listen();
  });
}
bootstrap();
