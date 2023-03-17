#!/bin/bash

# 检查是否为root用户
if [[ $EUID -ne 0 ]]; then
    echo "错误：需要使用 root 用户运行此脚本" >&2
    exit 1
fi

# 检查操作系统类型，获取SSH配置文件路径
if [ -f "/etc/ssh/sshd_config" ]; then
    sshd_config_path="/etc/ssh/sshd_config"
elif [ -f "/etc/sshd_config" ]; then
    sshd_config_path="/etc/sshd_config"
else
    echo "错误：无法找到 SSH 配置文件" >&2
    exit 1
fi

# 设置 SSH 保活选项
if grep -q "^\s*.*ClientAliveInterval\s\w+.*$" "$sshd_config_path"; then
    sed -ri "s/^\s*.*ClientAliveInterval\s\w+.*$/ClientAliveInterval 60/" "$sshd_config_path"
else
    echo "ClientAliveInterval 60" >> "$sshd_config_path"
fi

if grep -q "^\s*.*ClientAliveCountMax\s\w+.*$" "$sshd_config_path"; then
    sed -ri "s/^\s*.*ClientAliveCountMax\s\w+.*$/ClientAliveCountMax 30/" "$sshd_config_path"
else
    echo "ClientAliveCountMax 30" >> "$sshd_config_path"
fi

# 设置颜色变量
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # 恢复默认颜色

# 输出带颜色的提示消息
echo -e "${GREEN}SSH保活设置已成功更新${NC}"
