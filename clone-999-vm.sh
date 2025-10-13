#!/bin/bash

default_source=999
defualt_storage="samsung-2tb-a"

echo "using $default_source as source for clone"
read -p "clone number (new VMID): " clone_number
read -p "clone name: " clone_name
echo "using $defualt_storage as storage for clone"

read -p "clone cores: " clone_cores
read -p "clone memory (in GB): " clone_mem_in_GB
clone_mem_in_MB=$((clone_mem_in_GB * 1024))

qm clone $clone_source $clone_number --name $clone_name --full --storage $defualt_storage
qm set $clone_number --cores $clone_cores --memory $clone_mem_in_MB
qm start $clone_number
