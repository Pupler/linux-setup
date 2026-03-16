# linux-setup

Automates Arch Linux setup after a fresh install.

## Requirements

- Arch Linux
- sudo

## Usage

```bash
sudo ./setup.sh
```

## What it does

- Updates system before installation
- Installs packages (skips already installed)
- Installs yay (AUR helper)
- Installs AUR packages
- Configures git (name, email)

## Packages

| Package | Description |
|---------|-------------|
| git | Version control |
| curl | HTTP requests |
| vim | Text editor |
| htop | Process monitor |
| firefox | Web browser |
| telegram-desktop | Messaging |
| vlc | Media player |
| neofetch | System info |
| unzip | Archive tool |
| wget | File downloader |

## AUR Packages

| Package | Description |
|---------|-------------|
| visual-studio-code-bin | Code editor |
| anki | Flashcard app |

## Project Structure

```
linux-setup/
├── setup.sh
└── lib/
    ├── helpers.sh
    └── packages.sh
```
