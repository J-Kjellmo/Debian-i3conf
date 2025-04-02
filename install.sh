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

# Install Oh My Zsh (user-level installation, not as root)
echo "Installing Oh My Zsh..."
export RUNZSH=no  # Prevents the script from switching shells immediately
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Set Zsh as default shell for the current user (user-level)
echo "Changing default shell to Zsh..."
sudo chsh -s "$(command -v zsh)" "$USER"

echo "Oh My Zsh installation complete!"

# Install Homebrew for the current user (do not use sudo)
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH for the current user (not root)
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Persist Homebrew path for both Bash and Zsh for the current user
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' | tee -a ~/.bashrc ~/.profile ~/.zshrc

# Install packages via Homebrew for the current user (no sudo)
brew install gh neovim gcc

echo "Homebrew installation complete!"

# Clone your dotfiles repository (optional if you're using one)
echo "Cloning dotfiles repository..."

git clone https://github.com/J-Kjellmo/Debian-i3conf.git ~/dotfiles

# create ~/.config/
mkdir -p ~/.config

# Move all folders from the "config" directory in your dotfiles repo to ~/.config/
echo "Moving config files to ~/.config/"
for dir in ~/dotfiles/config/*; do
    if [ -d "$dir" ]; then
        echo "Moving $dir to ~/.config/$(basename "$dir")"
        cp -r "$dir" ~/.config/
    fi
done

echo "Installation complete!"
