# Xremap
## Install
- AUR: xremap-hypr-bin with yay? -> paru? --noconfirm?
- config files with chezmoi and *.service and *.desktop autostart
- once: `systemctl --user enable xremap.service`

## ansible plan
- install paru?
- install xremap package from aur with yay or paru
- chezmoi should add all needed files before
- RUN the ALLOW USER WITHOUT SUDO COMMANDS (only ONCE)
- if first change/boot, or the service is just not enabled(check
  everytime); then run the enable command
- done?
