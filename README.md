# dotfiles

## Installation

### Windows
> Install [scoop](https://www.scoop.sh/):
```pwsh
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```
> Install [chezmoi](https://www.chezmoi.io/) and [Powershell 7](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4#installing-the-msi-package) through scoop:
```powershell
scoop install chezmoi pwsh
```
> Initialize and apply chezmoi:
```powershell
chezmoi init mrcapivaro && chezmoi apply
```

### Linux
> One line bootstrap command [chezmoi](https://www.chezmoi.io/):
```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply mrcapivaro
```
