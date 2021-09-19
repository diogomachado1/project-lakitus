const { Kafka } = require('kafkajs')

const ProducerLib = {

  async handle(kafkaTopic,messages,key){
    const kafka = new Kafka({
      clientId: 'my-app',
      brokers: ['localhost:9092']
    })
    const producer = kafka.producer()
    await producer.connect()
    await producer.send({
      topic: kafkaTopic,
      messages: [0].map((item)=>({value: JSON.stringify(messages)}))
    })
  },
}
module.exports={ProducerLib}