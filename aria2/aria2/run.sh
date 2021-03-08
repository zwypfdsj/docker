#!/bin/sh

[[ -e aria2.session ]] || touch aria2.session

[[ "$TRACKERS" = "no" ]] || bash /aria2/tracker.sh

[[ $RPC_SECRET ]] && sed -i "s|.*rpc-secret=.*|rpc-secret=${RPC_SECRET}|g" /aria2/aria2.conf

ARCH=$(uname -m)

if [ "$ARCH" = "x86_64" ]
then
    mv /aria2/aria2c-amd64 /aria2/aria2c && rm /aria2/aria2c-arm64
elif [ "$ARCH" = "aarch64" ]
then
    mv /aria2/aria2c-arm64 /aria2/aria2c && rm /aria2/aria2c-amd64
else
    exit 1
fi

chmod +x /aria2/aria2c
/aria2/aria2c --conf-path=/aria2/aria2.conf > aria2.log 2>&1 &
tail -F aria2.log