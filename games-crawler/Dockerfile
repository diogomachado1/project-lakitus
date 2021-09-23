FROM node:15-alpine

ENV HOME=/home/app

WORKDIR $HOME/

COPY . ./

RUN yarn

RUN yarn build
 
EXPOSE 3000

CMD ["yarn", "start:prod"]