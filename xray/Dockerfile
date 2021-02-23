FROM golang:latest AS builder

RUN apt-get update && \
    apt-get install -y git wget && \
    git clone https://github.com/XTLS/Xray-core.git && \
    cd Xray-core && \
    export CODENAME=$(git rev-parse --short HEAD) && \
    export BUILDNAME=$(date '+%Y%m%d-%H%M%S') && \
    export VERSIONTAG=$(git describe --abbrev=0 --tags) && \
    export LDFLAGS="-s -w -buildid= -X github.com/xtls/xray-core/core.codename=${CODENAME} -X github.com/xtls/xray-core/core.build=${BUILDNAME} -X github.com/xtls/xray-core/core.version=${VERSIONTAG}" && \
    CGO_ENABLED=0 go build -a -o /xray -trimpath -ldflags "$LDFLAGS" ./main && \
    wget -O /geosite.dat https://github.com/v2fly/domain-list-community/raw/release/dlc.dat && \
    wget -O /geoip.dat https://github.com/v2fly/geoip/raw/release/geoip.dat


FROM debian:stable-slim

ENV TZ="Asia/Shanghai"

RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /xray /usr/bin/
COPY --from=builder /geoip.dat /usr/bin/
COPY --from=builder /geosite.dat /usr/bin/

WORKDIR /xray
VOLUME /xray

ENTRYPOINT ["xray", "-config"]
CMD ["/xray/config.json"]