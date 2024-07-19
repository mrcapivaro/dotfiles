$temp_folder = "$HOME\\Downloads\\kmonad"
$destination_folder = "C:\\Windows\\"
$kmonad_url = "https://github.com/kmonad/kmonad/releases/download/0.4.1/kmonad-0.4.1-win.exe"

echo "Starting the KMONAD install script."

if ((Test-Path -Path $temp_folder) -eq $false) {
  echo "Downloading the kmonad binary in a temporary folder."
  New-Item -Path $temp_folder -ItemType Directory
  Invoke-WebRequest -Uri $kmonad_url -Outfile "$temp_folder\\kmonad.exe"
}

if ((Test-Path -Path "$destination_folder\\kmonad.exe") -eq $false) {
  echo "Moving the kmonad.exe to a folder contained in the PATH."
  sudo Move-Item -Path "$temp_folder\\kmonad.exe" -Destination $destination_folder
}

if (Test-Path -Path $temp_folder) {
  echo "Deleting the temporary folder and it's contents."
  Remove-Item -Path $temp_folder -Recurse -Force
}

echo "Start the kmonad service as a vbs script."
"C:\\ProgramData\\Microsoft\\Windows\\Start Menu\\Programs\\Startup\\kmonad.vbs"

echo "KMONAD installation finished."
