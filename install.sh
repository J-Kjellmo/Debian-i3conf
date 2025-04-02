#!/bin/bash

# Set to exit on error
set -e

# List of packages to install
packages=(
    "apt-listchanges"
    "bash-completion"
    "bind9-dnsutils"
    "bind9-host"
    "btop"
    "build-essential"
    "busybox"
    "bzip2"
    "ca-certificates"
    "console-setup"
    "curl"
    "dbus"
    "debian-faq"
    "discover"
    "doc-debian"
    "dolphin"
    "dosfstools"
    "feh"
    "file"
    "firefox-esr"
    "flameshot"
    "flatpak"
    "fonts-font-awesome"
    "gettext-base"
    "git"
    "groff-base"
    "grub-common"
    "grub-efi-amd64"
    "i3"
    "inetutils-telnet"
    "initramfs-tools"
    "installation-report"
    "intel-microcode"
    "keepass2"
    "keyboard-configuration"
    "krb5-locales"
    "laptop-detect"
    "liblockfile-bin"
    "libnss-systemd"
    "libpam-systemd"
    "linux-image-amd64"
    "locales"
    "lsof"
    "lxappearance"
    "man-db"
    "manpages"
    "materia-gtk-theme"
    "media-types"
    "mime-support"
    "ncurses-term"
    "netcat-traditional"
    "network-manager"
    "nodejs"
    "npm"
    "openssh-client"
    "papirus-icon-theme"
    "pciutils"
    "perl"
    "picom"
    "pipewire"
    "pipewire-pulse"
    "polybar"
    "popularity-contest"
    "procps"
    "psmisc"
    "python3-reportbug"
    "reportbug"
    "ripgrep"
    "rofi"
    "smbclient"
    "sudo"
    "sysstat"
    "systemd-timesyncd"
    "task-english"
    "task-laptop"
    "terminator"
    "traceroute"
    "ucf"
    "unzip"
    "usbutils"
    "wamerican"
    "wget"
    "xdotool"
    "xinit"
    "xorg"
    "xz-utils"
    "yad"
    "zsh"
    "zstd"
)

# Preconfigure package selections
echo "Preconfiguring package selections..."
echo "popularity-contest popularity-contest/participate boolean false" | sudo debconf-set-selections

# Update and install essential packages
echo "Updating package list and upgrading..."
sudo apt update && sudo apt upgrade -y

# Install packages without stopping the script
echo "Installing packages..."
DEBIAN_FRONTEND=readline sudo apt install -y "${packages[@]}"

# Check if Oh My Zsh is already installed
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is already installed. Skipping installation."
else
    echo "Installing Oh My Zsh..."
    export RUNZSH=no  # Prevents the script from switching shells immediately
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "Oh My Zsh installation complete!"
fi

# Set Zsh as default shell for the current user
if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo "Changing default shell to Zsh..."
    sudo chsh -s "$(command -v zsh)" "$USER"
fi

# Check if Homebrew is already installed
if command -v brew &>/dev/null; then
    echo "Homebrew is already installed. Skipping installation."
else
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' | tee -a ~/.bashrc ~/.profile ~/.zshrc
    echo "Homebrew installation complete!"
fi

# Install packages via Homebrew
brew install gh neovim gcc

echo "Enter your Git name (or press Enter to skip):"
read GIT_NAME

echo "Enter your Git email (or press Enter to skip):"
read GIT_EMAIL

if [ -n "$GIT_NAME" ] && [ -n "$GIT_EMAIL" ]; then
    git config --global user.name "$GIT_NAME"
    git config --global user.email "$GIT_EMAIL"
    echo "Git config set:"
    git config --global --list | grep 'user\."
else
    echo "Skipping Git global config."
fi

echo "Enter your GitHub Personal Access Token (or press Enter to skip):"
read -s GITHUB_TOKEN

if [ -n "$GITHUB_TOKEN" ]; then
    echo "$GITHUB_TOKEN" | gh auth login --with-token
    gh auth status
else
    echo "Skipping GitHub authentication."
fi

# Clone your dotfiles repository (optional if you're using one)
echo "Cloning dotfiles repository..."
git clone https://github.com/J-Kjellmo/Debain-i3conf.git ~/dotfiles

# Backup current configuration
echo "Backing up existing config directory..."
mkdir -p ~/.config_backup
cp -r ~/.config/* ~/.config_backup/

# Move all folders from the "config" directory in your dotfiles repo to ~/.config/
echo "Moving config files to ~/.config/"
for dir in ~/dotfiles/config/*; do
    if [ -d "$dir" ]; then
        echo "Moving $dir to ~/.config/$(basename "$dir")"
        cp -r "$dir" ~/.config/
    fi
done

echo "Installation complete!"
