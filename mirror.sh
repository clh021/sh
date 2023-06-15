#!/bin/sh
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
  *microsoft*) true ;; # WSL 2
  *Microsoft*) true ;; # WSL 1
  *) false ;;
  esac
}
if is_wsl; then
  echo "WSL DETECTED: OH No!"
  exit 1
fi
command_exists() {
  command -v "$@" >/dev/null 2>&1
}
check_files_exist() {
  local input=$1
  local IFS='|'
  for file in $input; do
    if [ -e "$file" ]; then
      echo "$file"
      return 0
    fi
  done
  echo "All files do not exist!"
  exit 1
}
# files="file1.txt|file2.txt|file3.txt"
# checked_files="$(check_files_exist "$files")"
# echo "First existing file: $checked_files"

lsb_dist=$(get_distribution)
lsb_dist="$(echo "$lsb_dist" | tr '[:upper:]' '[:lower:]')"
timefix=$(date +%Y%m%d_%H%M%S)
USER=$(whoami)

sh_c='sh -c'
if [ "$USER" != 'root' ]; then
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

# 对各种发行版可能的软件仓库配置文件进行地址镜像源的替换
case "$lsb_dist" in
neon | ubuntu)
  $sh_c "cp /etc/apt/sources.list /etc/apt/sources.list.$timefix.bak"
  $sh_c "sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list"
  $sh_c "sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list"
  [ "$MIRROR_DEBUG" = "true" ] && $sh_c "apt-get update"
  ;;
debian)
  conf=$(check_files_exist "/etc/apt/sources.list|/etc/apt/sources.list.d/debian.sources")
  $sh_c "cp $conf $conf.$timefix.bak"
  $sh_c "sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' $conf"
  $sh_c "sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g' $conf"
  [ "$MIRROR_DEBUG" = "true" ] && $sh_c "apt-get update"
  # $sh_c "apt install -y apt-transport-https;"
  # $sh_c "sed -i 's/http:/https:/g' $conf"
  # $sh_c "apt-get update"
  ;;
alpine)
  sources_conf=$(check_files_exist "/etc/apk/repositories")
  $sh_c "cp $sources_conf $sources_conf.$timefix.bak"
  $sh_c "sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' $sources_conf"
  $sh_c "sed -i 's/http:/https:/g' $sources_conf"
  [ "$MIRROR_DEBUG" = "true" ] && $sh_c "apk update"
  ;;
arch)
  sources_conf="/etc/pacman.d/mirrorlist"
  $sh_c "cp $sources_conf $sources_conf.$timefix.bak"
  $sh_c "echo 'Server = https://mirrors.ustc.edu.cn/archlinux/\$repo/os/\$arch' > $sources_conf"
  [ "$MIRROR_DEBUG" = "true" ] && $sh_c "pacman -Syy"
  ;;
centos | rhel)
  set +x
  $sh_c "echo -----------------------------------"
  $sh_c "echo WARN: Support for this distribution is still in development!"
  $sh_c "echo -----------------------------------"
  $sh_c "sleep 5" 
  set -x
  [ "$MIRROR_DEBUG" = "true" ] && $sh_c "sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org/\$contentdir|baseurl=https://mirrors.ustc.edu.cn/centos|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-Stream-AppStream.repo \
         /etc/yum.repos.d/CentOS-Stream-BaseOS.repo \
         /etc/yum.repos.d/CentOS-Stream-Extras.repo \
         /etc/yum.repos.d/CentOS-Stream-PowerTools.repo || true"
  [ "$MIRROR_DEBUG" = "true" ] && $sh_c "sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org/|baseurl=https://mirrors.ustc.edu.cn/|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-Base.repo || true"
  [ "$MIRROR_DEBUG" = "true" ] && $sh_c "cat /etc/yum.repos.d/*.repo"
  [ "$MIRROR_DEBUG" = "true" ] && $sh_c "yum update"
  ;;
*)
  echo "$lsb_dist DETECTED: will be supported in the future!"
  exit 1
  ;;
esac

echo "Software source mirror updated successfully!"
