# dotfiles

## Installation
> Install scoop(Windows only):
```pwsh
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

> Bootstrap [chezmoi](https://www.chezmoi.io/):
```bash
export GITHUB_USERNAME=mrcapivaro
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

