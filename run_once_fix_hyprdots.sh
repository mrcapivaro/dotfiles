#!/bin/bash

fix_catppuccin_bar_bg() {
  echo "@define-color bar-bg #11111b;" >> ~/.config/waybar/theme.css
}

fix_change_shell () {
  sudo chsh --shell /bin/bash mrcapivaro
}

fix_xremap_sudo () {
  sudo gpasswd -a mrcapivaro input
  echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/input.rules
}

OS="$(uname -s)"
case "${OS}" in
Linux*)
  if [ -f /etc/arch-release ]; then
    fix_catppuccin_bar_bg
    fix_change_shell
    fix_xremap_sudo
  fi
  ;;
*)
  ;;
esac
