#!/usr/bin/env bash
set -e

add_runit_service() {
	if [ ! -d "/etc/runit/sv/$1" ]; then
		if [ -d "$HOME/.config/sv/system/$1" ]; then
      echo "Copying files from ´~/.config/sv/system/$1´ to ´/etc/runit/sv´..."
			sudo cp -r "$HOME/.config/sv/system/$1" "/etc/runit/sv/"
		else
			echo "No service with the name $1 was found at ´/etc/runit/sv´ or ´~/.config/sv/system´."
			exit 1
		fi
	fi
	if [ ! -d "/run/runit/service/$1" ]; then
		echo "Symlinking $1 from ´/etc/runit/sv´ to ´/run/runit/service/´..."
		sudo ln -sf "/etc/runit/sv/$1" "/run/runit/service/$1"
		sudo sv up $1
	fi
}

main() {
	add_runit_service "openntpd"
	add_runit_service "keymapperd"
	add_runit_service "ratbagd"
}

main
