#! /bin/sh

# Remover bloqueios apt
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

# Atualizar repositorios e do sistema
sudo apt update -y
sudo apt full-upgrade -y

# Instalar programas apt
sudo apt install iotop htop vim neovim git gcc g++ curl zsh unar unrar unzip p7zip p7zip-rar p7zip-full build-essential fonts-hack-ttf fonts-firacode -y

# Instalar Powerlevel10K
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# Instalar zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# Instalar zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >>~/.zshrc

# Instalar fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# Instalar nvm 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Instalar altina versao lts do node
nvm install --lts

# Atualizar npm
npm i npm -g

# Instalar vim-plug plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Download arquivos de configuracao   
curl https://raw.githubusercontent.com/cezarmzz/dotfiles/main/.vimrc > ~/.vimrc

# Instalar vim-plug plugin manager
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
       
# Download arquivos de configuracao    
sh -c 'curl -fLo ~/.config/nvim/init.vim --create-dirs https://raw.githubusercontent.com/cezarmzz/dotfiles/40c3989bee6e5c9198895f6595e2f2b6b6b38f47/.config/nvim/init.vim'
sh -c 'curl -fLo ~/.config/nvim/coc-settings.json --create-dirs https://raw.githubusercontent.com/cezarmzz/dotfiles/40c3989bee6e5c9198895f6595e2f2b6b6b38f47/.config/nvim/coc-settings.json'

# Atualizacao e limpeza do sistema
sudo apt install -f -y
sudo apt update -y
sudo apt dist-upgrade -y
sudo apt full-upgrade -y
sudo apt install -f -y
sudo apt autoclean -y
sudo apt autoremove -y
