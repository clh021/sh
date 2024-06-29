#!/usr/bin/env bash
# leehom Chen clh021@gmail.com
# https://wiki.archlinuxcn.org/wiki/VirtualBox

sudo pacman -Syyu
sudo pacman -Sy --overwrite "*" virtualbox virtualbox-host-modules-arch virtualbox-guest-iso
sudo gpasswd -a $USER vboxusers
yay -S virtualbox-ext-oracle --noconfirm
# sudo pacman -S vagrant
