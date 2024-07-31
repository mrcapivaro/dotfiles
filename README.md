# dotfiles

## Installation

### Windows
> Install [Powershell 7](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4#installing-the-msi-package)

> Install [scoop](https://www.scoop.sh/):
```pwsh
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

> Bootstrap [chezmoi](https://www.chezmoi.io/):
```powershell
scoop install chezmoi && chezmoi init --apply --ssh mrcapivaro
```

### Linux
> Bootstrap [chezmoi](https://www.chezmoi.io/):
```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply --ssh mrcapivaro
```

