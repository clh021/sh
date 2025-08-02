#!/bin/bash

# 确保脚本以非root用户身份运行，并能使用sudo
# 例如：sudo pacman -S --noconfirm <package>

echo "---- 解决 DNS 问题 (临时方案，以确保 pacman 可用) ----"
# 确保在运行pacman命令前DNS是工作的。如果你的NetworkManager已经配置好，可以跳过。
# 如果NetworkManager没有正确设置DNS，这里是临时的补救措施。
if ! ping -c 1 google.com &>/dev/null; then
	echo "检测到DNS解析问题，设置 DNS..."
	sudo bash -c 'echo "nameserver 233.5.5.5" > /etc/resolv.conf'
	sudo bash -c 'echo "nameserver 233.6.6.6" >> /etc/resolv.conf'
	# 再次测试
	if ! ping -c 1 google.com &>/dev/null; then
		echo "DNS临时设置失败，请手动检查网络连接和DNS配置。"
		exit 1
	fi
	echo "DNS问题已临时解决，可以继续安装软件。"
fi

echo "---- 更新 pacman 数据库并安装 reflector ----"
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm reflector rsync # rsync 是 reflector 的可选依赖，用于测试速度更准确

echo "---- 备份原始 pacman 镜像列表 ----"
sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

echo "---- 自动选择并设置最快的镜像源 ----"
# 这条命令会：
# --country China: 只选择的镜像源
# --protocol https: 只选择HTTPS协议的镜像源（更安全）
# --sort rate: 按下载速度排序 (或者 --sort delay 按延迟排序)
# --save /etc/pacman.d/mirrorlist: 将结果保存到pacman的镜像列表文件
# --latest 5: 只选择最新的5个镜像（可以根据需要调整数量）
sudo reflector --country China --protocol https --sort rate --save /etc/pacman.d/mirrorlist --latest 5

echo "---- 再次更新 pacman 数据库以使用新的镜像源 ----"
sudo pacman -Syu --noconfirm

echo "---- 安装中文字体和常用软件包 ----"
# 后续的安装和配置步骤与之前给出的一致

# 安装中文字体包
sudo pacman -S --noconfirm \
	noto-fonts-cjk \
	wqy-zenhei \
	wqy-microhei \
	adobe-source-han-sans-cn-fonts \
	ttf-dejavu \
	ttf-liberation

echo "---- 更新字体缓存 ----"
sudo fc-cache -fv

echo "---- 安装中文输入法 Fcitx5 及其依赖 ----"
sudo pacman -S --noconfirm \
	fcitx5 \
	fcitx5-gtk \
	fcitx5-qt \
	fcitx5-configtool \
	fcitx5-rime \
	librime

echo "---- 配置中文输入法环境变量 (添加到 /etc/environment) ----"
# 这将影响所有用户。如果 /etc/environment 已经存在相关内容，请确保不会重复添加或冲突。
sudo bash -c 'cat << EOF >> /etc/environment
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=fcitx
EOF'

echo "---- 安装你需要的其他基本软件 ----"
sudo pacman -S --noconfirm \
	git \
	neovim \
	tmux \
	zsh \
	openssh \
	docker \
	docker-compose \
	bluez \
	bluez-utils \
	bluedevil \
	firefox

echo "---- 配置 Zsh 作为默认 Shell (针对当前用户 lee) ----"
chsh -s /bin/zsh lee

echo "---- 启用 Docker ----"
sudo systemctl enable docker
sudo systemctl start docker

echo "---- 将用户 lee 添加到 docker 组 ----"
sudo usermod -aG docker lee

echo "---- 环境、软件和镜像源配置完成，请重启系统以使所有更改生效 ----"
