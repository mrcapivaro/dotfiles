#!/bin/bash

fix_catppuccin_bar_bg() {
  echo "@define-color bar-bg #11111b;" >> ~/.config/waybar/theme.css
}

OS="$(uname -s)"
case "${OS}" in
Linux*)
  if [ -f /etc/arch-release ]; then
    fix_catppuccin_bar_bg
  fi
  ;;
*)
  ;;
esac
