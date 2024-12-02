#!/usr/bin/env bash
set -euo pipefail

rofi -mode window \
    -show window \
    -theme "./themes/window-switcher.rasi" \
    -selected-row 1 \
    -kb-element-next "Alt_L+Tab" \
    -kb-accept-entry "!Alt_L"
