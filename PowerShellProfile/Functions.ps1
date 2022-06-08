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
function dotfiles()
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