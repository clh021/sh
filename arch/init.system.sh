#!/usr/bin/env bash
# leehom Chen clh021@gmail.com

# install yay
# 不在安装系统时安装，可能会报错
# https://aur.archlinux.org/packages/yay 查最新版本号
wget -c https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/x86_64/yay-12.4.2-1-x86_64.pkg.tar.zst -O y.zst
sudo pacman -U ./y.zst

yay -S google-chrome
yay -S visual-studio-code-bin
yay -S wechat-universal-bwrap
# yay -S motrix # electorn error

# install ohmyzsh
# 不在安装系统时安装，有确认交互操作
git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git && cd ohmyzsh/tools && REMOTE=https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git sh install.sh

# install some pkgs
sudo pacman -S shellcheck zenity keepassxc peek elisa smplayer

# install wps
# yay -S wps-office wps-office-mui-zh-cn ttf-wps-fonts # use wps365
# Linux 英文系统下，切换wps界面语言为中文
# head -n 5 (wps et wpp wpspdf)
# head -n 5 `which et`
# 添加环境变量 LANGUAGE=zh_CN
# sed -i '2iLANGUAGE=zh_CN' 文件路径
# sed -i '2iLANGUAGE=zh_CN' `which wps`
# 或者
#   nano  ~/.config/Kingsoft/Office.conf
# 将
# [General]
# languages=
# PersistentStatus=0
# 修改为
# [General]
# languages=zh_CN
# PersistentStatus=0
# 没有[General]就添加[General]

# 更好用一点的 sqlite 数据库软件
yay -S sqlitestudio-plugins

# 查找重复文件
sudo pacman -S libheif
yay -S czkawka-gui-bin

echo "请注意设置部分机器的禁止休眠和通电开机"

sudo pacman -S cups
sudo systemctl start cups.service
sudo pacman -S system-config-printer
sudo pacman -S print-manager
