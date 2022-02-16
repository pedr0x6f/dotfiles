#! /bin/sh

# remover bloqueios apt
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

# atualizacao dos repositorios e do sistema
sudo apt update -y
sudo apt full-upgrade -y

# Download e instalacao nerd-fonts
wget -c https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip  -P $HOME/Downloads/
sudo unzip $HOME/Downloads/Hack.zip -d /usr/share/fonts
fc-cache -fv

# instalacao de programas
sudo apt install keepassxc iotop htop preload vlc vim neovim git gcc g++ curl zsh unar unrar unzip p7zip p7zip-rar p7zip-full build-essential ubuntu-restricted-addons ubuntu-restricted-extras gufw fonts-hack-ttf fonts-firacode -y

# habilitar firewall
sudo ufw enable

# configuracoes do sistema
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

# instalar vim-plug plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Backup .vimrc 
cp ~/.vimrc ~/.vimrcbkp

# Download arquivos de configuração   
curl https://raw.githubusercontent.com/cezarmzz/dotfiles/main/.vimrc > ~/.vimrc

# instalar vim-plug plugin manager
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
       
# Backup nvim 
cp -R ~/.config/nvim ~/.config/nvim_bkp

# Download arquivos de configuração    
sh -c 'curl -fLo ~/.config/nvim/init.vim --create-dirs https://raw.githubusercontent.com/cezarmzz/dotfiles/40c3989bee6e5c9198895f6595e2f2b6b6b38f47/.config/nvim/init.vim'
sh -c 'curl -fLo ~/.config/nvim/coc-settings.json --create-dirs https://raw.githubusercontent.com/cezarmzz/dotfiles/40c3989bee6e5c9198895f6595e2f2b6b6b38f47/.config/nvim/coc-settings.json'

# Definir zsh como padrao
sudo vim /etc/passwd
zsh

# Powerlevel10K
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# nvm 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# install latest lts version node
nvm install --lts

# update npm
npm i npm -g

# atualizacao e limpeza do sistema
sudo apt install -f -y
sudo apt update -y
sudo apt dist-upgrade -y
sudo apt full-upgrade -y
sudo apt install -f -y
sudo apt autoclean -y
sudo apt autoremove -y
