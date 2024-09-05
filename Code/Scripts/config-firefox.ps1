$profilePath = (Get-ChildItem -Path "$HOME\AppData\Roaming\Mozilla\Firefox\Profiles\" | Where-Object { $_.Name -match "default-release" }).toString()
$scoopProfPath = "$HOME\scoop\persist\firefox\profile"

if ($profilePath)
{
  $userjsPath = "$HOME\.config\firefox\user.js"
  $chromePath = "$HOME\.config\firefox\chrome"
  if (Test-Path -Path $chromePath)
  {
    New-Item -ItemType SymbolicLink -Path "$profilePath\chrome" -Value $chromePath -Force
  } else
  {
    Write-Host "There is no chrome/ folder in .config/firefox"
  }
  if (Test-Path -Path $userjsPath)
  {
    New-Item -ItemType SymbolicLink -Path "$profilePath\user.js" -Value $userjsPath -Force
  } else
  {
    Write-Host "There is no user.js file in .config/firefox"
  }
} elseif (Test-Path -Path $scoopProfPath)
{
  $userjsPath = "$HOME\.config\firefox\user.js"
  $chromePath = "$HOME\.config\firefox\chrome"
  if (Test-Path -Path $chromePath)
  {
    New-Item -ItemType SymbolicLink -Path "$scoopProfPath\chrome" -Value $chromePath -Force
  } else
  {
    Write-Host "There is no chrome/ folder in .config/firefox"
  }
  if (Test-Path -Path $userjsPath)
  {
    New-Item -ItemType SymbolicLink -Path "$scoopProfPath\user.js" -Value $userjsPath -Force
  } else
  {
    Write-Host "There is no user.js file in .config/firefox"
  }
} else {
  Write-Output "No valid firefox profile found."
}
