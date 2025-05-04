#! /bin/sh

sudo rm /var/lib/dpkg/lock-frontend ; sudo rm /var/cache/apt/archives/lock

sudo apt update ; sudo apt full-upgrade -y

sudo apt install iotop htop preload vlc vim neovim git gcc g++ curl zsh unar unrar unzip p7zip p7zip-rar p7zip-full build-essential ubuntu-restricted-addons ubuntu-restricted-extras gufw fonts-hack-ttf fonts-firacode -y

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

sudo apt install -f ;  sudo apt update ; sudo apt upgrade ; sudo apt dist-upgrade ; sudo apt full-upgrade ; sudo apt autoclean ; sudo apt autoremove -y
