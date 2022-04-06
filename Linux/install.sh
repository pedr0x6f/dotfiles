#! /bin/sh

sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

sudo apt update -y
sudo apt full-upgrade -y

DOWNLOADS="$HOME/Downloads/programas"

VSCODE="https://az764295.vo.msecnd.net/stable/e18005f0f1b33c29e81d732535d8c0e47cafb0b5/code_1.66.0-1648620611_amd64.deb"
VIRTUALBOX="https://download.virtualbox.org/virtualbox/6.1.32/virtualbox-6.1_6.1.32-149290~Ubuntu~eoan_amd64.deb"
EXTENSIONPACK="https://download.virtualbox.org/virtualbox/6.1.32/Oracle_VM_VirtualBox_Extension_Pack-6.1.32.vbox-extpack"

wget -c https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip  -P "$DOWNLOADS"
sudo unzip $HOME/Downloads/Hack.zip -d /usr/share/fonts
fc-cache -fv

sudo apt install iotop htop preload vlc vim neovim git gcc g++ curl zsh unar unrar unzip p7zip p7zip-rar p7zip-full build-essential ubuntu-restricted-addons ubuntu-restricted-extras gufw fonts-hack-ttf fonts-firacode -y

mkdir "$DOWNLOADS"
wget -c "$VSCODE"        -P "$DOWNLOADS"
wget -c "$VIRTUALBOX"    -P "$DOWNLOADS"
wget -c "$EXTENSIONPACK" -P "$DOWNLOADS"
sudo dpkg -i $DOWNLOADS/*.deb

sudo ufw enable

sudo tee -a /etc/sysctl.d/99-sysctl.conf <<-EOF
vm.swappiness=1
vm.vfs_cache_pressure=50
vm.dirty_background_bytes=16777216
vm.dirty_bytes=50331648
kernel.pid_max=4194304
net.ipv4.tcp_syncookies=1
net.ipv4.ip_forward=1
net.ipv4.tcp_dsack=0
# net.ipv4.tcp_sack=0
fs.file-max=100000
kernel.sched_migration_cost_ns=5000000
kernel.sched_autogroup_enabled=0
EOF

sudo tee -a /etc/security/limits.conf <<-EOF
hard stack unlimited
nproc unlimited
nofile 1048576
as unlimited
cpu unlimited
fsize unlimited
msgqueue unlimited
locks unlimited
* hard nofile 1048576
pedro soft nofile 8192
pedro hard nofile 16384
EOF

sudo apt install -f -y
sudo apt update -y
sudo apt dist-upgrade -y
sudo apt full-upgrade -y
sudo apt autoclean -y
sudo apt autoremove -y
