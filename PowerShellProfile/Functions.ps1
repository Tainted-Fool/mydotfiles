# Functions
# This ties to the `touch` alias
function touchfile()
{
    $fileName = $args[0]
    # Check of the file exists
    if (-not(Test-Path $fileName))
    {
        # It does not exist. Create it
        New-Item -ItemType File -Name $fileName
    }
    else
    {
        #It exists. Update the timestamp
        (Get-ChildItem $fileName).LastWriteTime = Get-Date
    }
}

# `git` command alternative for Mydotfiles repo
function dit()
{
  git --git-dir=$HOME\.dotfiles\ --work-tree=$HOME $args
}

# Update `pip`
function pipupdater()
{
  python -m pip install --upgrade pip
}

# Update `pip`
function gitupdater()
{
  git update-git-for-windows
}

# `cat` command with colors
function ccat()
{
  bat.exe --paging=never -pp --style='plain' --theme=TwoDark $args
}

# Open notebook in VSCode
function notes()
{
  $currentPath = (Get-Location).Path
  code "G:\My Drive\Documents\Obsidian Notebook\PersonalNotebook"; Set-Location $currentPath
}

# Similar to linux `time` command
function time 
{ 
  Measure-Command { Invoke-Expression $args 2>&1 | out-default} 
}

# Edit alias with vim
function vima()
{
  vim ~\PowerShellProfile\Alias.ps1
}

# Edit functions with vim
function vimf()
{
  vim ~\PowerShellProfile\Functions.ps1
}

# Edit PowerShellProfile with vim
function vimpsp()
{
  vim ~\PowerShellProfile\Profile.ps1
}

# Edit vimrc with vim
function vimrc()
{
  vim ~\vimfiles\vimrc
}

function src()
{
   # dot(.) sourcing makes functions, alias, and variables to current scope
   # you can NOT set an alias for `.`
   # call(&) runs a function or script and NOT added to current scope
   & $PROFILE
}
