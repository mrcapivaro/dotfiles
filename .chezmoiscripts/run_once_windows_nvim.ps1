$targetDir = "$env:USERPROFILE\.local\share\chezmoi\dot_config\nvim"
$linkDir = "$env:LOCALAPPDATA\nvim"

# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -Wait -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}

if (-Not (Test-Path $linkDir)) {
  try {
    New-Item -ItemType SymbolicLink -Target $targetDir -Path $linkDir
    Write-Host "Symlink of dotfiles/chezmoi nvim to local appdata created."
  } catch {
    Write-Host "Failed to create nvim symlink."
  }
}
# asdlkfjsajdkf
