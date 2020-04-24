FROM golang:alpine AS builder

ENV CGO_ENABLED=0

WORKDIR /

RUN apk add git && \
    git clone -b go https://github.com/librespeed/speedtest && \
    cd speedtest && \
    go build -a -ldflags "-s -w" -o speedtest

FROM alpine:latest

ENV TZ=Asia/Shanghai

RUN apk add --no-cache tzdata ca-certificates && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*

COPY --from=builder /speedtest/speedtest /speedtest/speedtest

VOLUME /speedtest
WORKDIR /speedtest

CMD ["/speedtest/speedtest"]