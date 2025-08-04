#!/usr/bin/env bash
# leehom Chen clh021@gmail.com

# install yay
# 自动获取 yay 最新版本并下载安装
AUR_URL="https://aur.archlinux.org"
PKGBASE="yay"
PKGINFO=$(curl -s "${AUR_URL}/cgit/aur.git/plain/PKGBUILD?h=${PKGBASE}")
VERSION=$(echo "$PKGINFO" | grep -m1 "^pkgver=" | cut -d= -f2)
RELEASE=$(echo "$PKGINFO" | grep -m1 "^pkgrel=" | cut -d= -f2)
PKGNAME="${PKGBASE}-${VERSION}-${RELEASE}-x86_64.pkg.tar.zst"
DOWNLOAD_URL="https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/x86_64/${PKGNAME}"

echo $DOWNLOAD_URL
wget -c "$DOWNLOAD_URL" -O $PKGBASE.zst
sudo pacman -U ./$PKGBASE.zst
rm ./$PKGBASE.zst

yay -S google-chrome
yay -S google-chrome-dev
yay -S visual-studio-code-bin
# yay -S wechat-universal-bwrap
