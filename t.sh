#!/bin/bash
#wget https://gitee.com/clh21/sh/raw/master/t.sh


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

pip3 install reportlab
pip3 install PyPDF2
pip3 install pyinstaller

echo pyinstaller -F report.py
echo ~/.local/bin/pyinstaller -F report.py

# go get github.com/yudai/gotty
go get github.com/sorenisanerd/gotty
echo go get github.com/yudai/gotty
echo go get github.com/sorenisanerd/gotty