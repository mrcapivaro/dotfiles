#!/bin/sh

run() {
  if ! pgrep -f "$1$"; then
    "$@" &
  fi
}

# run dex --environment awesome --autostart --search-paths ~/.config/autostart
run keymapper
run picom
run feh --bg-center "$HOME/.local/share/chezmoi/.other/mountains.png"
run pipewire
xrandr --output HDMI-0 --mode "1920x1080"
