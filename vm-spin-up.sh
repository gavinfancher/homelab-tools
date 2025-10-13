#!/bin/bash

read -p "source of clone: " clone_source
read -p "clone number: " clone_number
read -p "clone name: " clone_name
read -p "clone disk location: " clone_location

read -p "clone cores: " clone_cores
read -p "clone memory (in GB): " clone_mem_in_GB

clone_mem_in_MB=$((clone_mem_in_GB * 1024))

qm clone "$clone_source" "$clone_number" --name "$clone_name" --full --storage "$clone_location"
qm set "$clone_number" --cores "$clone_cores" --memory "$clone_mem_in_MB"
