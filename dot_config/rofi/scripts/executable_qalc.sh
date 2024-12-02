#!/usr/bin/env bash
set -euo pipefail

# TODO: add a clipboard manager checker that switches clipboard cmds
#       dynamically.

rofi \
    -modi calc \
    -show calc \
    -no-history \
    -no-show-match \
    -no-sort \
    -theme "./themes/qalc.rasi" \
    -calc-command "echo -n '{result}' | xclip -selection clipboard"
