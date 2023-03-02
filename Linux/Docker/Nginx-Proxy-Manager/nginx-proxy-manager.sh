#!/bin/bash
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green "=================================================================================="
echo "                            "
red "注意：请先安装Docker Compose在执行本脚本。"
blue "控制端端口 ：81"
blue "默认账户：admin@example.com---changeme"
blue "映射目录：/home/Docker/Nginx-Proxy-Manager"
echo "                            "
yellow " 1. 安装Nginx Proxy Manager"
yellow " 2. 更新Nginx Proxy Manager"
red " 3. 卸载Nginx Proxy Manager"
echo "                            "
red " 0. 退出"
green "=================================================================================="
echo
read -p "请输入选项:" nginxpmNumberInput
case "$nginxpmNumberInput" in
	1)
	echo "127.0.0.1    proxy manager" | sudo tee -a /etc/hosts
	mkdir -p /home/Docker/Nginx-Proxy-Manager
	wget -P /home/Docker/Nginx-Proxy-Manager https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/Nginx-Proxy-Manager/docker-compose.yml
	cd /home/Docker/Nginx-Proxy-Manager && docker-compose up -d
	if [ $? -eq 0 ]; then
		yellow "容器启动成功！"
	else
		red "容器启动失败！"
	fi
	;;
	2)
	cd /home/Docker/Nginx-Proxy-Manager && docker-compose down && docker-compose pull && docker-compose up -d
	result=$?
if [ $result -eq 0 ]; then
    yellow "容器更新成功。"
else
    red "容器更新失败失败。："
fi
	;;
	3)
	cd /home/Docker/Nginx-Proxy-Manager && docker-compose down && rm -rf /home/Docker/Nginx-Proxy-Manager
	result=$?
if [ $result -eq 0 ]; then
    yellow "容器删除成功。"
else
    red "容器删除失败。"
fi
	;;
	0 ) exit
esac
rm -rf $0