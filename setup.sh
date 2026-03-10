#!/bin/bash

# This script setups Arch Linux after fresh install

GREEN='\033[0;32m'
RESET='\033[0m'

PACKAGES=(
    git
    curl
    vim
    htop
)

print_status() {
    echo -e "${GREEN}==>${RESET} $1"
}

if [ "$EUID" -ne 0 ]; then
    print_status "Run with sudo: sudo ./setup.sh"
    exit 1
fi

print_status "Hi! The script started."

for package in "${PACKAGES[@]}"; do
    print_status "Installing ${package}..."
    pacman -S --noconfirm "${package}"
done