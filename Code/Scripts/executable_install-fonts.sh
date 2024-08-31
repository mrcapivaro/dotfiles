#!/bin/sh
set -e

FONT_DIR="$HOME/.local/share/fonts"
SOURCE_DIR="$HOME/.local/share/chezmoi/.other/fonts/iosevka-capy"

if ! ls ~/.local/share/fonts/IosevkaCapy*.ttf &>/dev/null; then
	echo "Copying fonts to .local/share/fonts folder."
	cp "$SOURCE_DIR"/* "$FONT_DIR/"
else
	echo "Font files already configured."
fi
