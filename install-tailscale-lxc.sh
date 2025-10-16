#!/bin/bash

read -p "Enter container ID: " cid

# Check container status
status=$(pct status "$cid" 2>/dev/null | awk '{print $2}')

if [[ "$status" == "running" ]]; then
    echo "stopping ct $cid"
    pct stop "$cid"
else
    echo "ct $cid already stopped — continuing"
fi

file="/etc/pve/lxc/${cid}.conf"

commands="lxc.cgroup2.devices.allow: c 10:200 rwm
lxc.mount.entry: /dev/net/tun dev/net/tun none bind,create=file"

echo "$commands" >> "$file"


echo "finished script"
echo "restarting container"

pct start "$cid"
