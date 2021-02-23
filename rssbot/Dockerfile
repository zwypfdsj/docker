FROM golang:latest AS builder

RUN apt-get update && \
    apt-get install -y build-essential git && \
    git clone https://github.com/indes/flowerss-bot.git && \
    cd flowerss-bot && \
    export VERSION=$(git describe --tags) && \
    export DATE=$(date '+%Y%m%d-%H%M%S') && \
    export COMMIT=$(git rev-parse --short HEAD) && \
    export LDFLAGS="-s -w -X github.com/indes/flowerss-bot/config.version=${VERSION} -X github.com/indes/flowerss-bot/config.date=${DATE} -X github.com/indes/flowerss-bot/config.commit=${COMMIT}" && \
    go build -a -trimpath -ldflags "$LDFLAGS" -o /rssbot


FROM debian:stable-slim

ENV TZ="Asia/Shanghai"

RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /rssbot /usr/bin/

WORKDIR /rssbot
VOLUME /rssbot

ENTRYPOINT ["rssbot", "-c"]
CMD ["/rssbot/config.yml"]