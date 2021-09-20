const {ProducerLib} = require('./kafka')

async function sendMessage(){
  console.log('aa')
  const message = {usId: '70010000040947', euId: '70010000040948'}
  await ProducerLib.handle('game.detail', message)
}

sendMessage().then(()=>   process.exit(0)).catch(e=> {
  console.log(e)
  process.exit(1)
})