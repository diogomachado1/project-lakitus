FROM node:15-alpine

ENV HOME=/home/app

WORKDIR $HOME/

COPY . ./

RUN yarn

RUN yarn build
 
EXPOSE 3000

HEALTHCHECK CMD curl --fail http://localhost:3000 || exit 1 

CMD ["yarn", "start:prod"]