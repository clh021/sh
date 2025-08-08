#!/bin/bash
# 安装 Docker 和 Docker Compose，并进行基础配置
set -e

echo "正在安装 Docker..."
sudo pacman -S --noconfirm docker

echo "正在安装 Docker Compose..."
sudo pacman -S --noconfirm docker-compose

echo "启动并设置 Docker 服务开机自启..."
sudo systemctl enable --now docker

echo "将当前用户加入 docker 用户组（需重新登录生效）..."
sudo usermod -aG docker "$USER"

echo "拷贝全部默认配置到 docker 配置目录，可根据机器时机情况适当删改"
sudo cp ~/.docker/etc.docker.daemon.json /etc/docker/daemon.json

echo "重启 Docker 服务以应用配置..."
sudo systemctl restart docker

echo "安装完成！请重新登录以使 docker 组权限生效。"
echo "你可以用 'docker run hello-world' 测试 Docker 是否可用。"
