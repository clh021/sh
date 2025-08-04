#!/bin/bash
sudo pacman -S --noconfirm \
	git \
	tig \
	neovim \
	tmux \
	zsh \
	openssh

echo "---- 配置 Zsh 作为默认 Shell (针对当前用户 $USER) ----"
chsh -s /bin/zsh $USER
