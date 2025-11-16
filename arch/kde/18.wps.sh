#!/usr/bin/env bash
# leehom Chen clh021@gmail.com
# install wps
# yay -S wps-office wps-office-mui-zh-cn ttf-wps-fonts # use wps365
yay -S libtiff5 cups libjpeg-turbo pango curl ttf-wps-fonts ttf-ms-fonts
yay -S wps-office-fonts wps-office-mime wps-office-mui-zh-cn

# Linux 英文系统下，切换wps界面语言为中文
# head -n 5 (wps et wpp wpspdf)
# head -n 5 `which et`
# 添加环境变量 LANGUAGE=zh_CN
# sed -i '2iLANGUAGE=zh_CN' 文件路径
# sed -i '2iLANGUAGE=zh_CN' `which wps`
# 或者
#   nano  ~/.config/Kingsoft/Office.conf
# 将
# [General]
# languages=
# PersistentStatus=0
# 修改为
# [General]
# languages=zh_CN
# PersistentStatus=0
# 没有[General]就添加[General]
