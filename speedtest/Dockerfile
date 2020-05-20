FROM golang:alpine AS builder

ENV CGO_ENABLED=0

RUN apk add git && \
    git clone -b go https://github.com/librespeed/speedtest.git && \
    cd speedtest && \
    go build -a -ldflags "-s -w" -o /go/speedtest && \
    chmod +x /go/speedtest

FROM alpine:latest

ENV TZ=Asia/Shanghai

COPY --from=builder /go/speedtest /speedtest/speedtest

RUN apk add --no-cache tzdata ca-certificates && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo "${TZ}" > /etc/timezone && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*

VOLUME /speedtest
WORKDIR /speedtest

CMD ["/speedtest/speedtest"]