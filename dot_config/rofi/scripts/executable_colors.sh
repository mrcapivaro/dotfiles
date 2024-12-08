#!/usr/bin/env bash
set -euo pipefail

# Set the PWD to the ~/.config/rofi folder
cd "$HOME/.config/rofi"

main() {
    # Correctly formated file containing the color names and their respective
    # values.
    local file_dir="./scripts/colors/dark-colors"

    local copy_cmd="xclip -sel clip"

    local color_name=$(cat $file_dir |
        awk '{print $1}' |
        xargs -n 1 |
        rofi \
            -dmenu \
            -p "" \
            -theme "configs/apps.rasi")

    local color_value=$(cat $file_dir |
        grep "$color_name" |
        awk '{printf "%s", $2}')

    # `"` can not be used with `$copy_cmd`.
    echo -n $color_value | $copy_cmd
}

main "$@"
