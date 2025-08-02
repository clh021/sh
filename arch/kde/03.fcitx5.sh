#!/bin/bash
sudo pacman -S --noconfirm \
	fcitx5 \
	fcitx5-gtk \
	fcitx5-qt \
	fcitx5-configtool \
	fcitx5-rime \
	librime

# 这将影响所有用户。如果 /etc/environment 已经存在相关内容，请确保不会重复添加或冲突。
sudo bash -c 'cat << EOF >> /etc/environment
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=fcitx
EOF'
