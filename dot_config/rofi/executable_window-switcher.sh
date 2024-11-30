#!/usr/bin/env bash
set -euo pipefail

rofi -mode window \
    -show window \
    -theme "./themes/window-switcher.rasi" \
    -no-seatch \
    -kb-element-next "Alt_L+q" \
    -kb-accept-entry "!Alt_L+q"
