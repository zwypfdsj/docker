FROM golang:alpine AS builder

#ENV CGO_ENABLED=0

RUN apk add git gcc musl-dev && \
    git clone https://github.com/ginuerzh/gost.git && \
    cd gost/cmd/gost && \
    go build -a -ldflags "-s -w" -o /gost

FROM alpine:latest

ENV TZ=Asia/Shanghai

RUN apk add --no-cache tzdata ca-certificates && \
    rm -rf /var/cache/apk/*

COPY --from=builder /gost /gost

ENTRYPOINT ["/gost"]