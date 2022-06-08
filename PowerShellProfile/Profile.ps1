# Invoke Oh-My-Posh
Oh-My-Posh --init --shell pwsh --config ~/AppData/Local/Programs/oh-my-posh/themes/pure.omp.json | Invoke-Expression

# Import Modules
Import-Module Posh-Git
Import-Module Terminal-Icons
Import-module Z
Import-Module PSReadLine
Import-Module PSWindowsUpdate
Import-Module DockerCompletion
# Import-Module AZ.Tools.Predictor
# Enable-AZPredictor

# Import-Module, the chocolately profile contains the necessary code to enable tab-complettion for 'choco'
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile))
{
  Import-Module "$ChocolateyProfile"
}

# Execute scripts
. $HOME\PowerShellProfile\Alias.ps1
. $HOME\PowerShellProfile\Functions.ps1
. $HOME\PowerShellProfile\PSReadLine.ps1
. $HOME\PowerShellProfile\Settings.ps1