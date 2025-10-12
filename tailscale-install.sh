#!/usr/bin/env bash

curl -fsSL https://tailscale.com/install.sh | sh

tailscale set --operator="$USER"

USER_NAME="${SUDO_USER:-$USER}"
tailscale set --operator="$USER_NAME"

tailscale up
