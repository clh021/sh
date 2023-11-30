# archinstall-config
My archinstall config

## Usage

Once booted on archiso, run:

```bash
pacman -Sy git make
git clone --depth=1 https://gitee.com/clh21/sh
cd sh/arch
make install

iwctl --passphrase ${wifi_pwd} station ${device_name} connect ${wifi_name}
# iwctl                                    #执行iwctl命令，进入交互式命令行
# device list                              #列出设备名，比如无线网卡看到叫 wlan0
# station wlan0 scan                       #扫描网络
# station wlan0 get-networks               #列出网络 比如想连接YOUR-WIRELESS-NAME这个无线
# station wlan0 connect YOUR-WIRELESS-NAME #进行连接 输入密码即可
# exit                                     #成功后exit退出

./getChinaMirror.sh # 自动选择好国内加速镜像
```

## How Get Custom

运行后可修改选项，然后保存即可得到配置文件
```bash
archinstall --dry-run
```

## After intall for Yay
Get yay pkg from https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/x86_64/
```bash
sudo pacman -U ./yay-***-x86_64.pkg.tar.zst
yay -S google-chrome
```
> 注意: archlinux 配置文件中自动安装 yay 后，无法安装google-chrome，是因为 systemd，可以在进入桌面后安装
