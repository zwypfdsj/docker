FROM golang:latest AS builder

RUN apt-get update && \
    apt-get install -y git wget && \
    git clone https://github.com/v2fly/v2ray-core.git && \
    cd v2ray-core && \
    export CODENAME=$(git rev-parse --short HEAD) && \
    export BUILDNAME=$(date '+%Y%m%d-%H%M%S') && \
    export VERSIONTAG=$(git describe --abbrev=0 --tags) && \
    export LDFLAGS="-s -w -buildid= -X github.com/v2fly/v2ray-core/v5.codename=${CODENAME} -X github.com/v2fly/v2ray-core/v5.build=${BUILDNAME} -X github.com/v2fly/v2ray-core/v5.version=${VERSIONTAG}" && \
    CGO_ENABLED=0 go build -a -o /v2ray -trimpath -ldflags "$LDFLAGS" ./main && \
    wget -O /geosite.dat https://github.com/v2fly/domain-list-community/raw/release/dlc.dat && \
    wget -O /geoip.dat https://github.com/v2fly/geoip/raw/release/geoip.dat


FROM debian:stable-slim

ENV TZ="Asia/Shanghai"

RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /v2ray /usr/bin/
COPY --from=builder /geoip.dat /usr/bin/
COPY --from=builder /geosite.dat /usr/bin/

WORKDIR /v2ray
VOLUME /v2ray

CMD [ "v2ray", "run", "-config", "/v2ray/config.json" ]