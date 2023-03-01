#!/bin/bash
red(){ echo -e "\033[31m\033[01m$1\033[0m";}
green(){ echo -e "\033[32m\033[01m$1\033[0m";}
yellow(){ echo -e "\033[33m\033[01m$1\033[0m";}
readp(){ read -p "$(yellow "$1")" $2;}
readsp(){ read -s -p "$(yellow "$1")" $2;}
if [ $(id -u) -eq 0 ]; then
	readp "请输入用户名 : " username
	readsp "请输入密码 : " password
	egrep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$username exists!"
		exit 1
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		useradd -m -p $pass $username
		[ $? -eq 0 ] && yellow "用户已添加到系统!" || red "添加用户失败,以下账户无效!"
	fi
green "VPS当前设置的用户名：$username"
green "VPS当前设置的密码：$password"
else
	red "只有 root 可以向系统添加用户!"
	exit 2
fi
rm -f "$0"