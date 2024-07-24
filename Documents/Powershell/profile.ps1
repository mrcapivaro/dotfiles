Invoke-Expression (&starship init powershell)
Import-Module Z
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

Set-Alias vi nvim
Set-Alias vim nvim
Set-Alias cl clear
Set-Alias clera clear
Set-Alias cler clear
Set-Alias clar clear

function chezmoicd() {
  Set-Location -Path $(chezmoi source-path)
}

function which($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
      Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
