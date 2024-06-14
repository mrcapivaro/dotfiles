# Install Scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# Self-elevate the script to create Symlinks
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -Wait -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}

# NVIM symlink
$targetDir = "$env:USERPROFILE\.local\share\chezmoi\dot_config\nvim"
$linkDir = "$env:LOCALAPPDATA\nvim"
if (-Not (Test-Path $linkDir)) {
  try {
    New-Item -ItemType SymbolicLink -Target $targetDir -Path $linkDir
    Write-Host "Symlink of dotfiles/chezmoi nvim to local appdata created."
  } catch {
    Write-Host "Failed to create nvim symlink."
  }
}
