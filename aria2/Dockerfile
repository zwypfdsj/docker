FROM debian:stable-slim

ENV TZ="Asia/Shanghai"

COPY aria2 /aria2/

RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*
    chmod -R 777 /aria2

WORKDIR /aria2
VOLUME /aria2

ENTRYPOINT [ "/aria2/run.sh" ]