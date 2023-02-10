FROM golang:latest AS builder

RUN apt-get update && \
    apt-get install -y git wget && \
    git clone https://github.com/Dreamacro/clash.git && \
    cd clash && \
    export VERSION=$(git describe --abbrev=0 --tags) && \
    export BUILDTIME=$(date '+%Y%m%d-%H%M%S') && \
    export LDFLAGS="-s -w -buildid= -X github.com/Dreamacro/clash/constant.Version=${VERSION} -X github.com/Dreamacro/clash/constant.BuildTime=${BUILDTIME}" && \
    CGO_ENABLED=0 go build -a -o /clash -trimpath -ldflags "$LDFLAGS" ./main && \
    wget -O /Country.mmdb https://github.com/Dreamacro/maxmind-geoip/releases/latest/download/Country.mmdb


FROM debian:stable-slim

ENV TZ="Asia/Shanghai"

RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /clash /usr/bin/
COPY --from=builder /Country.mmdb /root/.config/clash/

CMD [ "clash" ]