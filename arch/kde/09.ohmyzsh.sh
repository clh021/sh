#!/bin/bash

# 检查并安装 zsh
if ! command -v zsh &>/dev/null; then
	echo "zsh 未安装，正在安装..."

	# 根据不同的包管理器尝试安装
	if command -v apt-get &>/dev/null; then
		sudo apt-get update && sudo apt-get install -y zsh
	elif command -v yum &>/dev/null; then
		sudo yum install -y zsh
	elif command -v dnf &>/dev/null; then
		sudo dnf install -y zsh
	elif command -v pacman &>/dev/null; then
		sudo pacman -Sy --noconfirm zsh
	elif command -v apk &>/dev/null; then
		sudo apk add zsh
	elif command -v brew &>/dev/null; then
		brew install zsh
	else
		echo "无法确定包管理器，请手动安装 zsh"
		exit 1
	fi
else
	echo "zsh 已安装"
fi

# 检查并安装 oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "oh-my-zsh 未安装，正在安装..."
	git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git && cd ohmyzsh/tools && REMOTE=https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git sh install.sh
else
	echo "oh-my-zsh 已安装"
fi

# 切换默认 shell 到 zsh
if [ "$SHELL" != "$(which zsh)" ]; then
	echo "正在将默认 shell 切换为 zsh..."
	chsh -s "$(which zsh)"
	echo "切换完成，请重新登录或启动新的终端会话以生效"
else
	echo "当前 shell 已经是 zsh"
fi
