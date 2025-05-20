#!/usr/bin/env bash
set -eo pipefail

me="$(readlink -f $0)"
here="$(dirname $me)"

[[ -n $WAYLAND_DISPLAY ]] &&
    copy="wl-copy" ||
    copy="xclip -sel clip"

symbols_file="$here/symbols/symbols.txt"

[[ ! -f "$symbols_file" ]] &&
    echo "$symbols_file not found" &&
    exit 1

selected="$(cat "$symbols_file" | rofi -dmenu -i -theme "configs/apps.rasi" -p " ")"

[[ -z $selected ]] && exit 1

echo -ne $(echo "$selected" | cut -d $'\t' -f 1) | $copy
