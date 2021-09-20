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
            brokers: ['localhost:9092'],
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
