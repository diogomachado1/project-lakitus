import axios from 'axios';

export function CatchCustom(consumerName = 'unknow') {
  return (_: any, key: string, descriptor: any) => {
    const originalMethod = descriptor.value;

    descriptor.value = async function Before(...args: any[]) {
      try {
        const data = await originalMethod.apply(this, args);
        return data;
      } catch (error) {
        if (process.env.DISCORD_URL) {
          await axios.post(process.env.DISCORD_URL, {
            username: 'Argos',
            content: `:red_circle: Error in topic \`${
              args[0].topic
            }\` \`\`\`Body: ${JSON.stringify(args[0].value)}\nError: ${
              error.message
            }\nConsumer: ${consumerName}\`\`\``,
          });
        }
        throw error;
      }
    };

    return descriptor;
  };
}

// @Catch()
// export class KafkaException extends BaseRpcExceptionFilter {
//   async catch(exception: any, host: ArgumentsHost) {
//     await axios.post(notification.platformData.webhook, {
//       username: 'Argos',
//       content: `${circle} ${getDataFormat(
//         watcher.lastChange,
//         watcher.oldLastChange,
//         watcher.name,
//         watcher.url,
//         status
//       )}`,
//     });
//     return super.catch(exception, host);
//   }
// }
