#!/bin/bash
# 使用方法：
# curl -sSL https://gitee.com/clh21/sh/raw/master/mirror.sh | sudo sh
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
lsb_dist=$( get_distribution )
lsb_dist="$(echo "$lsb_dist" | tr '[:upper:]' '[:lower:]')"
timefix=$(date +%Y%m%d_%H%M%S)
if is_wsl; then
    echo "WSL DETECTED: OH No!"
    exit
fi

case "$lsb_dist" in
    ubuntu)
        sudo cp /etc/apt/sources.list /etc/apt/sources.list.$timefix.bak
        sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
    ;;

    debian)
        sudo cp /etc/apt/sources.list /etc/apt/sources.list.$timefix.bak
        sudo sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
        sudo sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list
        apt update; apt install -y apt-transport-https;
    ;;

    centos|rhel)
        echo "Centos DETECTED: will be support!"
        exit
    ;;

    *)
        echo "$lsb_dist DETECTED: will be support!"
        exit
    ;;

esac