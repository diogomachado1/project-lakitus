import { Injectable } from '@nestjs/common';
import { connect, Connection, Channel } from 'amqplib';

@Injectable()
export class RabbitService {
  connection: Connection;
  channel: Channel;

  async onModuleInit() {
    this.connection = await connect({
      hostname: process.env.RABBIT_HOST,
      port: 5672,
      username: process.env.RABBIT_USER,
      password: process.env.RABBIT_PASSWORD,
      heartbeat: 10,
    });
    this.channel = await this.connection.createChannel();
  }

  async sendBatchToGameDetail(gamesIds: { usId: number; euId: number }[]) {
    await Promise.all(
      gamesIds.map((item) =>
        this.channel.publish(
          'game-detail',
          'game-detail',
          Buffer.from(JSON.stringify(item)),
          {
            persistent: true,
          },
        ),
      ),
    );
  }

  async sendMessageToPriceStart() {
    await this.channel.publish(
      'game-price-starter',
      'game-price-starter',
      Buffer.from(JSON.stringify({})),
      {
        persistent: true,
      },
    );
  }

  async sendMessageToPriceHistoryStart() {
    await this.channel.publish(
      'game-price-history-starter',
      'game-price-history-starter',
      Buffer.from(JSON.stringify({})),
      {
        persistent: true,
      },
    );
  }
}
