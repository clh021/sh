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

# echo "由于直接设置代理可以直接拉取镜像，能满足各种操作需求，还能保证不同时间拉取的都是最新的，所以非必要不建议设置拉取镜像。"
# echo "由于整个系统都使用一个分区，所以也不需要将 docker 根目录切换到 /home 等目录。"

# 使 dockerd 走代理流量
# sudo mkdir -p /etc/docker
# /usr/bin/dockerd --http-proxy=http://192.168.1.128:1085 --https-proxy=http://192.168.1.128:1085 -H fd:// --containerd=/run/containerd/containerd.sock
# cd /etc/systemd/system
# sudo cp /usr/lib/systemd/system/docker.service .
# sudo vim /etc/systemd/system/docker.service
# sudo systemctl daemon-reload
# sudo systemctl restart docker.service
# systemctl status docker.service

# 在 Docker 引擎版本 23.0 及更高版本中，还可以为 daemon.json 文件中的守护程序配置代理行为：
# {
#   "proxies": {
#     "http-proxy": "http://proxy.example.com:3128",
#     "https-proxy": "https://proxy.example.com:3129",
#     "no-proxy": "*.test.example.com,.example.org,127.0.0.0/8"
#   }
# }
# echo "配置国内镜像加速（可选，适合中国大陆用户）..."
# sudo mkdir -p /etc/docker
# sudo tee /etc/docker/daemon.json > /dev/null <<EOF
# {
#   "registry-mirrors": [
#     "https://docker.mirrors.ustc.edu.cn",
#     "https://hub-mirror.c.163.com"
#   ]
# }
# EOF

# 您可以使用位于 ~/.docker/config.json 的 JSON 配置文件为 Docker 客户端添加代理配置。生成和容器使用此文件中指定的配置。
# {
#  "proxies": {
#    "default": {
#      "httpProxy": "http://proxy.example.com:3128",
#      "httpsProxy": "https://proxy.example.com:3129",
#      "noProxy": "*.test.example.com,.example.org,127.0.0.0/8"
#    }
#  }
# }
#
# FROM ubuntu:18.04
# RUN echo http proxy: ${http_proxy} ${HTTP_PROXY}
# RUN echo https proxy: ${https_proxy} ${HTTPS_PROXY}
# RUN apt-get update && apt-get install -y wget
# CMD ["wget", "--spider", "https://www.google.com"]

# # 定义 Docker 镜像站点列表
# declare -a mirrors=(
#   # "https://dockerimages.clh21.workers.dev"
#   # "https://eko4ves3.mirror.aliyuncs.com"
#   "https://docker.lixd.xyz"
#   "https://docker.fxxk.dedyn.io"
#   "https://docker.hlyun.org"
#   "https://docker.registry.cyou"
#   "https://docker-cf.registry.cyou"
#   "https://docker.jsdelivr.fyi"
#   "https://dockercf.jsdelivr.fyi"
#   "https://dockertest.jsdelivr.fyi"
#   "https://dockerpull.com"
#   "https://dockerproxy.cn"
#   "https://hub.uuuadc.top"
#   "https://docker.1panel.live"
#   "https://hub.rat.dev"
#   "https://docker.anyhub.us.kg"
#   "https://docker.chenby.cn"
#   "https://dockerhub.jobcher.com"
#   # "https://dockerhub.icu"
#   # "https://docker.ckyl.me"
#   # "https://docker.awsl9527.cn"
#   # "https://docker.hpcloud.cloud"
#   # "https://docker.m.daocloud.io"
#   # "https://hub-mirror.c.163.com"
#   # "https://mirror.baidubce.com"
#   # "https://reg-mirror.qiniu.com"   # 不再提供
#   # "https://registry.docker-cn.com" # 不再提供
#   # "https://docker.gin-vue-admin.vip"
#   "http://192.168.192.11:45000"
#   "http://192.168.192.103:5000"
#   "http://127.0.0.1:5000"
# )

# # 检查当前镜像站
# if [ -n "$(grep 'registry-mirrors' /etc/docker/daemon.json)" ]; then
#   echo "当前 Docker 配置了 Mirror 镜像站，镜像站地址为："
#   grep 'registry-mirrors' /etc/docker/daemon.json
# else
#   echo "当前 Docker 没有配置 Mirror 镜像站。"
# fi

# # 显示可选的 Docker 镜像站点
# echo "请选择要使用的 Docker 镜像站点："
# for i in "${!mirrors[@]}"; do
#   echo "[$i] ${mirrors[$i]}"
# done

# # 读取用户选择的镜像站点
# read -p "请输入数字选择镜像站点 [0-${#mirrors[@]}]: " choice
# while [[ ! $choice =~ ^[0-9]+$ || $choice -lt 0 || $choice -ge ${#mirrors[@]} ]]; do
#   echo "您的输入错误。退出请按 Ctrl + C 。"
#   read -p "请重新输入数字选择镜像站点 [0-${#mirrors[@]}]: " choice
# done

# # 构造 JSON# 生成 JSON 字符串
# json="{\"registry-mirrors\":[\"${mirrors[$choice]}\"],\"data-root\":\"/home/.docker_root_dir\"}"
# echo "$json"

# # # 生成 JSON 字符串
# # json="{\"registry-mirrors\":["
# # for mirror in "${mirrors[@]}"
# # do
# #   json+="\"$mirror\","
# # done
# # json="${json%,}]}"
# # echo "$json"

# # 写入配置文件
# sudo mkdir -p /etc/docker/
# echo "$json" | sudo tee /etc/docker/daemon.json >/dev/null

# # 重启 Docker 服务
# # 获取正在运行的容器的 ID
# running_containers=$(docker ps -q)
# # 如果有正在运行的容器，则提示用户是否要停止这些容器
# if [ -n "$running_containers" ]; then
#   # 如果有正在运行的 Docker 容器，列出这些容器
#   echo "以下 Docker 容器正在运行："
#   docker ps
#   echo "重启前将依次停止这些容器。然后在重启后恢复。"

#   # 询问用户是否要继续重启 Docker 服务
#   read -p "是否要现在重启 Docker 服务？[y/N]: " choice
#   if [[ $choice =~ ^[Yy]$ ]]; then
#     # 如果用户选择继续重启 Docker 服务，执行重启命令

#     echo "正在停止所有运行的 Docker 容器..."
#     docker stop "$running_containers"
#     echo "所有运行的 Docker 容器已停止。"

#   else
#     # 如果用户选择不重启 Docker 服务，退出脚本
#     echo "取消重启 Docker 服务。"
#     exit 0
#   fi
# fi

# # 重启 Docker 服务
# echo "正在重启 Docker 服务..."
# sudo systemctl restart docker
# echo "Docker 服务已经重启。"

# # 恢复之前的容器
# if [ -n "$running_containers" ]; then
#   echo "正在恢复之前运行的容器..."
#   for container in $running_containers; do
#     docker start "$container"
#   done
# fi

# echo "完成。"

# # push docker images with proxy
# # HTTPS_PROXY 很关键
# #cat /etc/systemd/system/docker.service.d/http-proxy.conf
# #[Service]
# #Environment="HTTP_PROXY=http://127.0.0.1:20171"
# #Environment="HTTPS_PROXY=http://127.0.0.1:20171"
# #Environment="NO_PROXY=localhost,127.0.0.1"

# #[Service]
# #Environment="HTTP_PROXY=http://192.168.1.128:1085"
# #Environment="HTTPS_PROXY=http://192.168.1.128:1085"
# #Environment="NO_PROXY=localhost,127.0.0.1"

# # 不要给当前用户这个权限
# #sudo groupadd docker
# #sudo usermod -aG docker $(whoami)
# #docker.set.config.sh
# #sudo systemctl restart docker.service
# #sudo systemctl enable docker.service
