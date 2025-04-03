#!/bin/bash

# Set to exit on error
set -e

# List of packages to install
packages=(
    "bash-completion"
    "btop"
    "bzip2"
    "curl"
    "debian-faq"
    "dolphin"
    "dosfstools"
    "feh"
    "file"
    "firefox-esr"
    "flameshot"
    "flatpak"
    "fonts-font-awesome"
    "git"
    "grub-efi-amd64"
    "i3"
    "initramfs-tools"
    "intel-microcode"
    "keepass2"
    "lxappearance"
    "materia-gtk-theme"
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
    "ripgrep"
    "rofi"
    "sudo"
    "sysstat"
    "terminator"
    "unzip"
    "usbutils"
    "wget"
    "xdotool"
    "xinit"
    "xorg"
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

# JetBrains Nerd Font Installation
echo "Installing JetBrains Nerd Font..."

# Create the font directory if it doesn't exist
mkdir -p /home/"$SUDO_USER"/.local/share/fonts

# Download JetBrains Nerd Font (latest release from GitHub)
curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.0/JetBrainsMono.zip -o /tmp/JetBrainsMono.zip

# Unzip and install the font
unzip /tmp/JetBrainsMono.zip -d /home/"$SUDO_USER"/.local/share/fonts

# Clean up the downloaded zip
rm /tmp/JetBrainsMono.zip

# Update font cache
fc-cache -fv

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

# Install Jetbrains nerdfont
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
&& cd ~/.local/share/fonts
unzip ~/.local/share/fonts/JetBrainsMono.zip
&& rm JetBrainsMono.zip
&& fc-cache -fv

echo "Installation complete!"
