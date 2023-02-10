FROM node:lts AS fe-builder

RUN apt-get update && apt-get install -y git && \
    git clone --recurse-submodules https://github.com/cloudreve/Cloudreve.git /Cloudreve && \
    cd /Cloudreve/assets && \
    yarn install && \
    yarn run build


FROM golang:latest AS be-builder

COPY --from=fe-builder /Cloudreve /Cloudreve

RUN apt-get update && \
    apt-get install -y build-essential git && \
    cd /Cloudreve && \
    export COMMIT_SHA=$(git rev-parse --short HEAD)  && \
    export VERSION=$(git describe --tags) && \
    go build -a -trimpath -ldflags "-s -w -X 'github.com/cloudreve/Cloudreve/v3/pkg/conf.BackendVersion=${VERSION}' -X 'github.com/cloudreve/Cloudreve/v3/pkg/conf.LastCommit=${COMMIT_SHA}'" -o cloudreve


FROM debian:stable-slim

ENV TZ="Asia/Shanghai"

RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=be-builder /Cloudreve/cloudreve /Cloudreve/cloudreve

WORKDIR /Cloudreve
VOLUME /Cloudreve

ENTRYPOINT ["/Cloudreve/cloudreve"]