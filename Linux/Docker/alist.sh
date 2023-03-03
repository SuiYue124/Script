#!/bin/bash
function blue(){
    echo -e "\033[34m$1\033[0m"
}
function green(){
    echo -e "\033[32m$1\033[0m"
}
function yellow(){
    echo -e "\033[33m$1\033[0m"
}
function red(){
    echo -e "\033[31m$1\033[0m"
}
green "================================================="
yellow "  Alist一键Docker脚本"
yellow "  映射端口：5255"
yellow "  映射目录：/opt/Docker/Alist"
yellow "  默认账户密码：docker exec -it Alist ./alist password"
green "================================================="
blue " 1. 安装并启动容器"
blue " 2. 查看默认账户密码"
blue " 3. 更新容器"
blue " 4. 卸载容器并同时删除数据"
blue " 0. 退出脚本"
green "================================================="
read -p "请输入数字 [0-3]: " opt
case $opt in
    1)
	 green "请输入映射端口号(默认为5255)："
    read port
    if [ -z "$port" ]; then
        port=5255
    fi
    green "请输入数据目录(默认为/opt/Docker/Alist)："
    read path
    if [ -z "$path" ]; then
        path="/opt/Docker/Alist"
    fi
        blue "开始安装并启动容器..."
        docker run -d \
            --restart=always \
            -v $path:/opt/alist/data \
            -p $port:5244 \
            -e PUID=0 \
            -e PGID=0 \
            -e UMASK=022 \
            --name="Alist" \
            xhofe/alist:latest
        green "容器已安装并启动。"
        ;;
	2)
		docker exec -it Alist ./alist password
		;;
    3)
        blue "开始更新容器..."
        docker pull xhofe/alist:latest
        docker stop Alist
        docker rm Alist
        docker run -d \
            --restart=always \
            -v /opt/Docker/Alist:/opt/alist/data \
            -p 5255:5244 \
            -e PUID=0 \
            -e PGID=0 \
            -e UMASK=022 \
            --name="Alist" \
            xhofe/alist:latest
        green "容器已更新。"
        ;;
    4)
        yellow "警告：该操作将会删除容器及其数据。"
        read -p "请再次确认是否执行该操作 [y/n]: " confirm
        if [ "$confirm" == "y" ]; then
            blue "开始卸载容器并删除数据..."
            docker stop Alist
            docker rm -f Alist
            rm -rf /opt/Docker/Alist
            green "容器已卸载并数据已删除。"
        else
            yellow "操作已取消。"
        fi
        ;;
    *)
        red "无效的操作类型。"
        ;;
esac

rm -f $0
