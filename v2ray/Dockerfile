FROM golang:alpine AS builder

ENV CGO_ENABLED=0

RUN apk add --no-cache git wget unzip && \
    go get -insecure -u -d v2ray.com/core/... && \
    go build -a -ldflags "-s -w" -o /go/v2ray v2ray.com/core/main && \
    go build -a -ldflags "-s -w" -o /go/v2ctl v2ray.com/core/infra/control/main && \
    wget -O geosite.dat https://github.com/v2ray/domain-list-community/releases/latest/download/dlc.dat && \
    wget -O geoip.dat https://github.com/v2ray/geoip/releases/latest/download/geoip.dat

FROM alpine:latest

ENV TZ=Asia/Shanghai

RUN apk add --no-cache tzdata ca-certificates && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo "${TZ}" >  /etc/timezone && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*

COPY --from=builder /go/v2ray /usr/bin
COPY --from=builder /go/v2ctl /usr/bin
COPY --from=builder /go/geoip.dat /usr/bin
COPY --from=builder /go/geosite.dat /usr/bin

CMD [ "v2ray" ]