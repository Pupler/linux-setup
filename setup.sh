#!/bin/bash

# This script setups Arch Linux after fresh install

GREEN='\033[0;32m'
RESET='\033[0m'
LOG_FILE="setup.log"

PACKAGES=(
    git
    curl
    vim
    htop
    firefox
    telegram-desktop
    vlc
    neofetch
    unzip
    wget
)

print_status() {
    echo -e "${GREEN}==>${RESET} $1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "${LOG_FILE}"
}

install_yay() {
    if pacman -Q yay &>/dev/null; then
        print_status "yay already installed"
    else
        print_status "Installing yay..."
        pacman -S --noconfirm base-devel git
        cd /tmp || exit 1
        git clone https://aur.archlinux.org/yay.git
        chown -R "${SUDO_USER}:${SUDO_USER}" yay
        cd yay || exit 1
        sudo -u "${SUDO_USER}" makepkg -si --noconfirm
        cd ~ || exit 1
    fi
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

install_yay

read -rp "Configure git? (y/n): " git_conf
if [ "${git_conf}" == "y" ]; then
    print_status "Configuring git..."
    read -rp "Your name: " git_name
    read -rp "Your email: " git_email
    git config --global user.name "${git_name}"
    git config --global user.email "${git_email}"
fi

exit 0