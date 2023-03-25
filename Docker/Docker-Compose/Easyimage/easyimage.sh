#!/bin/bash
name=Easyimage
menuname=Easyimage
port=8080
path="/opt/Docker/Easyimage"
url=https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/Docker-Compose/Easyimage/docker-compose.yml
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
    read -p "$(yellow '请输入映射目录 (默认为 '"$path"'):')" temp_path
	path=${temp_path:-$path}
    echo "127.0.0.1    proxy manager" | sudo tee -a /etc/hosts
    wget -P "$path" "$url"
    cd "$path" && docker-compose up -d
    if [ $? -eq 0 ]; then
      yellow "容器启动成功！"
    else
      red "容器启动失败！"
    fi
}
update() {
    green "================================================="
    red "			注意！！！"
	red "如果是自定义设置的路径："
    red "	更新前请牢记你映射的目录路径，并严格对应输入！"
    red "	如果输入错误，可能将导致设置与数据丢失！"
    red "如果是使用此脚本默认安装："
    red "	则不做任何输入，以保持默认路径，"
    red "	如错误输入，届时与原路径不符，同样丢失数据！"
    green "================================================="
	read -p "$(yellow '请输入映射目录 (默认为 '"$path"'):')" temp_path
	path=${temp_path:-$path}
    cd "$path" && docker-compose down && docker-compose pull && docker-compose up -d
    result=$?
    if [ $result -eq 0 ]; then
      yellow "容器更新成功。"
    else
      red "容器更新失败失败。"
    fi
}
uninstall() {
    green "================================================="
    red "警告：该操作将会删除容器及其数据。"
    green "================================================="
    read -p "$(yellow '请输入映射目录 (默认为 '"$path"'):')" temp_path
    path=${temp_path:-$path}
    read -p "$(yellow '确认要删除目录 '$path' 吗？[y/n] ')" choice
    case "$choice" in
      y|Y )
        cd "$path" && docker-compose down && rm -rf "$path"
        result=$?
        if [ $result -eq 0 ]; then
          yellow "容器删除成功。"
        else
          red "容器删除失败。"
        fi ;;
      * )
        yellow "取消操作。" ;;
    esac
}
menu() {
if ! command -v docker-compose &> /dev/null; then
    red "错误：Docker Compose 未安装，请先安装 Docker Compose。"
    exit 1
fi
green "=================================================================================="
echo "                            "
blue "$menuname一键 Docker 脚本"
red "注意：请先安装Docker Compose在执行本脚本。"
blue "默认账户：admin@example.com---changeme"
blue "映射端口 ：$port"
blue "映射目录：$path"
green "=================================================================================="
yellow " 1. 安装$menuname"
yellow " 2. 更新$menuname"
red " 3. 卸载$menuname"
echo "                            "
yellow " 0. 退出"
green "=================================================================================="
  read -p "$(yellow '请输入数字 [0-3]:')" num
  case "$num" in
    1)
      rm -rf "$0"
      install
      ;;
    2)
      rm -rf "$0"
      update
      ;;
    3)
      rm -rf "$0"
      uninstall
      ;;
    0)
      rm -rf "$0"
      exit 0
      ;;
    *)
      clear
      echo "请输入正确数字 [0-3]"
      sleep 2s
      exit 1
      ;;
  esac
}

menu