#!/bin/sh

[[ -e aria2.session ]] || touch aria2.session

[[ "$TRACKERS" = "no" ]] || bash /aria2/tracker.sh

[[ $RPC_SECRET ]] &&
    sed -i "s|.*rpc-secret=.*|rpc-secret=${RPC_SECRET}|g" /aria2/aria2.conf

ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]
then
    curl -L -o aria2c https://github.com/zwypfdsj/docker/releases/latest/download/aria2c-amd64
fi

if [ "$ARCH" = "aarch64" ]
then
    curl -L -o aria2c https://github.com/zwypfdsj/docker/releases/latest/download/aria2c-arm64
fi

chmod +x /aria2/aria2c
/aria2/aria2c --conf-path=/aria2/aria2.conf > aria2.log 2>&1 &
tail -F aria2.log