#!/usr/bin/env bash
set -euo pipefail

me="$(readlink -f $0)"
here="$(dirname $me)"

rofi -modi calc \
    -show calc \
    -no-history \
    -no-show-match \
    -no-sort \
    -theme "$here/../configs/qalc.rasi" \
    -calc-command "echo -n '{result}' | xclip -sel clip"
