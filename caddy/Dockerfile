FROM golang:alpine AS builder

RUN apk add git && \
    go get -u github.com/caddyserver/xcaddy/cmd/xcaddy && \
    xcaddy build --with github.com/caddy-dns/cloudflare --output /opt/caddy

FROM alpine:latest

ENV TZ=Asia/Shanghai
ENV HOME /www

RUN apk add --no-cache tzdata ca-certificates && \
    rm -rf /var/cache/apk/*

COPY --from=builder /opt/caddy /caddy

VOLUME /www
WORKDIR /www

ENTRYPOINT ["/caddy", "run", "--config"]
CMD ["/www/Caddyfile"]