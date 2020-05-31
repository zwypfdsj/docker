FROM golang:alpine AS builder

ENV CGO_ENABLED=0

WORKDIR /

RUN apk add git wget && \
    git clone https://github.com/v2ray/v2ray-core.git && \
    cd /v2ray-core/main && \
    go build -a -ldflags "-s -w" -o /v2ray && \
    cd /v2ray-core/infra/control/main && \
    go build -a -ldflags "-s -w" -o /v2ctl && \
    wget -O /geosite.dat https://github.com/v2ray/domain-list-community/releases/latest/download/dlc.dat && \
    wget -O /geoip.dat https://github.com/v2ray/geoip/releases/latest/download/geoip.dat

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