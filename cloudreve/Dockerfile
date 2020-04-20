FROM golang:latest

WORKDIR /

RUN apt update && apt install -y git curl gcc libc6-dev gcc-aarch64-linux-gnu libc6-dev-arm64-cross binutils && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt update && apt install -y yarn && \
    git clone --recurse-submodules https://github.com/cloudreve/Cloudreve

RUN cd /Cloudreve && \
    cd assets && \
    yarn install && \
    yarn run build

RUN cd /Cloudreve && \
    go get github.com/rakyll/statik && \
    statik -src=assets/build/  -include=*.html,*.js,*.json,*.css,*.png,*.svg,*.ico -f

RUN cd /Cloudreve && \
    export COMMIT_SHA=$(git rev-parse --short HEAD) && \
    export VERSION=$(git describe --tags) && \
    CC=gcc GOOS=linux GOARCH=amd64 CGO_ENABLED=1 go build -a -ldflags "-w -s --extldflags '-static' -X 'github.com/HFO4/cloudreve/pkg/conf.BackendVersion=$VERSION' -X 'github.com/HFO4/cloudreve/pkg/conf.LastCommit=$COMMIT_SHA'" -o cloudreve-amd64
    CC=aarch64-linux-gnu-gcc GOOS=linux GOARCH=arm64 CGO_ENABLED=1 go build -a -ldflags "-w -s --extldflags '-static' -X 'github.com/HFO4/cloudreve/pkg/conf.BackendVersion=$VERSION' -X 'github.com/HFO4/cloudreve/pkg/conf.LastCommit=$COMMIT_SHA'" -o cloudreve-arm64