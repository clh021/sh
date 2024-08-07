#!/usr/bin/env bash
# leehom Chen clh021@gmail.com
# https://wiki.archlinuxcn.org/wiki/VirtualBox

sudo pacman -Syyu
# sudo pacman -Sy --overwrite "*" virtualbox virtualbox-host-modules-arch virtualbox-guest-iso
sudo pacman -Sy --overwrite "*" virtualbox virtualbox-host-dkms virtualbox-guest-iso linux-zen-headers

# sudo gpasswd -a $USER vboxusers # USB 设备
sudo usermod -aG vboxusers $USER # USB 设备
yay -S virtualbox-ext-oracle --noconfirm

sudo modprobe vboxdrv

sudo modprobe vboxnetadp # 桥接网络
sudo modprobe vboxnetflt # host-only 网络

# sudo pacman -Rsc virtualbox virtualbox-host-modules-arch virtualbox-guest-iso
sudo pacman -Rsc virtualbox virtualbox-host-dkms virtualbox-guest-iso
# sudo pacman -S vagrant