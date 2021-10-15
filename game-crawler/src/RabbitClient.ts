import { CustomTransportStrategy, Server } from '@nestjs/microservices';
import { Connection, Channel, connect } from 'amqplib';
import axios from 'axios';
import * as newrelic from 'newrelic';

export class RabbitClient extends Server implements CustomTransportStrategy {
  connection: Connection;
  channel: Channel;

  async init(queue: string) {
    await this.channel.assertExchange(`${queue}-retry`, 'direct');
    await this.channel.assertExchange(queue, 'direct');
    await this.channel.assertQueue(`${queue}-retry`, {
      durable: true,
      deadLetterExchange: queue,
      deadLetterRoutingKey: queue,
      messageTtl: 90000,
    });
    await this.channel.assertQueue(queue, {
      durable: true,
      deadLetterExchange: `${queue}-retry`,
      deadLetterRoutingKey: `${queue}-retry`,
    });
    await this.channel.bindQueue(
      `${queue}-retry`,
      `${queue}-retry`,
      `${queue}-retry`,
    );
    await this.channel.bindQueue(queue, queue, queue);
  }

  async getConnection() {
    if (!this.connection) {
      this.connection = await connect({
        hostname: process.env.RABBIT_HOST,
        port: 5672,
        username: process.env.RABBIT_USER,
        password: process.env.RABBIT_PASSWORD,
        heartbeat: 10,
      });
    }
    return this.connection;
  }

  async getChannel() {
    if (!this.channel) {
      this.channel = await (await this.getConnection()).createChannel();
    }
    return this.channel;
  }

  protected async createConsumers() {
    this.messageHandlers.forEach((handle, queue) => {
      this.channel.prefetch(1);
      this.logger.log(`Starting ${queue}`);
      this.channel.consume(
        queue,
        async (message) => {
          if (message) {
            try {
              await (() => {
                return newrelic.startBackgroundTransaction(queue, async () => {
                  const transaction = newrelic.getTransaction();
                  const response = await handle(
                    JSON.parse(message.content.toString()),
                  );
                  transaction.end();
                  return response;
                });
              })();
            } catch (error) {
              newrelic.noticeError(error);
              const retry = message.properties?.headers?.['x-retry']
                ? message.properties.headers['x-retry'] + 1
                : 1;
              const delay = 60000 * retry;
              if (retry >= 15) {
                if (process.env.DISCORD_URL) {
                  try {
                    await axios.post(process.env.DISCORD_URL, {
                      username: 'Argos',
                      content: `:red_circle: Error in topic \`${queue}\` \`\`\`Body: ${message.content.toString()}\nError: ${
                        error.message
                      }\nConsumer: ${queue}\`\`\``,
                    });
                  } catch (error) {
                    this.logger.error(error);
                  }
                  this.logger.error(
                    `:red_circle: Error in topic \`${queue}\` \`\`\`Body: ${message.content.toString()}\nError: ${
                      error.message
                    }\nConsumer: ${queue}\`\`\``,
                  );
                }
              } else {
                this.channel.publish(
                  `${queue}-retry`,
                  `${queue}-retry`,
                  message.content,
                  {
                    headers: { 'x-delay': delay, 'x-retry': retry },
                  },
                );
              }
              this.logger.log(
                JSON.stringify({
                  error: error.message,
                  queue,
                  payload: JSON.parse(message.content.toString()),
                }),
              );
            } finally {
              this.channel.ack(message);
            }
          }
        },
        {},
      );
    });
  }

  async createFanoutQueue(exchangeName: string, queuesToBind: string[]) {
    await this.channel.assertExchange(exchangeName, 'fanout');
    await Promise.all(
      queuesToBind.map((item) =>
        this.channel.bindQueue(item, exchangeName, ''),
      ),
    );
  }

  async createQueues() {
    const queues = [];
    this.messageHandlers.forEach((_, key) => key && queues.push(key));

    await this.getChannel();
    await Promise.all(queues.map((queue) => this.init(queue)));
  }

  async listen(callback: () => void) {
    await this.createQueues();
    await this.createFanoutQueue('price-updated', ['game-price-history']);
    await this.createConsumers();
    callback();
  }

  async close() {
    await this.channel.close();
    await this.connection.close();
  }
}
