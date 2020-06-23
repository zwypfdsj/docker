FROM golang:alpine AS builder

ENV CGO_ENABLED=0

RUN apk add git && \
    git clone https://github.com/librespeed/speedtest-go.git && \
    cd speedtest-go && \
    go build -a -ldflags "-s -w" -o /speedtest-go && \
    chmod +x /speedtest-go

FROM alpine:latest

ENV TZ=Asia/Shanghai

RUN apk add --no-cache -U tzdata ca-certificates && \
    rm -rf /var/cache/apk/*

COPY --from=builder /speedtest-go /speedtest/speedtest-go

VOLUME /speedtest
WORKDIR /speedtest

CMD ["/speedtest/speedtest-go"]