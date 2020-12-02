# sh

#### 介绍
exec shell script by curl

#### 使用说明

##### mirror.sh
在搭建的 docker 镜像中有时会临时需要安装一些工具(比如 vim)，如果有一个方法能一键解决软件仓库镜像源的问题，那将是极好的！
> curl -sSL https://gitee.com/clh21/sh/raw/master/mirror.sh | sudo sh

自己构建 docker 镜像时，也可以一行代码实现加速
```Dockerfile
FROM php:7.3-apache
RUN curl -sSL https://gitee.com/clh21/sh/raw/master/mirror.sh | sh
......
```

##### 测试记录
- [x] debian(buster)
- [ ] ubuntu
- [ ] centos

#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request