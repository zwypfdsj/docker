FROM golang:latest AS builder

RUN apt-get update && \
    apt-get install -y git && \
    git clone https://github.com/librespeed/speedtest-go.git && \
    cd speedtest-go && \
    CGO_ENABLED=0 go build -a -trimpath -ldflags "-s -w" -o /speedtest-go && \
    chmod +x /speedtest-go


FROM debian:stable-slim

ENV TZ="Asia/Shanghai"

RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /speedtest-go /speedtest/speedtest-go

WORKDIR /speedtest
VOLUME /speedtest

CMD ["/speedtest/speedtest-go"]