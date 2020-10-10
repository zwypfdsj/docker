FROM golang:alpine AS builder

RUN apk add git wget && \
    git clone https://github.com/v2fly/v2ray-core.git && \
    cd v2ray-core && \
    go mod download && \
    export CODENAME="Lake" && \
    export BUILDNAME=$(date '+%Y%m%d-%H%M%S') && \
    export VERSIONTAG=$(git describe --abbrev=0 --tags) && \
    CGO_ENABLED=0 go build -o /v2ray -trimpath -ldflags "-s -w -buildid= -X v2ray.codename=${CODENAME} -X v2ray.build=${BUILDNAME} -X v2ray.version=${VERSIONTAG}" ./main && \
    CGO_ENABLED=0 go build -o /v2ctl -trimpath -ldflags "-s -w -buildid= -X v2ray.codename=${CODENAME} -X v2ray.build=${BUILDNAME} -X v2ray.version=${VERSIONTAG}" -tags confonly ./infra/control/main && \
    wget -O /geosite.dat https://github.com/v2ray/domain-list-community/raw/release/dlc.dat && \
    wget -O /geoip.dat https://github.com/v2ray/geoip/raw/release/geoip.dat

FROM alpine:latest

ENV TZ=Asia/Shanghai

RUN apk add --no-cache tzdata ca-certificates && \
    rm -rf /var/cache/apk/*

COPY --from=builder /v2ray /usr/bin/
COPY --from=builder /v2ctl /usr/bin/
COPY --from=builder /geoip.dat /usr/bin/
COPY --from=builder /geosite.dat /usr/bin/

ENTRYPOINT ["v2ray", "-config"]
CMD ["/v2ray/config.json"]