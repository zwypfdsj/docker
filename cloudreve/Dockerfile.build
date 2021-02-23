FROM golang:latest

RUN apt update && apt install -y git curl && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt update && apt install -y yarn

RUN cd /opt && \
    curl -L -O https://musl.cc/x86_64-linux-musl-native.tgz && \
    curl -L -O https://musl.cc/aarch64-linux-musl-cross.tgz && \
    tar -zxf x86_64-linux-musl-native.tgz && \
    tar -zxf aarch64-linux-musl-cross.tgz

RUN git clone --recurse-submodules https://github.com/cloudreve/Cloudreve.git /Cloudreve && \
    cd /Cloudreve/assets && \
    yarn install && \
    yarn run build

RUN cd /Cloudreve && \
    go get github.com/rakyll/statik && \
    statik -src=assets/build/  -include=*.html,*.js,*.json,*.css,*.png,*.svg,*.ico -f

RUN cd /Cloudreve && \
    export PATH=$PATH:/opt/x86_64-linux-musl-native/bin && \
    export PATH=$PATH:/opt/aarch64-linux-musl-cross/bin && \
    export COMMIT_SHA=$(git rev-parse --short HEAD) && \
    export VERSION=$(git describe --tags) && \
    CGO_ENABLED=1 CC=x86_64-linux-musl-gcc GOOS=linux GOARCH=amd64 go build -a -ldflags "-s -w --extldflags '-static' -X 'github.com/HFO4/cloudreve/pkg/conf.BackendVersion=$VERSION' -X 'github.com/HFO4/cloudreve/pkg/conf.LastCommit=$COMMIT_SHA'" -o cloudreve-amd64 && \
    CGO_ENABLED=1 CC=aarch64-linux-musl-gcc GOOS=linux GOARCH=arm64 go build -a -ldflags "-s -w --extldflags '-static' -X 'github.com/HFO4/cloudreve/pkg/conf.BackendVersion=$VERSION' -X 'github.com/HFO4/cloudreve/pkg/conf.LastCommit=$COMMIT_SHA'" -o cloudreve-arm64