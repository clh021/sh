#!/usr/bin/env bash
###############################
# 配置示例
# #developer.conf
# # 多系统自动添加到引导目录
# os-prober
# # 网络管理
# networkmanager
# # 抓包工具
# wireshark-qt
# # 使用 yay 安装的软件包
# yay:visual-studio-code-bin
# yay:spotify
###############################

# 获取当前目录
current_dir=$(pwd)

# 查找当前目录中以 .conf 后缀结尾的配置文件
configs=()
while IFS= read -r -d '' file; do
  if [[ $file =~ \.conf$ ]]; then
    configs+=("$file")
  fi
done < <(find "$current_dir" -maxdepth 1 -type f -print0)

# 检查是否找到配置文件
if [ ${#configs[@]} -eq 0 ]; then
  echo "当前目录中没有找到以 .conf 后缀结尾的配置文件！"
  exit 1
fi

# 显示可用的配置文件列表供用户选择
echo "可用的配置文件："
for ((i=0; i<${#configs[@]}; i++)); do
  config="${configs[$i]}"
  config_name=$(basename "$config" .conf)
  echo "$(($i+1)). $config_name"
done

# 选择配置文件
read -p "请选择配置文件的序号： " choice_index
choice_index=$((choice_index-1))

# 检查选择序号的有效性
if ((choice_index < 0 || choice_index >= ${#configs[@]})); then
  echo "无效的选择序号！"
  exit 1
fi

# 获取选择的配置文件路径
config_file="${configs[$choice_index]}"

# 读取配置文件中的软件包列表
pkgs=()
while IFS= read -r line; do
  if [[ $line != "#"* ]]; then
    if [[ $line == "yay:"* ]]; then
      pkg=$(echo "$line" | cut -d':' -f2-)
      pkgs+=("yay:$pkg")
    else
      pkgs+=("$line")
    fi
  fi
done < "$config_file"

# 显示待安装的软件包列表并确认
echo "以下软件包将被安装："
for pkg in "${pkgs[@]}"; do
  echo "$pkg"
done
read -p "是否继续安装？（Y/N）: " choice

# 确认安装操作
if [[ $choice == "Y" || $choice == "y" ]]; then
  # 安装 pacman 软件包
  pacman_pkgs=()
  yay_pkgs=()
  for pkg in "${pkgs[@]}"; do
    if [[ $pkg == "yay:"* ]]; then
      yay_pkg=$(echo "$pkg" | cut -d':' -f2-)
      yay_pkgs+=("$yay_pkg")
    else
      pacman_pkgs+=("$pkg")
    fi
  done

  if [ ${#pacman_pkgs[@]} -gt 0 ]; then
    sudo pacman -Sy --needed "${pacman_pkgs[@]}" --noconfirm
  fi

  if [ ${#yay_pkgs[@]} -gt 0 ]; then
    yay -Sy --needed "${yay_pkgs[@]}" --noconfirm
  fi

  echo "软件包安装完成。"
else
  echo "安装操作已取消。"
fi
