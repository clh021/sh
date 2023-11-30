#!/usr/bin/env bash
# leehom Chen clh021@gmail.com
# 从国内的镜像中筛选出 5 个最新的并且支持 HTTPS 的镜像，按下载速度排序，将结果覆写到 /etc/pacman.d/mirrorlist 文件内
# 使用 100 个线程对镜像进行评级，加快速度
reflector --verbose \
	--country China \
	--latest 5 \
	--protocol https \
	--sort rate \
	--threads 100 \
	--save /etc/pacman.d/mirrorlist
