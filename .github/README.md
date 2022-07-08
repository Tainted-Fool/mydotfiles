# Table of Contents.

- [Table of Contents](#table-of-contents)
  - [Intro](#intro)
  - [Starting From Zero](#starting-from-zero)
  - [Starting On A New System](#starting-on-a-new-system)
    - [Installing Oh-My-Zsh](#installing-oh-my-zsh)
  - [Optional](#optional)

## Intro

All my dot files used for Linux - more specifically for vim and [oh-my-zsh](#installing-oh-my-zsh)

Check the other branch `windows` for that operating system

[Guide](https://www.atlassian.com/git/tutorials/dotfiles) for reference

## Dependencies

- vim 8.2+
- vimplug (auto-installs)
- nodejs and npm for coc.nvim
- xsel for shared clipboard
- FZF for fuzzy search files/folders
- Figlet for ascii art
- Ranger for file management
- ueberzug to draw image files
- A Nerd Font (see optional)
- wslu for WSL utilities (see optional)
- wsl-open for opening files with WSL (see optional)

```Bash
sudo apt update && sudo apt upgrade
sudo apt install nodejs npm figlet fzf vifm xsel ranger ueberzug
```

## Starting From Zero

On a fresh new computer, make sure to install `git` then run these commands

```Bash
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

```Bash
dit status
dit add .vimrc
dit commit -m "add vimrc"
dit push
```

We have to add username and email to `git` if we want to commit/push

```Bash
dit config --global user.email "your@email.com"
dit config --global user.name "yourUserName"
```

Don't forget to declare the remote repository to push

```Bash
dit remote add origin https://github.com/Tainted-Fool/mydotfiles
dit push -u origin <localBranchName>
```

## Starting On A New System

Once the repo is up, we can clone it to a new system and pull the files

```Bash
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

```Bash
dit checkout
```

Might need to add a `-f` to force the changes

### Installing Oh-My-Zsh

Finally, we need to install [Oh-My-Zsh](https://ohmyz.sh/)

First, make sure you have `zsh` installed

```Bash
sudo apt install zsh
```

Run it one time with `zsh` to setup the configs, then install the oh-my-zsh framework

```Bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Next, add a theme for `zsh` like [Typewritten](https://github.com/reobin/typewritten)

```Bash
git clone https://github.com/reobin/typewritten.git $ZSH_CUSTOM/themes/typewritten
```

Add more plugins to `zsh`

```Bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/softmoth/zsh-vim-mode $ZSH_CUSTOM/plugins/zsh-vim-mode
git clone https://github.com/hlissner/zsh-autopair $ZSH_CUSTOM/plugins/zsh-autopair
```

Modify the `zsh-vim-mode` plugin. Add 3 new lines after line 176(see below) and
delete lines 197-210 from the plugin

```vim
vim-mode-bindkey viins vicmd -- up-line-or-history                 '^P'
vim-mode-bindkey viins vicmd -- down-line-or-history               '^N'
vim-mode-bindkey       vicmd -- vi-insert                          '^J'
```

## Optional

### Install NerdFont

A font with glyphs(icons) [Caskaydia Cove Nerd Font](https://www.nerdfonts.com/font-downloads)

### Install Colorls

Add color to the `ls` command

```Bash
sudo gem install colorls
sudo apt install ruby-full

# Or install below; DO NOT INSTALL BOTH
sudo apt install exa
```

### Install Batcat

An alternative to `cat` with syntax highlight

```Bash
sudo apt install bat
```

### Install Azure CLI

Usful for doing a lot of Azure stuff

```Bash
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py --silent
python3 get-pip.py
pip install azure-cli
```

### Install Anaconda

A python environmental variable manager

```Bash
curl -sL https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh | sudo bash
```

### Install WSL Utilities

A collection of utilities for WSL [repo](https://github.com/wslutilities/wslu)

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
```
