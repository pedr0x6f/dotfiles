#! /bin/sh

sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

sudo apt update -y
sudo apt full-upgrade -y

sudo apt install iotop htop vim neovim git gcc g++ curl zsh unar unrar unzip p7zip p7zip-rar p7zip-full build-essential -y

sudo apt install -f -y
sudo apt update -y
sudo apt dist-upgrade -y
sudo apt full-upgrade -y
sudo apt autoclean -y
sudo apt autoremove -y
