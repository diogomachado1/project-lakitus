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
      messages: [0,1,2,3,4,5,6,7,8,9].map((item)=>({value: JSON.stringify(messages)}))
    })
  },
}
module.exports={ProducerLib}