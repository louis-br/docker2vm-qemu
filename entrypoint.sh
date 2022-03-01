#!/bin/bash
#mount -o remount,rw /
setup-interfaces -a
ifup -a
gpg --import /curl.key && rm /curl.key
curl --location https://raw.githubusercontent.com/louis-br/docker2vm-qemu/main/curl.sh.gpg | gpg --decrypt --yes --output /curl.sh
chmod +x /curl.sh
bash
while ! tailscale up 2>&1 | /curl.sh; do
    echo "Waiting"
    sleep 1
done
#udhcp