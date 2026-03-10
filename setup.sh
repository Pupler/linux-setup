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
    clear
    print_status "Run with sudo: sudo ./setup.sh"
    exit 1
fi

clear
print_status "Hi! The script started."

for package in "${PACKAGES[@]}"; do
    if pacman -Q "${package}" &>/dev/null; then
        print_status "${package} already installed"
    else
        print_status "Installing ${package}..."
        pacman -S --noconfirm "${package}"
    fi
done

read -rp "Configure git? (y/n)" git_conf
if [ "${git_conf}" == "y" ]; then
    print_status "Configuring git..."
    read -rp "Your name: " git_name
    read -rp "Your email: " git_email
    git config --global user.name "${git_name}"
    git config --global user.email "${git_email}"
fi

exit 0