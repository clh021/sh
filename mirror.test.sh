#!/bin/bash

# 测试脚本目标：
# 在不同的 Docker 镜像中运行脚本，检验脚本在不同系统中的功能

set -e
set -x

# 镜像列表
IMAGES=(
  # "debian:10"
  # "ubuntu:22.04"
  # "ubuntu:21.10"
  # "ubuntu:16.04"
  # "alpine:3.18"
  # "archlinux:latest"
  "centos:7"
)

# 循环遍历镜像，运行脚本并在容器中检查结果
for image in "${IMAGES[@]}"; do
  echo "Testing $image..."
  docker run --rm -it -e MIRROR_DEBUG=true -v `pwd`/:/host "$image" /host/mirror.sh
  # docker run --rm -it -v `pwd`/:/host "$image" /host/mirror.sh
  echo "-----------------------------------"
  sleep 3
done
