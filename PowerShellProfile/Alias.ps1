# Aliases
Set-Alias which Get-Command
Set-Alias grep findstr.exe

if (-not(Test-Path -Path Alias:Touch))
{
    New-Alias -Name touch touchfile -Force
}