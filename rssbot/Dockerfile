FROM golang:alpine AS builder

#ENV CGO_ENABLED=0

RUN apk add git gcc libc-dev && \
    go get -u -d github.com/indes/flowerss-bot/... && \
    go build -a -ldflags "-s -w" -o /go/flowerss-bot github.com/indes/flowerss-bot

FROM alpine:latest

ENV TZ=Asia/Shanghai

RUN apk add --no-cache -U tzdata ca-certificates && \
    rm -rf /var/cache/apk/*

COPY --from=builder /go/flowerss-bot /usr/bin

VOLUME /rssbot
WORKDIR /rssbot

CMD ["flowerss-bot"]