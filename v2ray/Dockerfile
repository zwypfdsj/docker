FROM golang:alpine AS builder

RUN apk add git wget && \
    git clone https://github.com/v2fly/v2ray-core.git && \
    cd v2ray-core && \
    go mod download && \
    export CODENAME=$(git rev-parse --short HEAD) && \
    export BUILDNAME=$(date '+%Y%m%d-%H%M%S') && \
    export LDFLAGS="-s -w -buildid= -X v2ray.com/core.codename=${CODENAME} -X v2ray.com/core.build=${BUILDNAME}" && \
    CGO_ENABLED=0 go build -o /v2ray -trimpath -ldflags "$LDFLAGS" ./main && \
    CGO_ENABLED=0 go build -o /v2ctl -trimpath -ldflags "$LDFLAGS" -tags confonly ./infra/control/main && \
    wget -O /geosite.dat https://github.com/v2fly/domain-list-community/raw/release/dlc.dat && \
    wget -O /geoip.dat https://github.com/v2fly/geoip/raw/release/geoip.dat

FROM alpine:latest

ENV TZ=Asia/Shanghai

RUN apk add --no-cache tzdata ca-certificates && \
    rm -rf /var/cache/apk/*

COPY --from=builder /v2ray /usr/bin/
COPY --from=builder /v2ctl /usr/bin/
COPY --from=builder /geoip.dat /usr/bin/
COPY --from=builder /geosite.dat /usr/bin/

ENTRYPOINT ["v2ray", "-config"]
CMD ["/v2ray/config.json"]