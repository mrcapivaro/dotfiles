#!/bin/sh

run() {
  if ! pgrep -f "$1"; then
    "$@" &
  fi
}

run dex --environment Awesome --autostart --search-paths "/etc/xdg/autostart:$HOME/.config/autostart"
run feh --bg-center "$HOME/.local/share/chezmoi/.other/mountains.png"

xrandr --output HDMI-0 --mode "1920x1080"
setxkbmap "us, us(intl)" -option "grp:sclk_toggle"
