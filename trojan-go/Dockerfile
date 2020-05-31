FROM golang:alpine AS builder

ENV CGO_ENABLED=0

RUN apk add git wget && \
    git clone https://github.com/p4gefau1t/trojan-go.git && \
    cd trojan-go && \
    go build -a -tags "full" -ldflags "-s -w" -o /trojan-go && \
    wget https://github.com/v2ray/domain-list-community/raw/release/dlc.dat -O /geosite.dat && \
    wget https://github.com/v2ray/geoip/raw/release/geoip.dat -O /geoip.dat

FROM alpine:latest

ENV TZ=Asia/Shanghai

RUN apk add --no-cache tzdata ca-certificates && \
    rm -rf /var/cache/apk/*

COPY --from=builder /trojan-go /usr/bin/
COPY --from=builder /geosite.dat /usr/bin/
COPY --from=builder /geoip.dat /usr/bin/

ENTRYPOINT ["trojan-go", "-config"]
CMD ["/trojan-go/config.json"]