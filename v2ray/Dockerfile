FROM golang:alpine AS builder

ENV CGO_ENABLED=0

RUN apk add git wget && \
    git clone https://github.com/v2fly/v2ray-core.git && \
    cd v2ray-core && \
    go build -a -ldflags "-s -w" -o /v2ray ./main && \
    go build -a -ldflags "-s -w" -o /v2ctl ./infra/control/main && \
    wget -O /geosite.dat https://github.com/v2ray/domain-list-community/raw/release/dlc.dat && \
    wget -O /geoip.dat https://github.com/v2ray/geoip/raw/release/geoip.dat

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