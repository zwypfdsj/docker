FROM golang:latest AS builder

RUN apt-get update && \
    apt-get install -y build-essential git && \
    git clone https://github.com/naiba/nezha.git && \
    cd cmd/dashboard && \
    go build -a -trimpath -ldflags="-s -w" -o /dashboard


FROM debian:stable-slim

ENV TZ="Asia/Shanghai"

RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /dashboard /nezha/

WORKDIR /nezha
VOLUME /nezha/data

CMD ["/nezha/dashboard"]