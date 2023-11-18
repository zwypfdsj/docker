FROM golang:latest AS builder

RUN apt-get update && \
    apt-get install -y git wget && \
    git clone https://github.com/SagerNet/sing-box && \
    cd sing-box && \
    export COMMIT=$(git rev-parse --short HEAD) && \
    export VERSION=$(go run ./cmd/internal/read_tag) && \
    export LDFLAGS="-s -w -buildid= -X github.com/sagernet/sing-box/constant.Version=${VERSION}" && \
    CGO_ENABLED=0 go build -a -trimpath -tags with_gvisor,with_quic,with_dhcp,with_wireguard,with_ech,with_utls,with_reality_server,with_clash_api,with_acme -o /singbox -ldflags "$LDFLAGS" ./cmd/sing-box

FROM debian:stable-slim

ENV TZ="Asia/Shanghai"

RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /singbox /usr/bin/singbox

ENTRYPOINT ["singbox"]