#!/usr/bin/env bash
set -e

magick import ~/Pictures/lsc.png
xclip -sel clip -t image/png ~/Pictures/lsc.png
