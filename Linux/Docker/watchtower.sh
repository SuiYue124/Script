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
yellow "  Watchtower一键Docker脚本"
yellow "  映射目录：/home/Docker/Watchtower"
green "================================================="
blue " 1. 安装并启动容器"
blue " 2. 更新容器"
blue " 3. 卸载容器并同时删除数据"
blue " 0. 退出脚本"
green "================================================="
read -p "请输入数字 [0-3]: " opt
case $opt in
    1)
        blue "开始安装并启动容器..."
        docker run -d \
            --restart=unless-stopped \
            -v /var/run/docker.sock:/var/run/docker.sock \
            --name="Watchtower" \
            containrrr/watchtower -c --schedule "0 0 2 * * *"
        green "容器已安装并启动。"
        ;;
    2)
        blue "开始更新容器..."
        docker pull containrrr/watchtower
        docker stop Watchtower
        docker rm Watchtower
        docker run -d \
            --restart=unless-stopped \
            -v /var/run/docker.sock:/var/run/docker.sock \
            --name="Watchtower" \
            containrrr/watchtower -c --schedule "0 0 2 * * *"
        green "容器已更新。"
        ;;
    3)
        yellow "警告：该操作将会删除容器及其数据。"
        read -p "请再次确认是否执行该操作 [y/n]: " confirm
        if [ "$confirm" == "y" ]; then
            blue "开始卸载容器并删除数据..."
            docker stop Watchtower
            docker rm -f Watchtower
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
