FROM golang:latest AS builder

RUN go get -u github.com/caddyserver/xcaddy/cmd/xcaddy && \
    xcaddy build --with github.com/caddy-dns/cloudflare --output /opt/caddy


FROM debian:stable-slim

ENV TZ="Asia/Shanghai"
ENV HOME /www

RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /opt/caddy /caddy

WORKDIR /www
VOLUME /www

ENTRYPOINT ["/caddy", "run", "--config"]
CMD ["/www/Caddyfile"]