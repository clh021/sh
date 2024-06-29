#!/usr/bin/env bash
# leehom Chen clh021@gmail.com
# https://wiki.archlinuxcn.org/wiki/VirtualBox

sudo pacman -Syyu
sudo pacman -Sy --overwrite "*" virtualbox virtualbox-host-modules-arch virtualbox-guest-iso
# sudo gpasswd -a $USER vboxusers # USB 设备
sudo usermod -a -G vboxusers $USER # USB 设备
yay -S virtualbox-ext-oracle --noconfirm

modprobe vboxdrv

modprobe vboxnetadp # 桥接网络
modprobe vboxnetflt # host-only 网络

# sudo pacman -S vagrant