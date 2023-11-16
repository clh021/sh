# arch gnome init


## archinstall

# keyring
sudo pacman -S archlinuxcn-keyring
# 如果装完很多类似下边的错
# ERROR: 4B1DE545A801D4549BFD3FEF90CB3D62C13D4796 could not be locally signed
# 先检查时钟是否正确
# timedatectl status
# 然后
# sudo rm -rf /etc/pacman.d/gnupg
# sudo pacman-key --init
# sudo pacman-key --populate archlinux
# sudo pacman-key --populate archlinuxcn


# font
#  paru -S nerd-fonts-jetbrains-mono # 和 nerd-fonts-complete 二选一
sudo pacman -S nerd-fonts-complete
paru -S ttf-dejavu ttf-joypixels ttf-material-design-icons


# virtualbox
uname -srm # 查看内核版本
sudo pacman -S linux-headers
sudo pacman -S virtualbox-host-dkms
sudo pacman -S  virtualbox-guest-iso
sudo pacman -S  virtualbox-ext-oracle
sudo modprobe vboxdrv
sudo modprobe vboxnetadp
sudo modprobe vboxnetflt
sudo usermod -a -G vboxusers $USER
#  u盘
sudo groupadd usbfs
sudo usermod -a -G usbfs $USER
#sudo reboot now

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

# gnome 扩展中开启插件
```

## README

    fcitx5:
    "经典用户界面" 组件不要禁用, 会变得不幸
    idea 中 fcitx5 光标问题:
    https://blog.csdn.net/weixin_43840399/article/details/112205858

    所有录屏软件内录都没声音(pulseaudio):
    (注意:录屏过程中插拔耳机会导致录屏无声)
    pactl list | grep "Monitor Source" | awk '{print $3}' | xargs -I {} pacmd set-source-mute {} 0
    快捷键开启/关闭麦克风(pulseaudio):
    pactl list sources | grep Name | grep input | awk '{print $2}' | xargs -I {} pactl set-source-mute {} toggle
    音频捕获还是不动弹的话重启下obs就可以了
    麦克风降噪(pulseaudio换pipewire):
    sudo pacman -S pipewire pipewire-pulse pipewire-jack pipewire-alsa
    sudo pacman -S easyeffects calf
    sudo pacman -S lsp-plugins zam-plugins # 慎重, 会生成很多图标
    https://blog.ryey.icu/zhs/replace-pulseaudio-with-pipewire.html
    https://zhuanlan.zhihu.com/p/439611615
    https://wiki.archlinuxcn.org/wiki/PipeWire

    obs必要设置:
    `右击`-`变换`-`拉伸到全屏`;
    `文件-设置-输出-输出模式-高级`;
    `输出-录像-格式` 设为 `mp4`

    grub:
    如果要自己更换 grub 主题背景, grub 不支持自动缩放和剪裁,
    图片后缀名也需要符合图片格式


### calibre 添加词典

    1. 调出词典界面: 在 `E-book viewer` 中
    随便选个单词鼠标右击，在上方找到第二个选项:
    `查阅或搜索选中的文字`

    2. 在界面右侧最下方点击 `+添加资源`

    3. 点击添加, 然后输入名称和地址。名称自己随便取。
    地址的话就是官方地址首页，然后在尾部加上:
    `{word}` 或者 `?q{word}`，
    注意地址一定都是英文字符，word要小写，大写无用。
    至于是加带问号的还是不带问号的，只能自己挨个试试啦

``` txt

谷歌翻译 https://translate.google.cn/?q={word}

柯林斯(简洁但没发音) https://m.youdao.com/singledict?q={word}&dict=collins

必应词典(缩放不太好) https://cn.bing.com/dict/search?q={word}

海词英文(缩放不太好) http://dict.cn/{word}

有道词典(缩放不太好) http://dict.youdao.com/search?q={word}

金山词霸(缩放不太好) http://www.iciba.com/{word}

韦伯词典(失效?) https://www.merriam-webster.com/?q={word}

大辞海(缩放不太好, 失效?) http://dacihai.com.cn/?q{word}

海词汉语词典 https://hanyu.dict.cn/{word}

汉典 https://www.zdic.net/hans/{word}

泰伯医学词典 https://www.tabers.com/tabersonline?q{word}
```

来源 [calibre中如何使用词典？](https://www.zhihu.com/question/56063180)

### golden-dict

#### 必应

新建文件 `bing.html`

``` html
<!DOCTYPE html>
<html>
<head>
    <meta charset=utf-8 />
    <style>
        iframe{ width: 706px; height: 650px; margin-top:-190px; margin-left:-120px;
        }
    </style>
</head>

<body>
    <iframe id="a" frameborder="0">
    </iframe>
    <script>
    var word = location.href.slice(location.href.indexOf('?a')+3);
    document.getElementById('a').setAttribute(
        'src',
        'https://www.bing.com/dict/search?q=' + word);
    </script>
</body>
</html>
```

    菜单栏选择 【编辑】>【词典】>【词典来源】>【网站】> 添加，
    在新添加条目前勾选 【已启用】 和 【作为链接】，
    条目 【名称】 可自定义，【地址】填：`file://FILE_PATH`
    如 file:///home/v/dict/bing.html

#### google-translate

    需要 python 3.7+, 如果没有 pip 先安装:
    `sudo pacman -S python-pip`
    `pip3 install google-translate-for-goldendict`

    `编辑 - 字典 - 字典来源 - 程式`
    类型: `Html`
    名称: `Google Translate`
    命令行: `python -m googletranslate zh-CN %GDWORD%`
    类型可以设为 `Html` 或 `纯文本`
    其中: `Html` 对应 `-r "html"`. `纯文本` 对应 `-r "plain"`

[github](https://github.com/xinebf/google-translate-for-goldendict)

#### 构词法规则

要想能直接用复数时态等查词需要添加对应语言的构词法规则 [下载地址](http://sourceforge.net/projects/goldendict/files/better%20morphologies/1.0/)

#### 发声音频播放器调用失败:

`编辑 - 首选项 - 音频 - 播放 - 使用外部程序播放: mpv`

参考:

- [GoldenDict 中设置在线词典](https://zhuanlan.zhihu.com/p/151810213)
- [快速上手 Goldendict](https://zhuanlan.zhihu.com/p/344770839)
- [安装使用 GoldenDict 查词神器 (Windows/Mac/Linux)](https://www.cnblogs.com/keatonlao/p/12702571.html)

:: 查词慢的问题, 在词典中把维基百科禁用了就好了


### datagrip sqlite3 新增表找不到的问题

[sqlite3 新增表找不到的问题](https://www.cnblogs.com/tuobei/p/12616465.html?ivk_sa=1024320u " 关于pycharm 使用sqlite创建数据库表，创建模型后，表找不到或者不显示"):

在数据库上点开小扳手 在 file 栏输入当前项目文件夹里的 db.sqlite3 文件地址 ok

如果之前己经开过 console 了(一般肯定都开过了), 在打开的默认查询 console 标签下的运行工具栏最后有一个会话标签, 从这里切换到
default 会话就可以查到了, 然后从底部的服务标签中删除刚刚那个无效的 console 就可以了

*查看 `StartupWMClass` 的方式: 命令行输入 `xprop WM_CLASS` 然后点击目标窗口, 修复其它固定到 dock 栏启动后窗口图标和启动图标分离的应用都可以这样先找到 StartupWMClass 后填入 /usr/share/applications 下对应的启动快捷方式中

### 修复引导

启动 live cd, 打开终端

``` shell
# passwd # sudo 要密码时执行
# 列出磁盘和分区, 我的系统所在硬盘是 `nvme0n1`,
# 根分区是 `nvme0n1p2`, efi(esp) 分区是 `nvme0n1p1`
sudo lsblk
# 挂载根分区
sudo mount /dev/nvme0n1p2 /mnt
# 挂载 efi 分区
sudo mount /dev/nvme0n1p1 /mnt/boot/efi
# 切换根目录
sudo arch-chroot /mnt
# 安装 grub
sudo grub-install --recheck /dev/nvme0n1
# 生成配置
sudo grub-mkconfig -o /boot/grub/grub.cfg

# 退出 chroot 环境并关机
exit
shutdown now
```

### 包管理常用命令

#### pacman

参考 [Arch Linux 软件包的查询及清理](https://www.cnblogs.com/sztom/p/10652624.html)

查询 lib 被谁依赖

`pacman -Qi libname | grep "Required By"`

查询包依赖谁

`pacman -Qi packagename | grep "Depends On"`

列出孤立的包（-t不再被依赖的"作为依赖项安装的包"）

`pacman -Qqdt` 通常这些是可以妥妥的删除的

`sudo pacman -Qqdt | sudo pacman -Rs -`

列出包所拥有的文件

`sudo pacman -Ql packagename`



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

### 日常软件

```shell
yay -S xorg-xsetroot
yay -S xf86-input-synaptics # 触摸板
yay -S network-manager-applet
yay -S rofi
yay -S libxft-bgra # 彩色emoji
yay -S lxappearance # gui设置
sudo pacman -S mpc mpd ncmpcpp # 音乐
yay -S byzanz # 命令行截动图
```

## 一些常用知识

- 变量相关文件 / 目录

`/etc/environment`, `~/.pam_environment`, `~/.zshenv` 环境变量配置项, 在任何场景下都能被读取, 通常把 `$PATH` 等变量写在这里,
这样无论是在交互 shell 或者运行程序都会读取此文件

`~/.zlogin` 在 login shell 的时候读取, 比如系统启动的时候会读取此文件

`/etc/profile`, `~/.profile`, `~/.zprofile` 当用户第一次登录时, 该文件被执行, 当被修改时, 必须重启才会生效. .zprofile 是
.zlogin 的替代品，如果使用了 .zlogin 就不必再关心此文件

`/etc/profile.d/` 可以简单的理解为是 /etc/profile 的一部分, 只不过按类别或功能拆分成若干个文件进行配置了 (
方便维护和理解)

`/etc/bashrc`, `~/.bashrc`, `~/.zshrc` 为每个运行对应 shell 的用户执行该文件, 当 shell 打开时, 该文件被执行, 其配置对所有使用
shell 的用户打开的每个 shell 都有效. 当被修改后, 不用重启只需要打开一个新的 shell 即可生效.

`~/.bash_logout`, `~/.zlogout` 每次退出对应 shell 时执行该文件, 可以把一些清理工作的命令放进这个文件

以上需要重启才能生效的文件, 其实可以通过source xxx暂时生效.

执行顺序:

当登录 Linux 时, 首先启动 /etc/environment 和 /etc/profile,
然后启动当前用户目录下的 /.bash_profile
执行此文件时一般会调用 /.bashrc 文件,
而执行 /.bashrc 时一般会调用 /etc/bashrc,
最后退出 shell 时, 执行 /.bash_logout.

简单来说顺序为:

登录时

`/etc/environment` → `/etc/profile`, `/etc/profile.d/*` → `~/.bash_profile`

打开shell时

`~/.bashrc` → `/etc/bashrc`

退出shell时

`~/.bash_logout`

zsh

`.zshenv` → `[.zprofile if login]` → `[.zshrc if interactive]` → `[.zlogin if login]` → `[.zlogout sometimes]`

