# Table of Contents

- [Table of Contents](#table-of-contents)
  - [Intro](#intro)
  - [Starting From Zero](#starting-from-zero)
  - [Starting On A New System](#starting-on-a-new-system)
    - [Installing Oh-My-Posh](#installing-oh-my-posh)
  - [Optional](#optional)
    - [Install NerdFont](#install-nerdfont)
    - [Install Choco](#install-choco)
    - [Install GSudo](#install-gsudo)
    - [Install Batcat](#install-batcat)
    - [Install Clink](#install-clink)
    - [Install Azure CLI](#install-azure-cli)
    - [Install Anaconda](#install-anaconda)
    - [Install Universal-Ctags](#install-universal-ctags)
    - [Set WSL Variables](#set-wsl-variables)

## Intro

All my dot files used for Windows - more specifically for vim and [oh-my-posh](#installing-oh-my-posh)

Check the other branch `linux` for that operating system

[Guide](https://www.atlassian.com/git/tutorials/dotfiles) for reference

## Using Stow

Switched to `stow` for dotfile management, more specificly `dploy stow`. It's a lot easier to manage and update dotfiles by symbolic links. The only downside is we must navigate to our `.dotfiles` directory and run `git` commands.

```PowerShell
pip install dploy
dploy stow <source_dir> <dest_dir>
dploy unstow <source_dir> <dest_dir>

# examples
cd ~\.dotfiles
dploy stow .\conda C:\Users\laz
dploy stow .\git C:\Users\laz
dploy stow .\nvim C:\Users\laz\AppData\Local\nvim
dploy stow .\PowerShellProfile C:\Users\laz\Documents\PowerShell # run `echo $PROFILE` first
dploy stow .\vim $HOME\vimfiles\vimrc
dploy stow .\lazygit $HOME\AppData\Local\lazygit
```

> Below is obsolete but kept for history stake. Simply clone the repo into `.dotfiles` and run `stow`

## Starting From Zero

On a fresh new computer, make sure to install `git` then run these commands:

```PowerShell
git init --bare $HOME\.dotfiles
echo "`nfunction dit() {git --git-dir=$HOME\.dotfiles\ `
--work-tree=$HOME $args}" >> $PROFILE
dit config --local status.showuntrackedfiles no
```

- The first line creates a hidden folder called `.dotfiles`
- The second line creates an alias `dit` to interact with our repo
- The third line creates a flag to hide files we are not tracking yet
- The last line adds the alias to `$PROFILE` for convenience

Now we can version the files we want with `dit` i.e same commands as `git`

```PowerShell
dit status
dit add vimrc
dit commit -m "add vimrc"
dit push
```

We have to add username and email to `git` if we want to commit/push

```PowerShell
dit config --global user.email "your@email.com"
dit config --global user.name "yourUserName"
```

Don't forget to declare the remote repository to push

```PowerShell
dit remote add origin https://github.com/Tainted-Fool/mydotfiles
dit push -u origin <localBranchName>
```

## Starting On A New System

Once the repo is up, we can clone it to a new system and pull the files

```PowerShell
# git clone --bare --branch <repoBranchName> <repoURL> $HOME\.dotfiles 
git clone --bare --branch windows https://github.com/Tainted-Fool/mydotfiles `
$HOME\.dotfiles 
echo "`nfunction dit() {git --git-dir=$HOME\.dotfiles\ `
--work-tree=$HOME $args}" >> $PROFILE
dit config --local status.showuntrackedfiles no
```

- The first line clones this repo
- The second line creates an alias for `git` as `dit`
- The last line hides untracked files

Now we can checkout the repo to acquire the necessary files

```PowerShell
dit checkout
```

Might need to add a `-f` to force the changes

Install these PowerShell modules

```PowerShell
Install-Module -Name DockerCompletion
Install-Module -Name Posh-Git
Install-Module -Name PSReadLine
Install-Module -Name PackageManagement
Install-Module -Name PowerShellGet
Install-Module -Name PSWindowsUpdate
Install-Module -Name Terminal-Icons
Install-Module -Name Z
Update-Module -Name <moduleName> # update command
```

Overwrite current PowerShell profile by copying the appropriate file

```PowerShell
cp ~\PowerShellProfile\Microsoft.PowerShell_profile.ps1 $PROFILE
cp ~\PowerShellProfile\Microsoft.VSCode.ps1 $PROFILE
```

### Installing Oh-My-Posh

Finally, we need to install [Oh-My-Posh](https://ohmyposh.dev/)

Install `winget` then run command

- Download from the Microsoft Store
- Download from [Github](https://github.com/microsoft/winget-cli/releases/)

```PowerShell
winget install oh-my-posh
winget upgrade oh-my-posh # update/upgrade command
```

## Optional

### Install NerdFont

A font with glyphs(icons) [Caskaydia Cove Nerd Font](https://www.nerdfonts.com/font-downloads)

### Install Choco

[Choco](https://chocolatey.org/install) is a app package manager for Windows

```PowerShell
Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

### Install GSudo

Install `gsudo` which gives the `sudo` command for administrative tasks

```PowerShell
choco install gsudo -y
```

### Install Batcat

An alternative to `cat` with syntax highlight

```PowerShell
choco install bat -y
```

### Install Clink

`clink` makes `cmd.exe` more bash-like with tab completion and many other features

```PowerShell
choco install clink -y
```

### Install Azure CLI

Useful for doing a lot of Azure stuff

```PowerShell
$ProgressPreference = 'SilentlyContinue';
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi;
Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
```

### Install Anaconda

A Python environmental variable manager

```PowerShell
Invoke-WebRequest -Uri https://repo.anaconda.com/archive/Anaconda3-2022.05-Windows-x86_64.exe -OutFile .\Anaconda.exe;
.\Anaconda.exe
```

Make sure to insall this as well. Fixs weird issue with Vim and Anaconda

```PowerShell
conda install -c conda-forge vim
```

### Install Universal-Ctags

Allows you to tag many built-in functions, methods, and properties

Download from [here](https://github.com/universal-ctags/ctags) and put it in `Program Files` and add to system path

### Set WSL Variables

Set WSL environment variables to call between machines

```PowerShell
setx WSLENV USERPROFILE/p
```

### Install Dotnet

[dotnet](https://docs.microsoft.com/en-us/dotnet/core/install/windows) can be installed via these methods but we will use `winget` instead. Install [dotnet-core-uninstall](https://github.com/dotnet/cli-lab/releases) tool to uninstall all the various SDK's and runtimes on machine

```PowerShell
# uninstall dotnet
dotnet-core-uninstall --list
dotnet-core-uninstall -all --sdk
dotnet-core-uninstall -all --aspnet-runtime
dotnet-core-uninstall -all --runtime

# install dotnet
winget search dotnet
winget install Microsoft.Dotnet.SDK.6
winget install Microsoft.Dotnet.SDK.3_1
```

### Install C Compiler

Go to this [website](https://www.msys2.org) and download `msys2` which is a collection of tools and libraries for Windows. Install it and run it using these commands. Don't forget to add `C:\msys64\mingw64\bin` to system `$PATH`

```PowerShell
pacman -Syu
pacman -S --needed base-devel mingw-w64-x86_64-toolchain
```

Alternativly you can download [Visual Studio build tools](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2019). Another way is to download `mingw` by choco. Reference guide [here](https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support)

```PowerShell
# chocolately install
choco install mingw
```
