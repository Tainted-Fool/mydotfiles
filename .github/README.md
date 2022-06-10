# Table of Contents

- [Table of Contents](#table-of-contents)
  - [Intro](#intro)
  - [Starting From Zero](#starting-from-zero)
  - [Starting On A New System](#starting-on-a-new-system)
    - [Installing Oh-My-Posh](#installing-oh-my-posh)
  - [Optional](#optional)

## Intro

All my dot files used for Windows - more specificly for vim and [oh-my-posh](#installing-oh-my-posh)

Check the other branch `linux` for that operating system

[Guide](https://www.atlassian.com/git/tutorials/dotfiles) for reference

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

Now we can version the files we want with `dit` i.e. same commands as `git`

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

Now we can checkout the repo to acquire the neccessary files

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

Overwrite current PowerShell profile by copying the apporiate file

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

Add a font to vim/terminal like [Caskaydia Cove Nerd Font](https://www.nerdfonts.com/font-downloads)

Install [Choco](https://chocolatey.org/install)

```PowerShell
Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

Install `sudo` command for administrative tasks

```PowerShell
choco install gsudo -y
```

Install `bat` command for better output

```PowerShell
choco install bat -y
```

Install `clink` to make `cmd.exe` more bash-like

```PowerShell
choco install clink -y
```

Install Azure CLI

```PowerShell
$ProgressPreference = 'SilentlyContinue';
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi;
Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
```

Install Anaconda

```PowerShell
Invoke-WebRequest -Uri https://repo.anaconda.com/archive/Anaconda3-2022.05-Windows-x86_64.exe -OutFile .\Anaconda.exe;
.\Anaconda.exe
```

Set WSL environment variables

```PowerShell
setx WSLENV USERPROFILE/p
```
