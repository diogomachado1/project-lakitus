'use strict';

const { default: axios } = require('axios');

module.exports.run = async (event, context) => {  
  const reponse = await axios.post('http://api.leari.xyz/send-games-ids/prices-history');
  const time = new Date();
  console.log(`Your cron function "${context.functionName}" ran at ${time}, status${reponse.status}`);
};