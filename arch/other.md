# arch gnome init


## archinstall

# keyring
```bash
# 检查时钟是否正确
# timedatectl status
sudo pacman -S archlinuxcn-keyring
```

# font
```bash
#  paru -S nerd-fonts-jetbrains-mono # 和 nerd-fonts-complete 二选一
sudo pacman -S nerd-fonts-complete
paru -S ttf-dejavu ttf-joypixels ttf-material-design-icons
```

# virtualbox
```bash
uname -srm # 查看内核版本
sudo pacman -S linux-headers
sudo pacman -S virtualbox-host-dkms
sudo pacman -S  virtualbox-guest-iso
sudo pacman -S  virtualbox-ext-oracle
sudo modprobe vboxdrv
sudo modprobe vboxnetadp
sudo modprobe vboxnetflt
sudo usermod -a -G vboxusers $USER
```

#  u盘
```bash
sudo groupadd usbfs
sudo usermod -a -G usbfs $USER
#sudo reboot now
```

# navicat 无限试用
paru -S navicat15-premium-cs
# 到期后 (可以写进脚本方法, 或定时任务, 记得经常备份连接)
# rm -r ~/.config/dconf ~/.config/navicat
#  or navicat patch  http://www.hushowly.com/articles/2828 (用的低版本openssl, 搞不定, 放弃)
mkdir ~/.local/src
cd ~/.local/src
wget http://www.navicat.com.cn/download/direct-download?product=navicat15-premium-cs.AppImage&location=1
mkdir navicatTemp
sudo mount -o loop ./navicat15-premium-cs.AppImage ./navicatTemp
cp -r navicatTemp navicat
sudo umount navicatTemp
sudo rm -r navicatTemp
git clone https://github.com/keystone-engine/keystone.git
cd keystone
mkdir build
cd build
../make-share.sh
sudo make install
sudo ldconfig
cd ../../
git clone -b linux --single-branch https://gitee.com/andisolo/navicat-keygen.git
cd navicat-keygen
make all #


``` shell
# 触摸板
libinput-gestures-setup autostart start
```

录屏软件内录都没声音(pulseaudio):
```bash
#(注意:录屏过程中插拔耳机会导致录屏无声)
pactl list | grep "Monitor Source" | awk '{print $3}' | xargs -I {} pacmd set-source-mute {} 0
#快捷键开启/关闭麦克风(pulseaudio):
pactl list sources | grep Name | grep input | awk '{print $2}' | xargs -I {} pactl set-source-mute {} toggle
#音频捕获还是不动弹的话重启下obs就可以了
#麦克风降噪(pulseaudio换pipewire):
sudo pacman -S pipewire pipewire-pulse pipewire-jack pipewire-alsa
sudo pacman -S easyeffects calf
sudo pacman -S lsp-plugins zam-plugins # 慎重, 会生成很多图标
#https://blog.ryey.icu/zhs/replace-pulseaudio-with-pipewire.html
#https://zhuanlan.zhihu.com/p/439611615
#https://wiki.archlinuxcn.org/wiki/PipeWire
```

### 修复引导
启动 live cd, 打开终端

``` shell
# passwd # sudo 要密码时执行
# 列出磁盘和分区, 我的系统所在硬盘是 `nvme0n1`,
# 根分区是 `nvme0n1p2`, efi(esp) 分区是 `nvme0n1p1`
sudo lsblk
sudo mount /dev/nvme0n1p2 /mnt          # 挂载根分区
sudo mount /dev/nvme0n1p1 /mnt/boot/efi # 挂载 efi 分区
sudo arch-chroot /mnt # 切换根目录
sudo grub-install --recheck /dev/nvme0n1 # 安装 grub
sudo grub-mkconfig -o /boot/grub/grub.cfg # 生成配置
exit # 退出 chroot 环境并关机
shutdown now
```

### 包管理常用命令
#### pacman
参考 [Arch Linux 软件包的查询及清理](https://www.cnblogs.com/sztom/p/10652624.html)
```bash
#查询 lib 被谁依赖
pacman -Qi libname | grep "Required By"
#查询包依赖谁
pacman -Qi packagename | grep "Depends On"
#列出孤立的包（-t不再被依赖的"作为依赖项安装的包"）
pacman -Qqdt #通常这些是可以妥妥的删除的
sudo pacman -Qqdt | sudo pacman -Rs -
#列出包所拥有的文件
sudo pacman -Ql packagename
```

### 音频和蓝牙
```shell
sudo pacman -S easyeffects pipewire-pulse
sudo pacman -S pavucontrol
sudo pacman -S bluez bluez-utils bluedevil
pactl load-module module-bluetooth-discover
sudo vim /etc/bluetooth/main.conf

FastConnectable=true
AutoEnable=true
```

