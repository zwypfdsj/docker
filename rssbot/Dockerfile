FROM golang:alpine AS builder

RUN apk add git gcc libc-dev && \
    git clone https://github.com/indes/flowerss-bot.git && \
    cd flowerss-bot && \
    go build -a -ldflags "-s -w" -o /rssbot


FROM alpine:latest

ENV TZ="Asia/Shanghai"

RUN apk add --no-cache tzdata ca-certificates && \
    rm -rf /var/cache/apk/*

COPY --from=builder /rssbot /usr/bin/

VOLUME /rssbot
WORKDIR /rssbot

ENTRYPOINT ["rssbot", "-c"]
CMD ["/rssbot/config.yml"]