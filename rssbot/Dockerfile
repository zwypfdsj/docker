FROM golang:alpine AS builder

#ENV CGO_ENABLED=0

RUN apk add git gcc libc-dev && \
    go get -u -d github.com/indes/flowerss-bot/... && \
    go build -a -ldflags "-w -s" -o /go/flowerss-bot github.com/indes/flowerss-bot

FROM alpine:latest

ENV TZ=Asia/Shanghai

RUN apk add --no-cache tzdata ca-certificates && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*

COPY --from=builder /go/flowerss-bot /usr/bin

VOLUME /rssbot
WORKDIR /rssbot

CMD ["flowerss-bot"]