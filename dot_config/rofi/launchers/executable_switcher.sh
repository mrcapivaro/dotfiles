#!/usr/bin/env bash
set -euo pipefail

# Set the PWD to the ~/.config/rofi folder
cd "$HOME/.config/rofi"

rofi -mode window \
    -show window \
    -theme "./configs/switcher.rasi" \
    -selected-row 1 \
    -kb-element-next "Alt_L+Tab" \
    -kb-accept-entry "!Alt_L"
