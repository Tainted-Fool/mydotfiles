# Table of Contents

- [Table of Contents](#table-of-contents)
  - [Intro](#intro)
  - [Using Stow](#using-stow)
  - [Starting On A New System](#starting-on-a-new-system)
    - [Installing Oh-My-Zsh](#installing-oh-my-zsh)
  - [Dependencies](#dependencies)
    - [Install NerdFont](#install-nerdfont)
    - [Install Lazygit](#install-lazygit)
    - [Install Git-Delta](#install-git-delta)
    - [Install Tmux and Tmux Plugin Manager](#install-tmux-and-tmux-plugin-manager)
    - [Install Ripgrep](#install-ripgrep)
    - [Install Fd-Find](#install-fd-find)
    - [Install Batcat](#install-batcat)
    - [Install Eza](#install-eza)
    - [Install Zoxide](#install-zoxide)
    - [Install Azure CLI](#install-azure-cli)
    - [Install Fzf](#install-fzf)
    - [Install Anaconda](#install-anaconda)
    - [Install Universal-Ctags](#install-universal-ctags)
    - [Fix iamcco/markdown-preview](#fix-iamccomarkdown-preview)
    - [Install C Sharp Dependencies](#install-c-sharp-dependencies)
    - [Install Nvim](#install-nvim)
    - [Build Nvim From Source](#build-nvim-from-source)
    - [Daily Message](#daily-message)
    - [TooLongDidntRead](#toolongdidntread)

## Intro

All my dot files used for Linux - more specifically for vim and [oh-my-zsh](#installing-oh-my-zsh)

Check the other branch `windows` for that operating system

## Using Stow

Switched to `stow` for dotfiles management.

```bash
sudo apt install stow
cd mydotfiles
stow .
# stow nvim
# stow */ -t ~
# stow --target ~/.config .
# stow wsl --target=/etc
```

## Starting On A New System

Once the repo is up, we can clone it to a new system and pull the files

```bash
# git clone --bare --branch <repoBranchName> <repoURL> $HOME/.dotfiles 
git clone --bare --branch linux https://github.com/Tainted-Fool/mydotfiles \
$HOME/.dotfiles 
echo "alias dit='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' \
" >> $HOME/.zshrc
dit config --local status.showuntrackedfiles no
```

- The first line clones this repo
- The second line creates an alias for `git` as `dit`
- The last line hides untracked files

Now we can checkout the repo to acquire the necessary files

```bash
dit checkout
```

Might need to add a `-f` to force the changes

### Installing Oh-My-Zsh

Finally, we need to install [Oh-My-Zsh](https://ohmyz.sh/)

First, make sure you have `zsh` installed

```bash
sudo apt install zsh
```

Run it one time with `zsh` to setup the configs, then install the oh-my-zsh framework

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Next, add a theme for `zsh` like [Typewritten](https://github.com/reobin/typewritten)

```bash
git clone https://github.com/reobin/typewritten.git $ZSH_CUSTOM/themes/typewritten
```

## Dependencies

- nerdfonts for fonts with glyphs
- lazygit for a better `git` experience
- delta for better `git` pager utility
- tmux for better terminal management
- ripgrep(rg) for better `grep` utility
- fd-find(fd) for better `find` utility
- bat for better `cat` utility
- eza for better `ls` utility
- zoxide for better `cd` utility
- fzf for better fuzzy finder
- chafa for terminal image previewer
- tldr for quick `man` page

### Install NerdFont

Install [Caskaydia Cove](https://github.com/microsoft/cascadia-code/releases) from Microsoft Github and set font in terminal settings

### Install Lazygit

Add terminal UI for git commands

```bash
git clone https://github.com/jesseduffield/lazygit
cd lazygit
go install
```

### Install Git-Delta

Add syntax highlighting to git

```bash
sudo apt install git-delta
```

### Install Tmux and Tmux Plugin Manager

Add terminal configuration

```bash
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure && make
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# run prefix(CTRL + SPACE) + I (capital eye)
```

### Install Ripgrep

An alternative to `grep` with `rg`

```bash
sudo apt install ripgrep
```

### Install Fd-Find

An alternative to `find` with `fdfind`

```bash
sudo apt install fd-find
```

### Install Batcat

An alternative to `cat` with syntax highlight

```bash
sudo apt install bat
```

### Install Eza

Add color to the `ls` command

```bash
sudo apt install eza
```

### Install Zoxide

A better `cd` command

```bash
sudo apt install zoxide
```

### Install Azure CLI

Useful for doing a lot of Azure stuff

```bash
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py --silent
python3 get-pip.py
pip install azure-cli
```

### Install Fzf

A fuzzy search utility

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

### Install Anaconda

A Python environmental variable manager

```bash
curl -sL https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh | sudo sh
```

### Install Universal-Ctags

Allows you to tag many built-in functions, methods, and properties

```bash
sudo apt install \
    gcc make \
    pkg-config autoconf automake \
    python3-docutils \
    libseccomp-dev \
    libjansson-dev \
    libyaml-dev \
    libxml2-dev

git clone https://github.com/universal-ctags/ctags
cd ctags
./autogen.sh
./configure --prefix=/where/to/store/file
make
make install
#OR
sudo apt install Universal-ctags
```

### Fix iamcco/markdown-preview

Kept getting error getting this to work

```bash
# comment out the plugin
# run this command inside vim `:PlugClean`
# run this command outside vim
sudo npm install tslib
sudo npm install -g yarn
sudo yarn add tslib
# uncomment the plugin
# run this command inside vim `:PlugInstall`
```

### Install C Sharp Dependencies

Allows you to develop code in c sharp `c#` for debian 10 `buster`

> Install [mono-project](https://www.mono-project.com/download/stable/#download-win) and [dotnet](https://docs.microsoft.com/en-us/dotnet/core/install/linux-debian) - can also install on Windows for WSL integration

```bash
wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt update
sudo apt install -y apt-transport-https
sudo apt-get install -y dotnet-sdk-6.0
sudo apt-get install -y dotnet-sdk-5.0
sudo apt-get install -y dotnet-sdk-3.1

# mono installation - this is only if using dotnet-sdk-3.1
sudo apt install apt-transport-https dirmngr gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/debian stable-buster main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update
sudo apt install mono-complete
```

### Install Nvim

Vim with LUA. Download [Nvim 0.8.0](https://github.com/neovim/neovim/releases)

> Make sure you have `git`, `make`, `pip`, `npm`, `node`, and `cargo` installed

```bash
# install nvim
curl -sL https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.deb -o nvim.deb
sudo apt install ./nvim.deb

# install dependencies
sudo apt install git make pip npm node cargo ruby fd-find
gem install neovim
pip3 install pynvim
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
```

Follow this tutorial for [reference](https://github.com/LunarVim/Neovim-from-scratch)

### Build Nvim From Source

First, install dependencies. NOTE: This is for Ubuntu/Debian platforms

```bash
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
```

Then clone repo and run these commands:

```bash
git clone https://github.com/neovim/neovim
cd neovim
git checkout release-0.8
#git checkout stable
make distclean && make CMAKE_BUILD_TYPE=Release
#make distclean && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
nvim -v
```

### Daily Message

```bash
sudo apt install fortune-mod
```

### TooLongDidntRead

```python
pip install tldr
```
