FROM golang:alpine AS builder

RUN apk add git gcc libc-dev && \
    git clone https://github.com/indes/flowerss-bot.git && \
    cd flowerss-bot && \
    export VERSION=$(git describe --tags) && \
    export DATE=$(date '+%Y%m%d-%H%M%S') && \
    export COMMIT=$(git rev-parse --short HEAD) && \
    export LDFLAGS="-s -w -X github.com/indes/flowerss-bot/config.version=${VERSION} -X github.com/indes/flowerss-bot/config.date=${DATE} -X github.com/indes/flowerss-bot/config.commit=${COMMIT}" && \
    go build -a -ldflags "$LDFLAGS" -o /rssbot


FROM alpine:latest

ENV TZ="Asia/Shanghai"

RUN apk add --no-cache tzdata ca-certificates && \
    rm -rf /var/cache/apk/*

COPY --from=builder /rssbot /usr/bin/

VOLUME /rssbot
WORKDIR /rssbot

ENTRYPOINT ["rssbot", "-c"]
CMD ["/rssbot/config.yml"]