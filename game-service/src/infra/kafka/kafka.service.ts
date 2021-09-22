import { Injectable } from '@nestjs/common';
import { Kafka, Producer } from 'kafkajs';

@Injectable()
export class KafkaService {
  kafka = new Kafka({
    clientId: 'game-producer',
    brokers: [process.env.KAFKA_HOST],
  });

  producer: Producer;

  async onModuleInit() {
    this.producer = this.kafka.producer();
    await this.producer.connect();
  }

  async sendBatchToGameDetail(gamesIds: { usId: number; euId: number }[]) {
    this.producer.send({
      topic: 'game-detail',
      messages: gamesIds.map((item) => ({ value: JSON.stringify(item) })),
    });
  }
}
