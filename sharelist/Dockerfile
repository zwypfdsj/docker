FROM node:lts-alpine

ENV HOST 0.0.0.0
ENV PORT 33001
ENV TZ=Asia/Shanghai

RUN apk add --no-cache tzdata git && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo "${TZ}" >  /etc/timezone && \
    git clone https://github.com/reruin/sharelist.git && \
    apk del tzdata git && \
    rm -rf /var/cache/apk/*

WORKDIR /sharelist
VOLUME /sharelist/cache

RUN npm install

EXPOSE 33001

CMD ["npm", "start"]