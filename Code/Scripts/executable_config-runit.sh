#!/bin/bash
set -e

# Keymapper setup
KEYMAPPER_CONF_DIR="$HOME/.config/sv/keymapperd"
KEYMAPPER_SV_DIR="/etc/runit/sv/keymapperd"
KEYMAPPER_TARGET_DIR="/run/runit/service/keymapperd"
if [ -d "$KEYMAPPER_SV_DIR" ]; then
  echo "The keymapper sv folder already exists at $KEYMAPPER_SV_DIR."
else
  echo "Copying keymapper sv files from .config to $KEYMAPPER_SV_DIR."
  sudo cp -r "$KEYMAPPER_CONF_DIR" "$KEYMAPPER_SV_DIR"
fi
echo "Symlinking the sv dir to runit."
sudo ln -s "$KEYMAPPER_SV_DIR" "$KEYMAPPER_TARGET_DIR"
