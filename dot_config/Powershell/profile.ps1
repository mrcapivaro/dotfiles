Invoke-Expression (&starship init powershell)
# Hook OSC 7 and Starship to allow the detection of the cwd in wezterm
$prompt = ""
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}

Import-Module Z
# Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

Set-Alias vi nvim
Set-Alias vim nvim
Set-Alias claer clear
Set-Alias clera clear
Set-Alias cler clear
Set-Alias clar clear
Set-Alias ".." "cd .."
Set-Alias "...." "cd ../.."
Set-Alias "cd.." "cd .."

function which($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
      Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
