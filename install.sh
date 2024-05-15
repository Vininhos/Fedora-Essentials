#!/bin/bash

# Upgrade the system
sudo dnf upgrade -y

# Install Git if not installed yet.
sudo dnf install git -y

# Install Brave Browser.
sudo dnf install dnf-plugins-core -y

sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc

sudo dnf install brave-browser -y

# Install some system utils.
sudo dnf install fastfetch cronie -y

# Install some core apps GNOME (for me).
if [ "$DESKTOP_SESSION" = "gnome" ]; then
  sudo dnf install gnome-tweaks gnome-console gnome-themes-extra -y
fi

# Install TWM essential softwares.
if [ "$DESKTOP_SESSION" = "sway" || "$DESKTOP_SESSION" = "hyprland" ]; then
  sudo dnf install alacritty gammastep gammastep-indicator btop gnome-themes-extra -y
fi

# Improve Fedora's max parallel download by increasing the limit to 10.
sudo sh -c 'echo max_parallel_downloads=10 >> /etc/dnf/dnf.conf'

# Add's RPM Fusion to install some proprietary softwares and essentials Codecs.
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf config-manager --enable fedora-cisco-openh264 -y
sudo dnf groupupdate core -y
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
sudo dnf groupupdate multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf groupupdate sound-and-video -y

# Install Non Free RPM Fusion Steam.
sudo dnf install steam -y
echo "@nClientDownloadEnableHTTP2PlatformLinux 0" > ~/.steam/steam/steam_dev.cfg

# Install Flatpak and some cool apps.
sudo dnf install flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub info.febvre.Komikku -y
flatpak install flathub com.usebruno.Bruno -y
flatpak install flathub net.sapples.LiveCaptions -y
flatpak install flathub com.spotify.Client -y

# Install JetBrains Mono Nerd fonts.
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip -d JetBrainsMono JetBrainsMono.zip
sudo mv JetBrainsMono /usr/share/fonts
rm JetBrainsMono.zip

# Install Docker and add your user to docker group.
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo -y
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo usermod -aG docker $USER

# Install NVM.
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Install Kubectl.
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Install HomeBrew and some softwares with this package manager.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install k9s
brew install lazydocker
brew install lazygit

# Rust and Cargo for LunarVim dependencies.
sudo dnf install rust cargo -y

# Utils for LunarVim.
sudo dnf install fd-find -ripgrep y

# Install LunarVim.
sudo dnf install neovim -y
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
echo 

# Install Zsh.
sudo dnf install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
