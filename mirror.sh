#!/bin/bash
# 脚本目标：
# 经常会需要在搭建的 docker 镜像中安装一些工具，虽然并不是非常的频繁，但是如果有一个命令脚本自动处理好所有容器的镜像源，那将是极好的！
# 使用方法：
# curl -sSL https://gitee.com/clh21/sh/raw/master/mirror.sh | sudo sh  #debian...
# wget https://gitee.com/clh21/sh/raw/master/mirror.sh && sudo sh ./mirror.sh; rm -f mirror.sh #alpine...
set -e
set -x
get_distribution() {
	lsb_dist=""
	# Every system that we officially support has /etc/os-release
	if [ -r /etc/os-release ]; then
		lsb_dist="$(. /etc/os-release && echo "$ID")"
	fi
	# Returning an empty string here should be alright since the
	# case statements don't act unless you provide an actual value
	echo "$lsb_dist"
}
is_wsl() {
	case "$(uname -r)" in
	*microsoft* ) true ;; # WSL 2
	*Microsoft* ) true ;; # WSL 1
	* ) false;;
	esac
}
command_exists() {
	command -v "$@" > /dev/null 2>&1
}
lsb_dist=$( get_distribution )
lsb_dist="$(echo "$lsb_dist" | tr '[:upper:]' '[:lower:]')"
timefix=$(date +%Y%m%d_%H%M%S)
if is_wsl; then
    echo "WSL DETECTED: OH No!"
    exit 1
fi
sh_c='sh -c'
if [ "$user" != 'root' ]; then
    if command_exists sudo; then
        sh_c='sudo -E sh -c'
    elif command_exists su; then
        sh_c='su -c'
    else
        echo 'Error: this installer needs the ability to run commands as root.'
        echo 'We are unable to find either "sudo" or "su" available to make this happen.'
        exit 1
    fi
fi
case "$lsb_dist" in
    neon)
    ubuntu)
        $sh_c "cp /etc/apt/sources.list /etc/apt/sources.list.$timefix.bak"
        $sh_c "sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list"
    ;;

    alpine)
        $sh_c "cp /etc/apk/repositories /etc/apk/repositories.$timefix.bak"
        $sh_c "sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories"
        $sh_c "sed -i 's/http:/https:/g' /etc/apk/repositories"
    ;;

    debian)
        $sh_c "cp /etc/apt/sources.list /etc/apt/sources.list.$timefix.bak"
        $sh_c "sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list"
        $sh_c "sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list"
        $sh_c "apt-get update -qq >/dev/null"
        $sh_c "apt install -y apt-transport-https;"
        $sh_c "sed -i 's/http:/https:/g' /etc/apt/sources.list"
    ;;

    arch)
        $sh_c 'echo Server = http://mirrors.aliyun.com/archlinux/\$repo/os/\$arch > /etc/pacman.d/mirrorlist'
    ;;

    centos|rhel)
        echo "Centos DETECTED: will be support!"
        exit 1
    ;;

    *)
        echo "$lsb_dist DETECTED: will be support!"
        exit 1
    ;;

esac