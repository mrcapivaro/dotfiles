Invoke-Expression (&starship init powershell)

Import-Module Z

Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

function which($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
      Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

Set-Alias ll ls
Set-Alias vi nvim
Set-Alias vim nvim

function chezmoicd() {
  Set-Location -Path $(chezmoi source-path)
}
