$temp_folder = "$HOME\\Downloads\\kmonad"
$destination_folder = "C:\\Windows\\"
$kmonad_url = "https://github.com/kmonad/kmonad/releases/download/0.4.1/kmonad-0.4.1-win.exe"
$startup_folder = "C:\\ProgramData\\Microsoft\\Windows\\Start Menu\\Programs\\Startup\\"

echo "Starting the KMONAD install script."

if ((Test-Path -Path $temp_folder) -eq $false) {
  echo "Downloading the kmonad binary in a temporary folder."
  New-Item -Path $temp_folder -ItemType Directory
  Invoke-WebRequest -Uri $kmonad_url -Outfile "$temp_folder\\kmonad.exe"
}

if ((Test-Path -Path "$destination_folder\\kmonad.exe") -eq $false) {
  echo "Moving the kmonad.exe to a folder contained in the PATH"
  sudo Move-Item -Path "$temp_folder\\kmonad.exe" -Destination $destination_folder
}

if ((Test-Path -Path "$startup_folder\\kmonad.lnk") -eq $false) {
  echo "Creating a symlink of kmonad.exe in the auto startup folder"
  sudo New-Item -ItemType SymbolicLink -Path "$startup_folder\\kmonad.exe" -Target "$destination_folder\\kmonad.exe"
}

if (Test-Path -Path $temp_folder) {
  echo "Deleting the temporary folder and it's contents"
  Remove-Item -Path $temp_folder -Recurse -Force
}

echo "KMONAD installation finished."
