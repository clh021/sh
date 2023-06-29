# sh

#### 介绍
exec shell script by curl

#### mirror.sh

##### 使用说明
在搭建的 docker 镜像中有时会临时需要安装一些工具(比如 vim)，如果有一个方法能一键解决软件仓库镜像源的问题，那将是极好的！

```sh
curl -sSL https://gitee.com/clh21/sh/raw/master/mirror.sh | sudo sh  #debian...
curl -sSL https://gitee.com/clh21/sh/raw/master/mirror.sh | sh  #archlinux...
wget https://gitee.com/clh21/sh/raw/master/mirror.sh && sh ./mirror.sh; rm -f mirror.sh #alpine...
```
自己构建 docker 镜像时，也可以一行代码实现加速
```Dockerfile
FROM php:7.3-apache
RUN curl -sSL https://gitee.com/clh21/sh/raw/master/mirror.sh | sh
......
```
或者

```Dockerfile
FROM alpine:latest
MAINTAINER leehom Chen <clh021@gmail.com>
RUN wget https://gitee.com/clh21/sh/raw/master/mirror.sh && sh ./mirror.sh; rm -f mirror.sh
RUN apk update\
    && apk add git npm golang-go
RUN yarn config set registry https://registry.npmmirror.com
RUN npm config set sass_binary_site=https://npm.taobao.org/mirrors/node-sass
ENV GOPROXY=https://goproxy.cn,direct
```
##### 测试记录
- [x] archlinux
- [x] debian(buster|10,bullseye|11)
- [x] debian(bookworm|12)
```bash
# debian bookworm 的 docker 中既没有 wget 也没有 curl
RUN sed -i s/deb.debian.org/mirrors.ustc.edu.cn/g /etc/apt/sources.list.d/debian.sources
RUN sed -i 's|security.debian.org/debian-security|mirrors.ustc.edu.cn/debian-security|g /etc/apt/sources.list.d/debian.sources
```
- [x] alpine(3.12,3.11)
- [x] ubuntu(16.04)
- [ ] centos

#### archlinux_install.sh

##### 使用说明
启动进入 archlinux 系统镜像
1. 连接网络
```sh
iwctl
device list
station [device] get-networks
station [device] connect [SSID]
```
2. 执行脚本
```sh
bash -c "$(curl -fsSL https://gitee.com/clh21/sh/raw/master/archlinux_install.sh)"
```

#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request