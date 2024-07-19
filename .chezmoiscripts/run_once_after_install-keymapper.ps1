$temp = "$HOME\\Downloads\\keymapper"
$dest = "$HOME\\scoop\\shims\\"
$url = "https://github.com/houmain/keymapper/releases/download/4.4.5/keymapper-4.4.5-win64.msi"

if (-Not (Test-Path -Path "$HOME\\Downloads\\keymapper\\")) {
  New-Item -ItemType Directory -Path $temp -Force
  Invoke-WebRequest -Uri $url -OutFile "$temp\\keymapper.zip"
}

if (-Not (Test-Path -Path "$dest\\scoop\\shims\\CM_FP_keymapper.exe")) {
  7z x $temp\\keymapper.zip -o"$dest" -y
}

if (Test-Path -Path "$HOME\\Downloads\\keymapper\\") {
  Remove-Item -Path $temp -Recurse -Force
}
