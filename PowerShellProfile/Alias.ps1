# Aliases
Set-Alias which Get-Command
Set-Alias grep findstr.exe
Set-Alias -Name sandbox -Value "D:\Documents\Github\Dynamo\bin\2.14\DynamoSandbox.exe"

if (-not(Test-Path -Path Alias:Touch))
{
    New-Alias -Name touch touchfile -Force
}
