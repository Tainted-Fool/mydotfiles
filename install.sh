#!/bin/bash

# run latest updates
sudo apt update -y && sudo apt upgrade -y

# install oh-my-zsh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# add zsh theme
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
mkdir -p "$ZSH_CUSTOM/themes/typewritten"
git clone https://github.com/reobin/typewritten.git "$ZSH_CUSTOM/themes/typewritten"

# add zsh plugins
mkdir -p "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
mkdir -p "$ZSH_CUSTOM/plugins/zsh-autopair"
git clone https://github.com/hlissner/zsh-autopair "$ZSH_CUSTOM/plugins/zsh-autopair"
mkdir -p "$ZSH_CUSTOM/plugins/zsh-vi-mode"
git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM/plugins/zsh-vi-mode"
mkdir -p "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"

# install nerd fonts
mkdir -p ~/.local/share/fonts
curl -fLo "$HOME/.local/share/fonts/Caskaydia Cover Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/CascadiaCode/Regular/complete/Caskaydia%20Cove%20Nerd%20Font%20Complete%20Regular.otf
# git clone https://github.com/ronniedroid/getnf.git
# cd getnf
# bash ./install.sh

# install colorls
sudo apt install exa -y

# install batcat
sudo apt install bat -y

# install nvim
# sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen -y
# git clone https://github.com/neovim/neovim
# cd neovim %% git checkout stable
# make distclean && make CMAKE_BUILD_TYPE=RelWithDebInfo
# sudo make install

# install stow
sudo apt install stow -y
mv ~/.condarc ~/.condarc.bak
stow conda

mv ~/.gitconfig ~/.gitconfig.bak
stow git

mv ~/.config/nvim ~/.config/nvim.bak
stow nvim

mv ~/.oh-my-zsh/custom/plugins/zsh-aliases/zsh-aliases.plugin.zsh ~/.oh-my-zsh/custom/plugins/zsh-aliases/zsh-aliases.plugin.zsh.bak
mv ~/.oh-my-zsh/custom/plugins/zsh-functions/zsh-functions.plugin.zsh ~/.oh-my-zsh/custom/plugins/zsh-functions/zsh-functions.plugin.zsh.bak
stow oh-my-zsh

mv ~/.vim/vimrc ~/.vim/.vimrc.bak
stow vim

mv ~/.zshrc ~/.zshrc.bak
stow zsh
# stow */ -t ~ --adopt *
# git restore .

# add zsh to valid login shells
# command -v zsh | sudo tee -a /etc/shells

# user zsh as default shell
# sudo chsh -s "$(which zsh)" "$USER"

echo "Exit and re-open shell to see changes"
