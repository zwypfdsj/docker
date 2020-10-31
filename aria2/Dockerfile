FROM alpine:latest

ENV TZ="Asia/Shanghai"

COPY aria2 /aria2/

RUN apk add --no-cache bash tzdata curl ca-certificates && \
    rm -rf /var/cache/apk/* && \
    chmod -R 777 /aria2

VOLUME /aria2
WORKDIR /aria2

ENTRYPOINT [ "/aria2/run.sh" ]