#!/usr/bin/env bash

curl -fsSL https://tailscale.com/install.sh | sh

sudo tailscale set --operator="$USER"

read -p "enter linux setup key: " TS_KEY

sudo tailscale up --authkey="$TS_KEY"

echo "success!"
