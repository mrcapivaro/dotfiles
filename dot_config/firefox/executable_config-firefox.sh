#!/usr/bin/env bash
set -euo pipefail

firefox_system_dir="/etc/firefox/policies"
config_dir="$HOME/.config/firefox"
profiles_dir="$HOME/.mozilla/firefox"
def_prof=$(awk -F= '/^Default=/ { print $2 }' "$profiles_dir/installs.ini")
firefox_dir="$profiles_dir/$def_prof"

echo "[*] Symlinkg user.js and chrome/ folder."
ln -sf "$config_dir/user.js" "$firefox_dir"
ln -sf "$config_dir/chrome" "$firefox_dir"

echo "[*] Symlinking 'policies.json' to '/etc/firefox/policies'."
[[ ! -d "$firefox_system_dir" ]] && sudo mkdir -p "$firefox_system_dir"
sudo ln -sf "$config_dir/distribution/policies.json" "$firefox_system_dir"

echo "[*] Installing tridactyls native messenger to enable config through dotfiles."
curl \
    -fsSl https://raw.githubusercontent.com/tridactyl/native_messenger/master/installers/install.sh \
    -o /tmp/trinativeinstall.sh && sh /tmp/trinativeinstall.sh 1.24.1

echo "[*] Done."
