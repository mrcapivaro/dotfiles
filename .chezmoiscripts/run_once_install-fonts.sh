#!/bin/bash

# Define the user ID variable
USER_ID=$(whoami)
FONTS_DIR="/home/$USER_ID/.local/share/fonts"
FONTS_FILE="FantasqueSans*FontMono*"
FONTS_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FantasqueSansMono.zip"

# Ensure fonts directory exists
mkdir -p "$FONTS_DIR"
chmod 755 "$FONTS_DIR"
chown "$USER_ID":"$USER_ID" "$FONTS_DIR"

# Check if FantasqueSans Mono exists
if ! ls "$FONTS_DIR/$FONTS_FILE" &>/dev/null; then
  # Download FantasqueSans Mono
  wget -O "/tmp/FantasqueSansMono.zip" "$FONTS_URL"
  unzip "/tmp/FantasqueSansMono.zip" -d "$FONTS_DIR"
  chmod -R 755 "$FONTS_DIR"
  chown -R "$USER_ID":"$USER_ID" "$FONTS_DIR"
  rm "/tmp/FantasqueSansMono.zip"
fi
