const {ProducerLib} = require('./kafka')

async function sendMessage(){
  console.log('aa')
  const message = {usId: '11111', euId: '22222'}
  await ProducerLib.handle('game.detail', message)
}

sendMessage().then(()=>   process.exit(0)).catch(e=> {
  console.log(e)
  process.exit(1)
})