#!/usr/bin/env bash
# leehom Chen clh021@gmail.com

sudo pacman -S virtualbox virtualbox-guest-iso
sudo gpasswd -a $USER vboxusers
yay -S virtualbox-ext-oracle --noconfirm
