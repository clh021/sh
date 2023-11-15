# archinstall-config
My archinstall config

## Usage

Once booted on archiso, run:

```bash
pacman -Sy git make
git clone --depth=1 https://gitee.com/clh21/sh
cd sh/arch
make install
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
