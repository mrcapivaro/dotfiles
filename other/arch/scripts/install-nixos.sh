#! /usr/bin/bash

mkdir /etc/nixos/
cp -r ./nixos/* /etc/nixos/
chown -R root /etc/nixos/
chgrp -R root /etc/nixos/
