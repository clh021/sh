#!/usr/bin/env bash
# leehom Chen clh021@gmail.com
set -e
linkDestPath="$HOME/.local/bin" # 最终建立可调用链接的目标路径。
binSaveFileSET="$HOME/sdk/VERSION/go.tar.gz" # 不能直接使用的设置，需要替换用户变量来得到实际的值
binSaveFileREAL=""
binSavePathSET="$HOME/sdk/VERSION" # 不能直接使用的设置，需要替换用户变量来得到实际的值
binSavePathREAL=""
switch() {
    ver="$1"
    # if no binPkg, download
    if ! test -f "$binSaveFileREAL"; then
        wget -t 0 -c "https://golang.google.cn/dl/${ver}.linux-amd64.tar.gz" -O "$binSaveFileREAL"
    fi

    # if no binPath, extract
    if ! test -f "$binSavePathREAL/bin/go" ; then
        cd "$binSavePathREAL"
        tar -xvzf "$binSaveFileREAL" --strip-components 1
    fi

    # apply bin
    ln -sf "$binSavePathREAL/bin/go" "$linkDestPath/go"

    # notice
    echo "switch new bash window to use."

    # The latest environment variables cannot be used in the current terminal environment.
    # A new terminal environment must be opened.current terminal env cann't use.
}

ver="$1"
if [ "$ver" == "list" ]; then
    ls "$HOME/sdk/" | grep -v .tar. | grep go
    exit 0
fi
if [[ "$ver" = go* ]]; then
    set -x
    binSavePathREAL=${binSavePathSET/VERSION/$ver}
    binSaveFileREAL=${binSaveFileSET/VERSION/$ver}
    mkdir -p "$binSavePathREAL"
    mkdir -p "$linkDestPath"
    switch "$ver"
    export PATH="$linkDestPath:$PATH"
    go version
else
    baseName=$(basename "$0")
    echo "usage: "
    echo "    ${baseName} list          show installed versions"
    echo "    ${baseName} go1.13.15     switch go1.13.15 version"
    echo "    ${baseName} go1.18.10     switch go1.18.10 version"
    echo "    ${baseName} go1.19.3      switch go1.19.3  version"
    echo "    ${baseName} go1.20.11     switch go1.20.11 version"
    echo "    ${baseName} go1.21.4      switch go1.21.4  version"
    exit 1
fi

