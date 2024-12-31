#!/usr/bin/env bash
set -euo pipefail

me="$(readlink -f $0)"
here="$(dirname $me)"

rofi -mode window \
    -show window \
    -theme "$here/../configs/switcher.rasi" \
    -selected-row 1 \
    -kb-element-next "Alt_L+Tab" \
    -kb-accept-entry "!Alt_L"
