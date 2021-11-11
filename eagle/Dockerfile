FROM node:15-alpine

ENV HOME=/home/app

WORKDIR $HOME/

COPY . ./

ENV CHROME_BIN="/usr/bin/chromium-browser" \
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD="true"
RUN set -x \
    && apk update \
    && apk upgrade \
    && apk add --no-cache \
    udev \
    ttf-freefont \
    chromium 

RUN yarn

RUN yarn build

RUN apk --no-cache add curl
 
EXPOSE 3000

HEALTHCHECK --interval=30s --start-period=30s --retries=5 --timeout=5s \ 
  CMD curl -f http://localhost:3000 || exit 1 

CMD ["yarn", "start:prod"]