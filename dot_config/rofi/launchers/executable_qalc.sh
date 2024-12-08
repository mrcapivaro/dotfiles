#!/usr/bin/env bash
set -euo pipefail

# Set the PWD to the ~/.config/rofi folder
cd "$HOME/.config/rofi"

rofi -modi calc \
    -show calc \
    -no-history \
    -no-show-match \
    -no-sort \
    -theme "./configs/qalc.rasi" \
    -calc-command "echo -n '{result}' | xclip -sel clip"
