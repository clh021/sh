#!/bin/bash
git clone --depth=1 https://clh21@gitee.com/perfbenchmark/ui-detect.git
export GO111MODULE=on
export GOPROXY=https://goproxy.cn

echo export GO111MODULE=on
echo export GOPROXY=https://goproxy.cn

pip3 install reportlab
pip3 install PyPDF2
pip3 install pyinstaller

echo pyinstaller -F report.py
echo ~/.local/bin/pyinstaller -F report.py