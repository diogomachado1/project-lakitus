FROM node:15-alpine

ENV HOME=/home/app

WORKDIR $HOME/

COPY . ./

RUN apk --no-cache add curl

RUN curl -Ls https://download.newrelic.com/install/newrelic-cli/scripts/install.sh | bash && sudo NEW_RELIC_API_KEY=NRAK-8AUMZW48IFLJGZF77IM3DS9EB15 NEW_RELIC_ACCOUNT_ID=3293717 /usr/local/bin/newrelic install -n node-agent-installer

RUN yarn

RUN yarn build

EXPOSE 3000

CMD ["yarn", "start:prod"]