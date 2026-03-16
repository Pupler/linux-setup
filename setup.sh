#!/bin/bash
set -euo pipefail

# shellcheck disable=SC1091
source "$(dirname "$0")/lib/helpers.sh"
# shellcheck disable=SC1091
source "$(dirname "$0")/lib/packages.sh"

if [ "$EUID" -ne 0 ]; then
    clear
    print_status "Run with sudo: sudo ./setup.sh"
    exit 1
fi

clear
print_status "Hi! The script started."

update_system
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