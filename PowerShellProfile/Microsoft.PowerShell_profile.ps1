#$versionMin = [Version]'7.2'

oh-my-posh --init --shell pwsh --config ~/AppData/Local/Programs/oh-my-posh/themes/pure.omp.json | Invoke-Expression
import-module posh-git
import-module terminal-icons
import-module z
import-module psreadline
import-module pswindowsupdate
import-module dockercompletion
# import-module az.tools.predictor
# Enable-AZPredictor

# if (($host.Name -eq 'ConsoleHost') -and ($PSVersionTable.PSVersion -ge $versionMin))

Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Prompt
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineKeyHandler -Key Ctrl+j -Function ViCommandMode
Set-PSReadLineKeyHandler -Key F2 -Function SwitchPredictionView

# Save current command to history so you can call it later
Set-PSReadLineKeyHandler -Key Alt+w -BriefDescription SaveInHistory -LongDescription "Save current line in history but do not execute" -ScriptBlock {
    param($key, $arg)
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($line)
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
}

### Functions
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

function dotfiles()
{
  git --git-dir=$HOME\.dotfiles\ --work-tree=$HOME $args
}

function pipupdater()
{
  python -m pip install --upgrade pip
}

function gitupdater()
{
  git update-git-for-windows
}

function ccat()
{
  bat.exe --paging=never -pp --style='plain' --theme=TwoDark $args
}

function notes()
{
  $currentPath = (pwd).Path
  code "G:\My Drive\Documents\Obsidian Notebook\PersonalNotebook"; cd $currentPath
}

# Import the chocolately profile that contains the necessary code to enable tab-complettion to functions for 'choco'
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile))
{
  Import-Module "$ChocolateyProfile"
}

### Aliases
# Check if the alias exists
if (-not(Test-Path -Path Alias:Touch))
{
    New-Alias -Name touch touchfile -Force
}

Set-Alias which Get-Command
Set-Alias grep Select-String

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

# PowerShell parameter completion shim for the winget CLI
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
    $Local:word = $wordToComplete.Replace('"', '""')
    $Local:ast = $commandAst.ToString().Replace('"', '""')
    winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}
