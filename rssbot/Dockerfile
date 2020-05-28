FROM golang:alpine AS builder

#ENV CGO_ENABLED=0

RUN apk add git gcc libc-dev && \
    git clone https://github.com/indes/flowerss-bot.git && \
    cd flowerss-bot && \
    go build -a -ldflags "-s -w" -o /go/rssbot

FROM alpine:latest

ENV TZ=Asia/Shanghai

RUN apk add --no-cache -U tzdata ca-certificates && \
    rm -rf /var/cache/apk/*

COPY --from=builder /go/rssbot /usr/bin

VOLUME /rssbot
WORKDIR /rssbot

CMD ["rssbot"]