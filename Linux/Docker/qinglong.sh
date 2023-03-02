#!/bin/bash
blue() {
    echo -e "\033[34m\033[01m$1\033[0m"
}
green() {
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow() {
    echo -e "\033[33m\033[01m$1\033[0m"
}
red() {
    echo -e "\033[31m\033[01m$1\033[0m"
}
install() {
    if [ ! -d "/home/Docker/QingLong" ]; then
        mkdir -p /home/Docker/QingLong
    fi
    green "请输入映射端口号(默认为15700)："
    read port
    if [ -z "$port" ]; then
        port=15700
    fi
    green "请输入数据目录(默认为/home/Docker/QingLong)："
    read path
    if [ -z "$path" ]; then
        path="/home/Docker/QingLong"
    fi
    docker run -dit --name QingLong \
        -v $path:/ql/data \
        -p $port:5700 \
        --hostname qinglong \
        --restart unless-stopped \
        whyour/qinglong:latest
    green "容器已启动，端口号为 $port，数据目录为 $path"
}
update() {
    docker pull whyour/qinglong:latest
    docker stop QingLong && docker rm QingLong
    install
    green "容器已更新完成"
}
uninstall() {
    docker stop QingLong && docker rm QingLong
    green "容器已卸载"
    green "请输入Y或y确认删除数据目录："
    read confirm
    if [ "$confirm" = "Y" -o "$confirm" = "y" ]; then
        rm -rf /home/Docker/QingLong
        green "数据目录已删除"
    fi
}
menu() {
    green "================================================="
    yellow "  青龙一键Docker脚本"
	yellow "  默认端口：15700"
	yellow " 默认路径：/home/Docker/QingLong"
    green "================================================="
    blue " 1. 安装并启动容器"
    blue " 2. 更新容器"
    blue " 3. 卸载容器"
    blue " 0. 退出脚本"
    green "================================================="
    read -p "请输入数字 [0-3]: " num
    case "$num" in
        1)
            install
            ;;
        2)
            update
            ;;
        3)
            uninstall
            ;;
        0)
			rm -rf "$0"
            exit 0
            ;;
        *)
            clear
            red "请输入正确数字 [0-3]"
            sleep 2s
            menu
            ;;
    esac
}

menu
