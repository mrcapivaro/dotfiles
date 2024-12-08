#!/usr/bin/env bash
set -euo pipefail

# Set the PWD to the ~/.config/rofi folder
cd "$HOME/.config/rofi"

rofi -mode drun \
    -show drun \
    -theme "./configs/apps.rasi"
