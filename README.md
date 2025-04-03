# Debian-i3conf

## Add user to sudo
Add your current user to sudo after Debian install
```
su
```
Install sudo (and curl)
```
apt install sudo curl
```
Add user to sudo group (Yes use sude commands while in `su`)
```
sudo usermod -aG sudo username
```
Add the line `username ALL=(ALL:ALL) ALL` to the suders file
```
sudo visudo
```

## Install the config

Just curl to the install script...
```
curl -sL https://raw.githubusercontent.com/J-Kjellmo/Debian-i3conf/main/install.sh | sudo bash
```

## Apply the config

Simply restart your machine
```
reboot now
```
No greeter is installed (That shit is too cringe) so you have to run `startx` when you log in
