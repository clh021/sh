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

echo "正在安装 Fcitx5 主题和 Rime-ice 输入方案..."
yay -S --noconfirm fcitx5-skin-adwaita-dark rime-ice-git

# 创建 Rime 用户配置目录
mkdir -p ~/.local/share/fcitx5/rime

# 首次运行时创建默认配置（保证输入法设置生效）
if [ ! -f ~/.local/share/fcitx5/rime/default.custom.yaml ]; then
	cat >~/.local/share/fcitx5/rime/default.custom.yaml <<EOF
patch:
  "menu/page_size": 9
  schema_list:
    - schema: rime_ice
EOF
fi

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

# 配置用户级环境变量
echo "配置用户级环境变量..."
cat >~/.pam_environment <<EOF
GTK_IM_MODULE=fcitx5
QT_IM_MODULE=fcitx5
XMODIFIERS=@im=fcitx5
SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=ibus
LANG=zh_CN.UTF-8
LC_CTYPE=zh_CN.UTF-8
EOF

# 配置 .xprofile
echo "配置 .xprofile..."
cat >~/.xprofile <<EOF
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS="@im=fcitx5"
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus
export LANG="zh_CN.UTF-8"
export LC_CTYPE="zh_CN.UTF-8"
fcitx5 &
EOF

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

# 写入 classicui.conf 配置
mkdir -p ~/.config/fcitx5/conf
cat >~/.config/fcitx5/conf/classicui.conf <<EOF
# 横向候选列表
Vertical Candidate List=False

# 禁止字体随着 DPI 缩放， 避免界面太大
PerScreenDPI=False

# 字体和大小， 可以用 fc-list 命令来查看使用
Font="Noto Sans Mono 13"

# Gnome3 风格的主题
Theme=adwaita-dark

# 关闭输入法信息提示
ShowInputMethodInformation=False
ShowInputMethodInformationWhenFocusIn=False

# 候选词数量
CandidateWordCount=9

# 鼠标翻页
UseMouseForPaging=True
EOF

echo "安装完成！请执行以下操作："
echo "1. 注销后重新登录"
echo "2. 在系统设置 > 区域设置 > 输入法中添加 Fcitx5"
echo "3. 按 Ctrl+空格 切换输入法"
