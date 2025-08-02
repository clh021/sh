#!/bin/bash
# 安装 Fcitx5 及中文输入法支持
set -e

echo "正在安装 Fcitx5 核心组件..."
sudo pacman -S --noconfirm \
	fcitx5 \
	fcitx5-gtk \
	fcitx5-qt \
	fcitx5-configtool \
	fcitx5-chinese-addons \
	fcitx5-rime \
	fcitx5-im \
	librime

# 配置环境变量（避免重复添加）
if ! grep -q "GTK_IM_MODULE=fcitx" /etc/environment; then
	echo "配置全局环境变量..."
	sudo bash -c 'cat << EOF >> /etc/environment
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=ibus
EOF'
else
	echo "环境变量已存在，跳过配置"
fi

# 创建用户级配置目录
mkdir -p ~/.config/fcitx5
cat >~/.config/fcitx5/profile <<EOF
[Groups/0]
# 组名称
Name=Default
# 默认布局
Default Layout=us
# 默认输入法
DefaultIM=rime

[Groups/0/Items/0]
# 英文输入
Name=keyboard-us

[Groups/0/Items/1]
# 中文输入
Name=rime

[GroupOrder]
0=Default
EOF

# 配置自动启动（KDE 专用）
mkdir -p ~/.config/autostart
cat >~/.config/autostart/fcitx5.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Fcitx5
Exec=fcitx5 -d
Comment=Input Method Framework
EOF

echo "安装完成！请执行以下操作："
echo "1. 注销后重新登录"
echo "2. 在系统设置 > 区域设置 > 输入法中添加 Fcitx5"
echo "3. 按 Ctrl+空格 切换输入法"
