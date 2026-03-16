#!/bin/bash

# This script setups Arch Linux after fresh install

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
RESET='\033[0m'
LOG_FILE='setup.log'

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

AUR_PACKAGES=(
    visual-studio-code-bin
    anki
)

print_status() {
    echo -e "${GREEN}==>${RESET} $1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "${LOG_FILE}"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${RESET} $1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [SUCCESS] $1" >> "${LOG_FILE}"
}

print_error() {
    echo -e "${RED}[ERROR]${RESET} $1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] $1" >> "${LOG_FILE}"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${RESET} $1"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [WARNING] $1" >> "${LOG_FILE}"
}

install_packages() {
    for package in "${PACKAGES[@]}"; do
        if pacman -Q "${package}" &>/dev/null; then
            print_warning "${package} already installed"
        else
            print_status "Installing ${package}..."
            if pacman -S --noconfirm "${package}"; then
                print_success "${package} installed"
            else
                print_error "Failed to install ${package}"
            fi
        fi
    done
}

install_yay() {
    if pacman -Q yay &>/dev/null; then
        print_warning "yay already installed"
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

install_aur_packages() {
    for aur_package in "${AUR_PACKAGES[@]}"; do
        if pacman -Q "${aur_package}" &>/dev/null; then
            print_warning "${aur_package} is already installed"
        else
            print_status "Installing ${aur_package} from AUR..."
            yay -S --noconfirm "${aur_package}"
        fi
    done
}

if [ "$EUID" -ne 0 ]; then
    clear
    print_status "Run with sudo: sudo ./setup.sh"
    exit 1
fi

clear
print_status "Hi! The script started."

install_packages
install_yay
install_aur_packages

read -rp "Configure git? (y/n): " git_conf
if [ "${git_conf}" == "y" ]; then
    print_status "Configuring git..."
    read -rp "Your name: " git_name
    read -rp "Your email: " git_email
    git config --global user.name "${git_name}"
    git config --global user.email "${git_email}"
fi

exit 0