FROM node:15-alpine

ENV HOME=/home/app

WORKDIR $HOME/

COPY . ./

RUN yarn

RUN yarn build
 
EXPOSE 3000

HEALTHCHECK --interval=30s --start-period=30s --retries=5 --timeout=5s \ CMD curl -f http://localhost:3000 || exit 1 

CMD ["yarn", "start:prod"]