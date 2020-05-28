FROM golang:alpine AS builder

ENV CGO_ENABLED=0

RUN apk add git && \
    git clone -b go https://github.com/librespeed/speedtest.git /speedtest && \
    cd /speedtest && \
    go build -a -ldflags "-s -w" -o speedtest && \
    chmod +x speedtest

FROM alpine:latest

ENV TZ=Asia/Shanghai

COPY --from=builder /speedtest/speedtest /speedtest/speedtest

RUN apk add --no-cache -U tzdata ca-certificates && \
    rm -rf /var/cache/apk/*

VOLUME /speedtest
WORKDIR /speedtest

CMD ["/speedtest/speedtest"]