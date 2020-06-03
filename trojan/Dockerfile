FROM alpine:latest AS builder

RUN apk add git build-base cmake boost-dev openssl-dev mariadb-connector-c-dev && \
    git clone https://github.com/trojan-gfw/trojan.git && \
    cd trojan && \
    cmake . && \
    make && \
    strip -s trojan

FROM alpine:latest

ENV TZ=Asia/Shanghai

RUN apk add --no-cache tzdata ca-certificates libstdc++ boost-system boost-program_options mariadb-connector-c && \
    rm -rf /var/cache/apk/*

COPY --from=builder /trojan/trojan /usr/bin/

ENTRYPOINT ["trojan"]
CMD ["/trojan/config.json"]