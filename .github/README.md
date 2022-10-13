# Table of Contents

- [Table of Contents](#table-of-contents)
  - [Intro](#intro)
  - [Dependencies](#dependencies)
  - [Starting From Zero](#starting-from-zero)
  - [Starting On A New System](#starting-on-a-new-system)
    - [Installing Oh-My-Zsh](#installing-oh-my-zsh)
  - [Optional](#optional)
    - [Install NerdFont](#install-nerdfont)
    - [Install Colorls](#install-colorls)
    - [Install Batcat](#install-batcat)
    - [Install Azure CLI](#install-azure-cli)
    - [Install Anaconda](#install-anaconda)
    - [Install WSL Utilities](#install-wsl-utilities)
    - [Install WSL-Open](#install-wsl-open)
    - [Install Universal-Ctags](#install-universal-ctags)
    - [Fix iamcco/markdown-preview](#fix-iamccomarkdown-preview)
    - [Install C Sharp Dependencies](#install-c-sharp-dependencies)
    - [Install Nvim](#install-nvim)
    - [Build Nvim From Source](#build-nvim-from-source)
    - [Formatters and Linters](#formatters-and-linters)

## Intro

All my dot files used for Linux - more specifically for vim and [oh-my-zsh](#installing-oh-my-zsh)

Check the other branch `windows` for that operating system

[Guide](https://www.atlassian.com/git/tutorials/dotfiles) for reference

## Dependencies

- vim 8.2+
- vimplug (auto-installs)
- nodejs and npm for coc.nvim
- FZF for fuzzy search files/folders
- xsel for shared clipboard - not needed
- Figlet for ascii art - not needed
- Ranger for file management - not needed
- ueberzug to draw image files - not needed
- A Nerd Font (see optional)
- wslu for WSL utilities (see optional)
- wsl-open for opening files with WSL (see optional)

```bash
sudo apt update && sudo apt upgrade
sudo apt install nodejs npm fzf vifm xsel figlet ranger ueberzug
```

## Starting From Zero

On a fresh new computer, make sure to install `git` then run these commands

```bash
git init --bare $HOME/.dotfiles
echo "alias dit='/usr/bin/git --git-dir=$HOME/.dotfiles/ \
--work-tree=$HOME'" >> $HOME/.zshrc
dit config --local status.showuntrackedfiles no
```

- The first line creates a hidden folder called `.dotfiles`
- The second line creates an alias `dit` to used instead of `git`
- The third line creates a flag to hide files we are not tracking yet
- The last line adds the alias to `.zshrc` for convenience

Now we can version the files we want with `dit` i.e. same commands as `git`

```bash
dit status
dit add .vimrc
dit commit -m "add vimrc"
dit push
```

We have to add username and email to `git` if we want to commit/push

```bash
dit config --global user.email "your@email.com"
dit config --global user.name "yourUserName"
```

Don't forget to declare the remote repository to push

```bash
dit remote add origin https://github.com/Tainted-Fool/mydotfiles
dit push -u origin <localBranchName>
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

Now we can checkout the repo to acquire the neccessary files

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

Add more plugins to `zsh`

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/hlissner/zsh-autopair $ZSH_CUSTOM/plugins/zsh-autopair
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $ZSH_CUSTOM/plugins/fast-syntax-highlighting
```

## Optional

### Install NerdFont

A font with glyphs(icons) [Caskaydia Cove Nerd Font](https://www.nerdfonts.com/font-downloads)

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Caskaydia Cover Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/CascadiaCode/Regular/complete/Caskaydia%20Cove%20Regular%20Nerd%20Font%20Complete.otf
```

A better way to install NerdFonts is with this repo. Then running `getnf`

```bash
git clone https://github.com/ronniedroid/getnf.git
cd getnf
./install.sh
```

### Install Colorls

Add color to the `ls` command

```bash
sudo gem install colorls
sudo apt install ruby-full

# Or install below; DO NOT INSTALL BOTH
sudo apt install exa
```

### Install Batcat

An alternative to `cat` with syntax highlight

```bash
sudo apt install bat
```

### Install Azure CLI

Usful for doing a lot of Azure stuff

```bash
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py --silent
python3 get-pip.py
pip install azure-cli
```

### Install Anaconda

A Python environmental variable manager

```bash
curl -sL https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh | sudo sh
```

### Install WSL Utilities

A collection of utilities for WSL [repo here](https://github.com/wslutilities/wslu)

> Run these commands on Debian distros

```bash
sudo apt install gnupg2 apt-transport-https
wget -O - https://pkg.wslutiliti.es/public.key | sudo tee -a /etc/apt/trusted.gpg.d/wslu.asc

# Debian 10
echo "deb https://pkg.wslutiliti.es/debian buster main" | sudo tee -a /etc/apt/sources.list
# Debian 11
echo "deb https://pkg.wslutiliti.es/debian bullseye main" | sudo tee -a /etc/apt/sources.list

sudo apt update
sudo apt install wslu
```

> Run these commands on Kali distros

```bash
sudo apt install gnupg2 apt-transport-https
wget -O - https://pkg.wslutiliti.es/public.key | sudo tee -a /etc/apt/trusted.gpg.d/wslu.asc
echo "deb https://pkg.wslutiliti.es/kali kali-rolling main" | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt install wslu
```

> Run these commands on Ubuntu distros

```bash
sudo apt update
sudo apt install ubuntu-wsl
```

### Install WSL-Open

Allows you to open WSL files using Windows GUI applications [repo here](https://github.com/4U6U57/wsl-open)

```bash
curl https://raw.githubusercontent.com/4U6U57/wsl-open/master/wsl-open.sh -o wsl-open
# OR
sudo apt install -yqq npm
sudo npm install -g wsl-open
# link wsl-open to xdg-open
sudo rm $(which xdg-open)
sudo ln -s $(which wsl-open) /usr/local/bin/xdg-open
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

Keept getting error getting this to work

```bash
# comment out the plugin
# run this command inside vim `:PlugClean`
# run this command outside vim
sudo npm install tslib
sudo npm install -g yarn
sudo yarn add tslib
# un-comment the plugin
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
sudo apt install git make pip npm node cargo
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

### Formatters and Linters

Run these commands to install formatters and linters or use `:Mason`

```bash
cargo install stylua # lua formatter
npm install -location=global markdownlint-cli # markdown linter and formatter
npm install prettier # multi-language formatter
pip install black # python formatter
pip install flake8 # python linter
pip install vulture # useful in python to find unused code
sudo apt install fortune-mod
```
