# Debian-i3conf

## This is a command for command guide for what to do after Debian install
Install essential packages
```
sudo apt install build-essential procps curl file git firefox-esr
```
Install Homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

[ -d /home/linuxbrew/.linuxbrew ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.zshrc
```
Test Homebrew
```
brew doctor

brew install gcc
```
Set up git authentication
```
brew install gh

gh auth login
```


Use this command to install the packages from the `installed_packages.txt`
```
xargs -a my_installed_packages.txt sudo apt install -y
```

Use `startx` to start i3
