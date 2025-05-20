#!/usr/bin/env bash
set -euo pipefail

run() {
    local name=$1
    local cmd="$@"
    if ! ps -C $name &>/dev/null; then
        $cmd &
    fi
}

ls-desktop-entries-exec() {
    local dir="$1"
    find "$dir" -type f -name "*.desktop" | xargs -n 1 sed -n "s/^Exec=\(.*\)/\1/p"
}

run-desktop-entries() {
    local dir="$1"
    local entries_cmds=$(ls-desktop-entries-exec "$dir")

    # NOTE: using a for loop resulted in an error.
    # Using a while loop fixed it. Why? subshells & IFS?
    echo "$entries_cmds" | while IFS= read -r cmd; do
        run "$cmd"
    done
}

run-desktop-entries "$HOME/.config/autostart"
xrandr | grep -q "HDMI-0.*1920x1080" || xrandr --output HDMI-0 --mode "1920x1080"
feh --no-fehbg --bg-max ~/.config/wallpapers/disco-elysium.png &
