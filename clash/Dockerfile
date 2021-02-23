FROM golang:latest AS builder

RUN apt-get update && \
    apt-get install -y git wget && \
    wget -O /Country.mmdb https://github.com/Dreamacro/maxmind-geoip/releases/latest/download/Country.mmdb && \
    git clone https://github.com/Dreamacro/clash.git && \
    cd clash && \
    export VERSION=$(git describe --tags || echo "unknown version") && \
    export BUILDTIME=$(date -u) && \
    CGO_ENABLED=0 go build -a -trimpath -ldflags '-s -w -X "github.com/Dreamacro/clash/constant.Version=$(VERSION)" -X "github.com/Dreamacro/clash/constant.BuildTime=$(BUILDTIME)"' -o /clash


FROM debian:stable-slim

ENV TZ="Asia/Shanghai"

RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /Country.mmdb /clash/
COPY --from=builder /clash /usr/bin/

ENTRYPOINT ["clash", "-d"]
CMD ["/clash"]