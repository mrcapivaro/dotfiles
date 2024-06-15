# Check if Scoop is already installed
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    # Set execution policy
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

    # Install Scoop
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

    Write-Output "Scoop has been installed."
} else {
    Write-Output "Scoop is already installed."
}
