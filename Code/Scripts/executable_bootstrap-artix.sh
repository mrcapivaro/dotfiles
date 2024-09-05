#!/bin/sh
set -e

# Add Arch repos to Artix:
# https://dev.to/nabbisen/artix-linux-add-arch-linux-repos-extra-community-35ab
sudo cp /etc/pacman.conf /etc/pacman.conf.bak
sudo pacman -Syyu --noconfirm artix-archlinux-support

cat <<EOF >>/etc/pacman.conf
#[testing]
#Include = /etc/pacman.d/mirrorlist-arch
[extra]
Include = /etc/pacman.d/mirrorlist-arch

#[community-testing]
#Include = /etc/pacman.d/mirrorlist-arch
[community]
Include = /etc/pacman.d/mirrorlist-arch

#[multilib-testing]
#Include = /etc/pacman.d/mirrorlist-arch
[multilib]
Include = /etc/pacman.d/mirrorlist-arch
EOF

sudo pacman-key --populate archlinux
sudo pacman -Syyu

# install xclip
# Install yay
pacman -S --needed --noconfirm git base-devel
git clone https://aur.archlinux.org/yay-bin.git ~/Downloads/yay
cd ~/Downloads/yay
makepkg -si
cd ..
rm -rf ./yay
