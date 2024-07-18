# dotfiles

## Installation

### Windows Only
> Install scoop:
```pwsh
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

> Install git through scoop:
```powershell
scoop install git
```

### Any OS
> Bootstrap [chezmoi](https://www.chezmoi.io/):
```powershell
export GITHUB_USERNAME=mrcapivaro
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

