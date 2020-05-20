FROM golang:alpine AS builder

WORKDIR /

RUN apk add git && \
    git clone https://github.com/librespeed/speedtest.git -b go && \
    cd speedtest && \
    CGO_ENABLED=0 go build -a -ldflags "-s -w" -o speedtest && \
    chmod +x speedtest

FROM alpine:latest

ENV TZ=Asia/Shanghai

COPY --from=builder /speedtest/speedtest /speedtest/speedtest

RUN apk add --no-cache tzdata ca-certificates && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo "${TZ}" > /etc/timezone && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*

VOLUME /speedtest
WORKDIR /speedtest

CMD ["/speedtest/speedtest"]