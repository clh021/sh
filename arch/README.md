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


## After intall for init

```bash
./init.system.sh
```

请注意设置部分机器的禁止休眠和通电开机

字体设置，整体使用 `Noto Sans CJK SC`

终端透明度 39%
configure yakuake Skin: transparent tabs
