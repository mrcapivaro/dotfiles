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
