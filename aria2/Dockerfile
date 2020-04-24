FROM alpine:latest

ENV TZ=Asia/Shanghai

RUN apk add --no-cache bash tzdata curl ca-certificates && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo "${TZ}" > /etc/timezone && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*

COPY aria2 /aria2/

RUN chmod -R 777 /aria2

VOLUME /aria2
WORKDIR /aria2

ENTRYPOINT [ "/aria2/run.sh" ]