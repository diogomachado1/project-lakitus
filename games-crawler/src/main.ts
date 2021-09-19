import { NestFactory } from '@nestjs/core';
import { MicroserviceOptions, Transport } from '@nestjs/microservices';
import { GameDetailEuEshopModule } from './game-detail-eu-eshop/game-detail-eu-eshop.module';
import { GameDetailUsEshopModule } from './game-detail-us-eshop/game-detail-us-eshop.module';

async function bootstrap() {
  [GameDetailEuEshopModule, GameDetailUsEshopModule].map(async (item) => {
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
