# I3wm configuration
### Remove packages:
* i3lock

### Packages required:
* terminator
* git
* yay
* feh
* i3lock-color (AUR)
* picom
* lxappearance
* materia-gtk-theme (change in lxappearance)
* papirus-icon-theme (change in lxappearance)
* ttf-font-awesome
* ttf-ubuntu-font-family
* ttf-droid
* zsh
* ripgrep
* flameshot
* yad
* xdotool
* rofi
* curl
* noto-fonts-emoji
* sysstat
* nvidia-settings
* pacman-contrib

## TLDR cmdlets (in order)
```
pacman -Syu
pacman -S --needed-base-devel git
pacman -R i3lock
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd
yay -S i3lock-color nvidia-settings
pacman -S terminator feh lxappearance picom materia-gtk-theme papirus-icon-theme ttf-font-awesome ttf-ubuntu-font-family ttf-droid zsh ripgrep flameshot yad xdotool rofi curl noto-fonts-emoji sysstat pacman-contrib
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cd ~/.config/i3
sudo chmod +x makeExecutable.sh
./makeExecutable.sh
```


### Recommended packages:
* nerd-fonts
   1. Jetbrains
   2. IBMplex
    
## REMEMBER!
* Go to bottom of ~/.config/i3/config and set xrandr settings to match device
   * Set --primary for primary monitor, and --auto for others
* run this command to change the ownership of the i3status.conf file:
   * sudo chown $USER:$USER ~/.config/i3/i3status/i3status.conf
* open lxappearance and change icons to what is desired
* Change theme in .zshrc, "frisk" is favorable
* Run rofi-theme-selector and choose a dark theme preferrably

## TODO
* Create script for automating the install process, also to personalize and choose which blocks to include.
* Actually learn how to make blocks yourself, stupid
