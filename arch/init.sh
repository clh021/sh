#!/usr/bin/env bash
# leehom Chen clh021@gmail.com

# install yay
# 不在安装系统时安装，可能会报错
wget https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/x86_64/yay-12.1.3-1-x86_64.pkg.tar.zst -O y.zst | pacman -U --noconfirm ./y.zst

# install ohmyzsh
# 不在安装系统时安装，有确认交互操作
git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git && cd ohmyzsh/tools && REMOTE=https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git sh install.sh

# install some pkgs
sudo pacman -S shellcheck zenity keepassxc peek
