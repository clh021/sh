#!/bin/bash

# Packages
packages=(
	# 系统安装时已经安装
	# git
	# zsh
	# sudo
	# openssh
	tmux
	mosh
	# 离线文档
	zeal
	# 内容浏览
	ranger
	# 搜索
	the_silver_searcher
	# git
	git
	tk
	tig
	# mysql cli
	mycli
	# 下载与传输
	axel
	# 视频下载
	you-get
	# 代码统计 Count Lines of Code
	cloc
	# 磁盘分析
	ncdu
	# 转艺术字体
	figlet
	# 创建热点
	create_ap
	# x11docker
	x11docker
	# 沙箱
	firejail
	# Cat clone with syntax highlighting and git integration
	bat
	# 命令简化文档，但无法链接线上服务器
	# tldr
	# 文件或目录的对比(可扩展git)
	# icdiff [options] left_file right_file
	icdiff
	#添加 nvim 的 Python支持
	python-pynvim

	# find 替代方案 https://github.com/chinanf-boy/fd-zh
	fd
	# 通用命令行模糊查找器 https://github.com/junegunn/fzf
	fzf
	# script for launching fzf in a tmux pane
	fzf-tmux
	# 支持gitignore的内容正则搜索 https://github.com/BurntSushi/ripgrep
	# rg [OPTIONS] PATTERN [PATH...]
	ripgrep
	# 蓝牙支持
	# systemctl start bluetooth.service
	# systemctl enable bluetooth.service
	# echo 'load-module module-bluetooth-policy' >> /etc/pulse/system.pa
	# echo 'load-module module-bluetooth-discover' >> /etc/pulse/system.pa
	bluez
	bluez-utils
	pulseaudio-bluetooth
	# 终端
	alacritty

pacman -S base-devel xorg-server xorg-apps xorg-xinit dmenu yay alacritty openssh cronie p7zip
pacman -S xorg-xrandr

# pacman -R libreoffice*
	#k8s
	kubectl
	#ss.sh 用到的libfuse.so
	fuse
	# protoc 开发
	protobuf
	# 安装 dpkg 到系统
	# dpkg-deb -x lithium_4.4.1-20191230054113_amd64.deb ./
	# dpkg -X ./xxx.deb extract
	dpkg
	# 截图软件
	flameshot

	# 强大的U盘系统
	ventoy-bin
	# Fonts
	ttf-font-awesome
	ttf-material-icons
	ttf-dejavu
	noto-fonts-emoji
	adobe-source-han-sans-cn-fonts
	adobe-source-code-pro-fonts
	powerline-fonts
	wqy-bitmapfont
	wqy-microhei
	wqy-microhei-lite
	wqy-zenhei
	# 输入法
	# fcitx fcitx-im fcitx-googlepinyin fcitx-configtool
	# 压缩
	zip
	unzip
	p7zip
	# docker 服务
	# systemctl enable docker
	# docker.set.config.sh 自动配置
	docker
	# wps
	wps-office
	ttf-wps-fonts
	wps-office-mui-zh-cn
	# google-chrome
	google-chrome
	# go develop
	go
	go-tools
	#nodejs
	nodejs
	npm
	# sqlite browser
	sqlitebrowser
	# vscode
	visual-studio-code-bin
	# 虚拟机
	virtualbox
	virtualbox-host-modules-arch
	virtualbox-ext-oracle
	virtualbox-guest-utils
	# sudo usermod -a -G vboxusers arch

)


# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if command -v tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
fi

function check() {
    if ! command -v yay >/dev/null 2>&1 && ! command -v pacman >/dev/null 2>&1; then
        echo "${RED}Error: not Archlinux or its devrived edition.${NORMAL}" >&2
        exit 1
    fi
}

function install() {
    CMD=''
    if command -v yay >/dev/null 2>&1; then
        CMD='yay -Ssu --noconfirm'
    elif command -v pacman >/dev/null 2>&1; then
        CMD='sudo pacman -Ssu --noconfirm'
    else
        echo "${RED}Error: not Archlinux or its devrived edition.${NORMAL}" >&2
        exit 1
    fi

    for p in ${packages[@]}; do
        printf "\n${BLUE}➜ Installing ${p}...${NORMAL}\n"
        ${CMD} ${p}
    done
}

function main() {
    check
    install
}

main
