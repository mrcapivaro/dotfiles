#!/bin/bash

USER_ID=$(whoami)
FONTS_DIR="/home/$USER_ID/.local/share/fonts"
FANTASQUE_SANS_FILE="FantasqueSans*FontMono*"
FANTASQUE_SANS_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FantasqueSansMono.zip"
JETBRAINS_MONO_FILE="JetBrains*FontMono*"
JETBRAINS_MONO_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"

ensure_fonts_dir() {
  if ! ls $FONTS_DIR &> /dev/null; then
    mkdir -p "$FONTS_DIR"
    chmod 755 "$FONTS_DIR"
    chown "$USER_ID":"$USER_ID" "$FONTS_DIR"
  fi
}

download_and_extract_font() {
  local font_url = $1
  local tmp_file = "/tmp/$(basename "$font_url")"

  wget -O "$tmp_file" "$font_url"
  unzip "$tmp_file" -d "$FONTS_DIR"
  rm "$tmp_file"
  chmod -R 755 "$FONTS_DIR"
  chown -R "$USER_ID":"$USER_ID" "$FONTS_DIR"
}

ensure_fonts_dir

if ! ls "$FONTS_DIR/$FANTASQUE_SANS_FILE" &> /dev/null; then
  download_and_extract_font "$FANTASQUE_SANS_URL"
fi

if ! ls "$FONTS_DIR/$JETBRAINS_MONO_FILE" &> /dev/null; then
  download_and_extract_font "$JETBRAINS_MONO_URL"
fi
