#!/bin/bash
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
NC="\033[0m"
if [[ $(id -u) -ne 0 ]]; then
    echo -e "${RED}此脚本必须以root用户身份运行。${NC}"
    exit 1
fi
echo -e "${YELLOW}当前用户列表：${NC}"
cut -d: -f1 /etc/passwd
read -p "请输入要删除的用户名：" username
if [[ -z $username ]]; then
    echo -e "${RED}用户名不能为空。${NC}"
    exit 1
fi
if [[ -x "$(command -v userdel)" ]]; then
    userdel -r $username
else
    deluser --remove-home $username
fi
if [[ $? -eq 0 ]]; then
    echo -e "${GREEN}用户 $username 已成功删除。${NC}"
else
    echo -e "${RED}删除用户 $username 失败。${NC}"
fi
rm -f "$0"