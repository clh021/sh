#!/bin/bash
#wget https://gitee.com/clh21/sh/raw/master/t.sh


ceprei ceprei1 ceprei@123 uosuos Uosuos123
| cpu       | os       | arch     | id        | key    | pwd | glibc  | buildin | child |
| --------- | -------- | -------- | --------- | ------ | --- | ------ | ------- | ----- |
| 华为麒麟   | kylinV10 |          | 954927413 |        |     |        |         |       |
| 华为麒麟   | uos      |          |           |        |     |        |         |       |
| loongArch | uos      | loong64  | 454092710 | c      |  c  |        |         |       |
| 兆芯       | uos      | amd64    | 442229937 | c2     |     |        |         |       |
| 海芯       | uos      | amd64    | 411133862 | c      |     |        |         |       |
| 飞腾       | uos      | arm64    |           | c      |  u  |        |         |       |
| 飞腾       | kylinV10 | arm64    | 117396102 | c      |  c@ | 2.29   |         |       |
| 鲲鹏       | uos      | arm64    | 341567454 | c      |  c1 | 2.28   | arm64   |       |
| 龙芯       | uos      | mips64le | 126601258 | c      |  c  | 2.28   |         |       |


if [ -f "ui-detect/README.md" ]; then
    pushd ui-detect > /dev/null
    git pull
    popd > /dev/null
else
    git clone --depth=1 https://clh21@gitee.com/perfbenchmark/ui-detect.git
fi

git config user.email "clh021@gmail.com"
git config user.name "chenlianghong"

export GO111MODULE=on
export GOPROXY=https://goproxy.cn

echo export GO111MODULE=on
echo export GOPROXY=https://goproxy.cn

pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/
pip3 install reportlab
pip3 install PyPDF2
pip3 install pyinstaller

echo pyinstaller -F report.py
echo ~/.local/bin/pyinstaller -F report.py

# go get github.com/yudai/gotty
go get github.com/sorenisanerd/gotty
echo go get github.com/yudai/gotty
echo go get github.com/sorenisanerd/gotty
