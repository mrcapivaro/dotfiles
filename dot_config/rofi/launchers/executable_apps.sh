#!/usr/bin/env bash
set -euo pipefail

me="$(readlink -f $0)"
here="$(dirname $me)"

rofi -mode drun \
    -show drun \
    -theme "$here/../configs/apps.rasi"
