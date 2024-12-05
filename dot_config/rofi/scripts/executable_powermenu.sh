#!/usr/bin/env bash
set -euo pipefail

if [ $# -eq 0 ]; then
    rofi -mode powermenu \
         -show "powermenu:powermenu.sh" \
         -theme "./themes/launcher.rasi"
fi
