#!/bin/bash

# This script setups linux after fresh install

GREEN='\033[0;32m'
RESET='\033[0m'

if [ "$EUID" -ne 0 ]; then
    echo "Run with sudo: sudo ./setup.sh"
    exit 1
fi

print_status() {
    echo -e "${GREEN}==>${RESET} $1"
}

print_status "Hi! The script started."