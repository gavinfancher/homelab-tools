#!/usr/bin/env bash

curl -fsSL https://tailscale.com/install.sh | sh

tailscale set --operator="$USER"

tailscale up
