FROM golang:alpine AS builder

RUN apk add git && \
    git clone https://github.com/filebrowser/filebrowser.git && \
    cd filebrowser && \
    export VERSION=$(git describe --tags) && \
    export COMMIT_SHA=$(git rev-parse --short HEAD) && \
    CGO_ENABLED=0 go build -a -ldflags "-s -w -X 'github.com/filebrowser/filebrowser/v2/version.Version=${VERSION}' -X 'github.com/filebrowser/filebrowser/v2/version.CommitSHA=${COMMIT_SHA}'" -o /filebrowser

FROM alpine:latest

ENV TZ=Asia/Shanghai

RUN apk add --no-cache tzdata ca-certificates mailcap && \
    rm -rf /var/cache/apk/*

COPY --from=builder /filebrowser /filebrowser

ENTRYPOINT ["/filebrowser"]