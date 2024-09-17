#!/bin/sh

run() {
  if ! pgrep -f "$1"; then
    "$@" &
  fi
}

run dex --environment Awesome --autostart --search-paths ~/.config/autostart
run picom
run pipewire
run feh --bg-center "$HOME/.local/share/chezmoi/.other/mountains.png"

setxkbmap "us, us(intl)" -option "grp:sclk_toggle"
xrandr --output HDMI-0 --mode "1920x1080"
