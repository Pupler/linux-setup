# shellcheck shell=bash

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

update_system() {
    print_status "Updating system..."

    if pacman -Syu; then
        print_success "System updated"
    else
        print_error "System update failed"
    fi
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