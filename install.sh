#!/bin/bash

# Upgrade the system
sudo dnf upgrade -y

sudo dnf install gnome-tweaks -y

sudo dnf install neovim -y

sudo dnf install gnome-console -y

# Git
sudo dnf install git -y

# Install Brave Browser
sudo dnf install dnf-plugins-core -y

sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

sudo dnf install brave-browser -y

sudo dnf install cronie -y

sudo dnf install fastfetch -y

sudo sh -c 'echo max_parallel_downloads=10 >> /etc/dnf/dnf.conf'

# RPM Fusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf config-manager --enable fedora-cisco-openh264 -y
sudo dnf groupupdate core -y
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
sudo dnf groupupdate multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf groupupdate sound-and-video -y

# Gnome Themes Extra
sudo dnf install gnome-themes-extra -y

# Flatpak
sudo dnf install flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub info.febvre.Komikku -y
flatpak install flathub com.usebruno.Bruno -y
flatpak install flathub com.valvesoftware.Steam -y
flatpak install flathub net.sapples.LiveCaptions -y

# Fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip -d JetBrainsMono JetBrainsMono.zip
sudo mv JetBrainsMono /usr/share/fonts
rm JetBrainsMono.zip

# Docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo -y
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# HomeBrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install k9s
brew install lazydocker
brew install lazygit

#LazyVim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

#Zsh
sudo dnf install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
