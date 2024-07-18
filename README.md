# dotfiles

## Installation

### Windows
> Install [scoop](https://www.scoop.sh/):
```pwsh
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

> Bootstrap [chezmoi](https://www.chezmoi.io/):
```powershell
scoop install chezmoi && chezmoi init --apply mrcapivaro
```

### Linux
> Bootstrap [chezmoi](https://www.chezmoi.io/):
```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply mrcapivaro
```

