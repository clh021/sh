#!/bin/bash
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
