#!/bin/bash

# Keymapper setup
sudo cp -r "$HOME/.config/sv/keymapper" /etc/runit/sv/
sudo ln -s /etc/runit/sv/keymapper /run/runit/service/
