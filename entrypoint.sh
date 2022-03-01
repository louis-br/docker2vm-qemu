#!/bin/bash
#mount -o remount,rw /
setup-interfaces -a
ifup -a
while ! tailscale up 2>&1 | /curl.sh; do
    echo "Waiting"
    sleep 1
done
bash
#udhcp