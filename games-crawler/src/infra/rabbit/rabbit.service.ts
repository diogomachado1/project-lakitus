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

  protected async publish(exchange: string, queue: string, item) {
    return this.channel.publish(
      exchange,
      queue,
      Buffer.from(JSON.stringify(item)),
      {
        persistent: true,
      },
    );
  }

  protected async batchPublish(exchange: string, queue: string, itens: any[]) {
    await Promise.all(itens.map((item) => this.publish(exchange, queue, item)));
  }

  async sendBatchToGameUpdated(datas: any[]) {
    await this.batchPublish('price-updated', '', datas);
  }

  async sendBatchToGameDetail(gamesIds: { usId: number; euId: number }[]) {
    await this.batchPublish('game-detail', 'game-detail', gamesIds);
  }

  async sendBatchToGamePrice(gamesIds: any[]) {
    await this.batchPublish('game-price', 'game-price', gamesIds);
  }

  async sendBatchToGamePriceHistory(gamesIds: any[]) {
    await this.batchPublish(
      'game-price-history',
      'game-price-history',
      gamesIds,
    );
  }
}
