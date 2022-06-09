# Table of Contents

* [Intro](#intro)
* [Starting From Zero](#starting-from-zero)
* [Starting On A New System](#starting-on-a-new-system)
  * [Installing Oh-My-Zsh](#installing-oh-my-zsh)
  * [Optional](#optional)

## Intro

All my dot files used for Linux - more specificly for vim and [oh-my-zsh](#installing-oh-my-zsh)

Check the other branch `windows` for that operating system

[Guide](https://www.atlassian.com/git/tutorials/dotfiles) for reference

## Starting From Zero

On a fresh new computer, make sure to install `git` then run these commands

```bash
git init --bare $HOME/.dotfiles
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ \
--work-tree=$HOME'" >> $HOME/.zshrc
dotfiles config --local status.showuntrackedfiles no
```

* The first line creates a hidden folder called `.dotfiles`
* The second line creates an alias `dotfiles` to used instead of `git`
* The third line creates a flag to hide files we are not tracking yet
* The last line adds the alias to `.zshrc` for convenience

Now we can version the files we want with `dotfiles` i.e. same commands as `git`

```bash
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "add vimrc"
dotfiles push
```

We have to add username and email to `git` if we want to commit/push

```bash
dotfiles config --global user.email "your@email.com"
dotfiles config --global user.name "yourUserName"
```

Don't forget to declare the remote repository to push

```bash
dotfiles remote add origin https://github.com/Tainted-Fool/mydotfiles
dotfiles push -u origin <localBranchName>
```

## Starting On A New System

Once the repo is up, we can clone it to a new system and pull the files

```bash
# git clone --bare --branch <repoBranchName> <repoURL> $HOME/.dotfiles 
git clone --bare --branch linux https://github.com/Tainted-Fool/mydotfiles \
$HOME/.dotfiles 
echo "alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' \
" >> $HOME/.zshrc
dotfiles config --local status.showuntrackedfiles no
```

* The first line clones this repo
* The second line creates an alias for `git` as `dotfiles`
* The last line hides untracked files

Now we can checkout the repo to acquire the neccessary files

```bash
dotfiles checkout
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
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/softmoth/zsh-vim-mode $ZSH_CUSTOM/plugins/zsh-vim-mode
git clone https://github.com/hlissner/zsh-autopai $ZSH_CUSTOM/plugins/zsh-autopair
```

Modify the `zsh-vim-mode` plugin. Add 3 new lines after line 176(see below) and
delete lines 197-210 from the plugin

```vim
vim-mode-bindkey viins vicmd -- up-line-or-history                 '^P'
vim-mode-bindkey viins vicmd -- down-line-or-history               '^N'
vim-mode-bindkey       vicmd -- vi-insert                          '^J'
```

## Optional

Add a font to vim/terminal like [Caskaydia Cove Nerd Font](https://www.nerdfonts.com/font-downloads)

Add color to the `ls` command

```bash
sudo gem install colorls
sudo apt install ruby-full

# Or install below; DO NOT INSTALL BOTH
sudo apt install exa
```

Add `batcat`, an alternative to `cat` with syntax highlight

```bash
sudo apt install bat
```

Install Azure CLI

```bash
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py --silent
python3 get-pip.py
pip install azure-cli
```
