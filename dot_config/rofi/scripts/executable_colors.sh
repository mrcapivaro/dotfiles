#!/usr/bin/env bash
set -euo pipefail

# Set the PWD to the ~/.config/rofi folder
cd "$HOME/.config/rofi"

# Create the colors array and fill it with the desired theme colors.
declare -A colors
# Gruvbox Dark
colors["bg0"]="#282828"
colors["bg1"]="#3C3836"
colors["bg2"]="#504945"
colors["bg3"]="#665C54"
colors["bg4"]="#7C6F64"
colors["fg0"]="#FBF1C7"
colors["fg1"]="#EBDBB2"
colors["fg2"]="#D5C4A1"
colors["fg3"]="#BDAE93"
colors["fg4"]="#A89984"
colors["red"]="#FB4934"
colors["green"]="#B8BB26"
colors["yellow"]="#FABD2F"
colors["blue"]="#83A598"
colors["purple"]="#D3869B"
colors["aqua"]="#8EC07C"
colors["orange"]="#FE8019"
colors["neutral_red"]="#CC241D"
colors["neutral_green"]="#98971A"
colors["neutral_yellow"]="#D79921"
colors["neutral_blue"]="#458588"
colors["neutral_purple"]="#B16286"
colors["neutral_aqua"]="#689D6A"
colors["dark_red"]="#FC9487"
colors["dark_green"]="#D5D39B"
colors["dark_aqua"]="#E8E5B5"
colors["gray"]="#928374"

rofi_dmenu_cmd() {
    rofi -dmenu -theme "configs/apps.rasi" -sep " " -p " "
}

# Change accordign to system's clipboard manager.
clipboard_cmd() {
    xclip -sel clip
}

selected=$(echo "${!colors[@]}" | rofi_dmenu_cmd)

echo -n "${colors[$selected]}" | clipboard_cmd
