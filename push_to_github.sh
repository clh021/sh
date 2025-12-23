#!/bin/bash

# 自动添加 GitHub remote（如果不存在）
if ! git remote | grep -q '^github$'; then
	echo "添加 GitHub remote..."
	git remote add github git@github.com:clh021/sh.git
fi

## 添加所有修改
#git add .
#
## 提示输入 commit 消息
#read -p "请输入 commit 消息: " msg
#if [ -z "$msg" ]; then
#    echo "commit 消息不能为空！"
#    exit 1
#fi
#git commit -m "$msg"

# 推送到 origin (Gitee)
#echo "推送至 Gitee (origin)..."
#git push origin main  # 如果你的主分支是 master，改成 master

# 推送到 github (GitHub)，首次会设置 upstream
echo "推送至 GitHub (github)..."
current_branch=$(git rev-parse --abbrev-ref HEAD)

if git config --get "branch.${current_branch}.remote" >/dev/null 2>&1 &&
	[ "$(git config --get branch.${current_branch}.remote)" = "github" ] &&
	git config --get "branch.${current_branch}.merge" >/dev/null 2>&1; then
	git push github "$current_branch"
else
	git push github "$current_branch" --set-upstream
fi

echo "同步完成！"
