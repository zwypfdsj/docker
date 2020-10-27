FROM golang:alpine AS builder

RUN apk add git wget && \
    git clone https://github.com/Dreamacro/clash.git && \
    cd clash && \
    export VERSION=$(git describe --tags || echo "unknown version") && \
    export BUILDTIME=$(date -u) && \
    CGO_ENABLED=0 go build -a -ldflags '-s -w -X "github.com/Dreamacro/clash/constant.Version=$(VERSION)" -X "github.com/Dreamacro/clash/constant.BuildTime=$(BUILDTIME)"' -o /clash && \
    wget -O /Country.mmdb https://github.com/Dreamacro/maxmind-geoip/releases/latest/download/Country.mmdb

FROM alpine:latest

ENV TZ=Asia/Shanghai

RUN apk add --no-cache tzdata ca-certificates && \
    rm -rf /var/cache/apk/*

COPY --from=builder /Country.mmdb /clash/
COPY --from=builder /clash /usr/bin/

ENTRYPOINT ["clash", "-d"]
CMD ["/clash"]