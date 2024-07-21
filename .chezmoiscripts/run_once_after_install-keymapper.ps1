$temp = "$HOME\\Downloads\\keymapper"
$dest = "$HOME\\scoop\\shims\\"
$url = "https://github.com/houmain/keymapper/releases/download/4.4.5/keymapper-4.4.5-win64.msi"

if (-Not (Test-Path -Path "$dest\\keymapper.exe")) {
  if (-Not (Test-Path -Path "$HOME\\Downloads\\keymapper\\")) {
    New-Item -ItemType Directory -Path $temp -Force
    Invoke-WebRequest -Uri $url -OutFile "$temp\\keymapper.zip"
    7z x "$temp\\keymapper.zip" -o"$dest" -y
  }

  if (Test-Path -Path "$dest\\CM_FP_keymapper*.exe") {
    Move-Item -Path "$dest\\CM_FP_keymapper.exe" -Destination "$dest\\keymapper.exe"
    Move-Item -Path "$dest\\CM_FP_keymapperd.exe" -Destination "$dest\\keymapperd.exe"
    Move-Item -Path "$dest\\CM_FP_keymapperctl.exe" -Destination "$dest\\keymapperctl.exe"
  }

  if (Test-Path -Path "$HOME\\Downloads\\keymapper\\") {
    Remove-Item -Path $temp -Recurse -Force
  }

  sudo "$dest\keymapperd.exe"
  sudo "$dest\keymapper.exe"
  sudo schtasks /create /tn RunKeymapperd /tr "$dest\keymapperd.exe" /sc onstart /f
  sudo schtasks /create /tn RunKeymapper /tr "$dest\keymapper.exe" /sc onstart /f
}
