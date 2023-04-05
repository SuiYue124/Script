#!/bin/bash
#ChatGPT一键安装脚本
#我的仓库：https://github.com/GWen124
name="ChatGPT-WEB"
menuname="ChatGPT WEB"
port="3030"
apikey="12345678"
webkey="password"
path="/opt/Docker/ChatGPT"
yml="docker-compose.yml"
image="chenzhaoyu94/chatgpt-web"
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
    if ! command -v docker &> /dev/null; then
        red "错误：Docker 未安装，请先安装 Docker。"
        echo "请按照以下指引安装 Docker:"
        echo "https://docs.docker.com/get-docker/"
        echo "如需一键安装，请打开下面连接使用我的一键脚本集合:"
        echo "https://wen124.ml/FSWKKD"
        exit 1
    fi
    if ! command -v docker-compose &> /dev/null; then
        red "错误：Docker Compose 未安装，请先安装 Docker Compose。"
        echo "请按照以下指引安装 Docker Compose:"
        echo "https://docs.docker.com/compose/install/"
        echo "如需一键安装，请打开下面连接使用我的一键脚本集合:"
        echo "https://wen124.ml/FSWKKD"
        exit 1
    fi
    while true; do
        read -r -p "$(yellow '请输入你的端口号(默认为'"$port"')：')" port_input
        if [ -n "$port_input" ]; then
            if ! [[ "$port_input" =~ ^[0-9]+$ ]] || [ "$port_input" -lt 1 ] || [ "$port_input" -gt 65535 ]; then
                echo "输入的端口号无效，请输入一个 1-65535 的整数或者Ctrl+C。"
                continue
            fi
            port="$port_input"
        fi
        read -r -p "$(yellow '请输入你的OpenAI API Key：')" apikey_input
        if [ -n "$apikey_input" ]; then
            continue
            apikey="apikey_input"
        fi
        read -r -p "$(yellow '请输入你的WEB Key：')" webkey_input
        if [ -n "$webkey_input" ]; then
            continue
            apikey="webkey_input"
        fi
        yellow "你确定输入的端口、OpenAI API Key和WEB Key正确吗?"
        read -p "继续安装容器(Y)，请重新输入端口号和OpenAI API Key(N)，退出脚本(R):" confirm
        case "$confirm" in
            y|Y ) break;;
            n|N ) continue;;
            r|R ) exit 1;;
            * ) yellow "请输入 Y 或 N 或 R或者Ctrl+C。";;
        esac
    done
    echo "127.0.0.1    proxy manager" | sudo tee -a /etc/hosts
    mkdir -p "$path"
    echo "
version: '3'

services:
  app:
    image: "$image" # 总是使用 latest ,更新时重新 pull 该 tag 镜像即可
    ports:
      - 127.0.0.1:"$port":3002
    environment:
      # 二选一
      OPENAI_API_KEY: "$apikey"
      # 二选一
      OPENAI_ACCESS_TOKEN: xxx
      # API接口地址，可选，设置 OPENAI_API_KEY 时可用
      OPENAI_API_BASE_URL: https://api.openai.com
      # 访问权限密钥，可选
      AUTH_SECRET_KEY: "$webkey"
      # 每小时最大请求次数，可选，默认无限
      MAX_REQUEST_PER_HOUR: 0
      # 超时，单位毫秒，可选
      TIMEOUT_MS: 60000
	  container_name: "$name"
    " > "$path/$yml"
    cd "$path" && docker-compose up -d
    if [ $? -eq 0 ]; then
        yellow "容器启动成功！"
    else
        red "容器启动失败！"
    fi
}
update() {
    if ! command -v docker &> /dev/null; then
        red "错误：Docker 未安装，请先安装 Docker。"
        echo "请按照以下指引安装 Docker:"
        echo "https://docs.docker.com/get-docker/"
		echo "如需一键安装，请打开下面连接使用我的一键脚本集合:"
        echo "https://wen124.ml/FSWKKD"
        exit 1
    fi
    if ! command -v docker-compose &> /dev/null; then
        red "错误：Docker Compose 未安装，请先安装 Docker Compose。"
        echo "请按照以下指引安装 Docker Compose:"
        echo "https://docs.docker.com/compose/install/"
		echo "如需一键安装，请打开下面连接使用我的一键脚本集合:"
        echo "https://wen124.ml/FSWKKD"
        exit 1
    fi
    green "================================================="
    red "		注意！！！"
	red "1.如果是自定义设置的路径："
    red "  更新前请牢记你映射的目录路径，并严格对应输入！"
    red "  如果输入错误，可能将导致设置与数据丢失！"
    red "2.如果是使用此脚本默认安装："
    red "  则不做任何输入，以保持默认路径，"
    red "  如错误输入，届时与原路径不符，同样丢失数据！"
    green "================================================="
	read -p "$(yellow '请输入原映射目录 (默认为 '"$path"'):')" temp_path
	path=${temp_path:-$path}
    cd "$path" && docker-compose down && docker-compose pull && docker-compose up -d
    result=$?
    if [ $result -eq 0 ]; then
      yellow "容器已更新完成，端口号为 $port，数据目录为 $path"
    else
      red "容器更新失败失败。"
    fi
}
uninstall() {
    if ! command -v docker &> /dev/null; then
        red "错误：Docker 未安装，请先安装 Docker。"
        echo "请按照以下指引安装 Docker:"
        echo "https://docs.docker.com/get-docker/"
		echo "如需一键安装，请打开下面连接使用我的一键脚本集合:"
        echo "https://wen124.ml/FSWKKD"
        exit 1
    fi
    if ! command -v docker-compose &> /dev/null; then
        red "错误：Docker Compose 未安装，请先安装 Docker Compose。"
        echo "请按照以下指引安装 Docker Compose:"
        echo "https://docs.docker.com/compose/install/"
		echo "如需一键安装，请打开下面连接使用我的一键脚本集合:"
        echo "https://wen124.ml/FSWKKD"
        exit 1
    fi
    green "================================================="
    red "警告：该操作将会删除容器及其数据。"
    green "================================================="
    read -p "$(yellow '请输入映射目录 (默认为 '"$path"'):')" temp_path
    path=${temp_path:-$path}
    read -p "$(yellow '确认要删除容器吗？[y/n] ')" choice
    case "$choice" in
        y|Y )
            cd "$path" && docker-compose down && rm -rf $yml
            yellow "容器删除成功。"
            ;;
        * )
            exit 1
			yellow "取消操作。"
            ;;
    esac
    read -p "$(yellow '确认要删除目录 '$path' 吗？[y/n] ')" choice
    case "$choice" in
        y|Y )
            rm -rf "$path"
            yellow "目录删除成功。"
            ;;
        * )
			exit 1
            yellow "取消操作。"
            ;;
    esac
}
menu() {
  while true; do
    clear
    green "================================================="
    yellow " $menuname一键 Docker 脚本"
    yellow " 请提前准备好你的OpenAI API Key"
    yellow " 默认端口：$port"
    yellow " 默认WEB Key：$webkey"
    green "================================================="
    blue "  1. 安装并启动容器"
    blue "  2. 更新容器"
    blue "  3. 卸载容器"
    blue "  0. 退出脚本"
    green "================================================="
    read -e -p "$(yellow '请输入数字 [0-3]:')" num
    case "$num" in
      1)
        rm -rf "$0"
        install
        break
        ;;
      2)
        rm -rf "$0"
        update
        break
        ;;
      3)
        rm -rf "$0"
        uninstall
        break
        ;;
      0)
        rm -rf "$0"
        exit 0
        ;;
      *)
        continue
        ;;
    esac
  done
}

menu