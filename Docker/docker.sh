#!/bin/bash
# By GWen124
# https://github.com/GWen124/Script/tree/master/Linux

ver="20230318"
blog="https://blog.gwen.ink/"
github="https://github.com/GWen124"
changeLog="随缘更新！"
arch=`uname -m`
virt=`systemd-detect-virt`
kernelVer=`uname -r`
TUN=$(cat /dev/net/tun 2>&1 | tr '[:upper:]' '[:lower:]')
REGEX=("debian" "ubuntu" "centos|red hat|kernel|oracle linux|alma|rocky" "'amazon linux'" "alpine")
RELEASE=("Debian" "Ubuntu" "CentOS" "CentOS" "Alpine")
CMD=("$(grep -i pretty_name /etc/os-release 2>/dev/null | cut -d \" -f2)" "$(hostnamectl 2>/dev/null | grep -i system | cut -d : -f2)" "$(lsb_release -sd 2>/dev/null)" "$(grep -i description /etc/lsb-release 2>/dev/null | cut -d \" -f2)" "$(grep . /etc/redhat-release 2>/dev/null)" "$(grep . /etc/issue 2>/dev/null | cut -d \\ -f1 | sed '/^[ ]*$/d')")


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

for i in "${CMD[@]}"; do
    SYS="$i" && [[ -n $SYS ]] && break
done

for ((int=0; int<${#REGEX[@]}; int++)); do
    [[ $(echo "$SYS" | tr '[:upper:]' '[:lower:]') =~ ${REGEX[int]} ]] && SYSTEM="${RELEASE[int]}" && [[ -n $SYSTEM ]] && break
done

[[ -z $SYSTEM ]] && red "不支持VPS的当前系统，请使用主流操作系统" && exit 1

function docker(){
    echo "                            "
	yellow " 1. 安装 Docker"
	yellow " 2. 设置开机自动启动Docker"
	yellow " 3. 安装Docker Compose"
	yellow " 4. 添加Docker Compose可执行权限"
	yellow " 5. 开启容器的 IPv6 功能，以及限制日志文件大小"
	echo "                            "
    red " 0. 返回上级菜单 "
	green "=================================================================================="
    echo
    read -e -p "请输入选项:" dockerNumberInput
    case "$dockerNumberInput" in
		1)
		wget -qO- get.docker.com | bash
		;;
		2)
		systemctl enable docker
		;;
		3)
		sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
		;;
		4)
		sudo chmod +x /usr/local/bin/docker-compose
		;;
		5)
		cat > /etc/docker/daemon.json <<EOF
{
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "20m",
        "max-file": "3"
    },
    "ipv6": true,
    "fixed-cidr-v6": "fd00:dead:beef:c0::/80",
    "experimental":true,
    "ip6tables":true
}
EOF
systemctl restart docker
		;; 
        0 ) menu
		;;
		*)
		echo "请输入正确数字。 "
    esac
}

function nginxpm(){
bash -c "$(curl -fsSL  https://raw.githubusercontent.com/GWen124/Script/master/Docker/Docker-Compose/nginx-proxy-manager.sh)"
}

function watchtower(){
bash -c "$(curl -fsSL  https://raw.githubusercontent.com/GWen124/Script/master/Docker/watchtowersh)"
}

function syncthing(){
bash -c "$(curl -fsSL  https://raw.githubusercontent.com/GWen124/Script/master/Docker/syncthing.sh)"
}

function alistdocker(){
bash -c "$(curl -fsSL  https://raw.githubusercontent.com/GWen124/Script/master/Docker/alist.sh)"
}

function qinglong(){
bash -c "$(curl -fsSL  https://raw.githubusercontent.com/GWen124/Script/master/Docker/qinglong.sh)"
}

function easyimage(){
bash -c "$(curl -fsSL  https://raw.githubusercontent.com/GWen124/Script/master/Docker/easyimage.sh)"
}

function odocker(){
    echo "                            "
	yellow " 1. Qiandao-Today-Docker"
	yellow " 2. 肥羊IPTV-Docker"
	yellow " 3. Freenom自动续期-Docker"
	yellow " 4. Hale Blog-Docker"
	yellow " 5. Reader小说阅读站-Docker"
	yellow " 6. Calibre-Web电子书-Docker"
	yellow " 7. OneNav导航-Docker"
	yellow " 8. V2P面板-Docker"
	yellow " 9. 待定"
	echo "                            "
    red " 0. 返回上级菜单 "
	green "=================================================================================="
    echo
    read -e -p "请输入选项:" odockerNumberInput
    case "$odockerNumberInput" in
		1)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Docker/qiandao.sh)"
		;;
		2)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Docker/feiyangiptv.sh)"
		;;
		3)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Docker/freenom.sh)"
		;;
		4)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Docker/halo.sh)"
		;;
		5)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Docker/reader.sh)"
		;;
		6)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Docker/calibre-web.sh)"
		;;
		7)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Docker/onenav.sh)"
		;;
		8)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Docker/v2p.sh)"
		;;
		9)
		bash -c "$(curl -fsSL https://gwen124.ml/tools.sh)"
		;;		
        0 ) menu
		;;
		*)
		echo "请输入正确数字。 "
    esac
}

function compose(){
    echo "                            "
	yellow " 1. Easyimage图床-Docker-Compose"
	yellow " 2. YOURLS短连接-Docker-Compose"
	yellow " 3. Reader小说阅读站-Docker-Compose"
	yellow " 4. Wiki.js-Docker-Compose"
	yellow " 5. Calibre Web-Docker-Compose"
	yellow " 6. 待定"
	yellow " 7. 待定"
	yellow " 8. 待定"
	yellow " 9. 待定"
	echo "                            "
    red " 0. 返回上级菜单 "
	green "=================================================================================="
    echo
    read -e -p "请输入选项:" composeNumberInput
    case "$composeNumberInput" in
		1)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Docker/Docker-Compose/Easyimage/easyimage.sh)"
		;;
		2)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Docker/Docker-Compose/YOURLS/yourls.sh)"
		;;
		3)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Docker/Docker-Compose/Reader/reader.sh)"
		;;
		4)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Docker/Docker-Compose/WikiJS/wikijs.sh)"
		;;
		5)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Docker/Docker-Compose/calibre.sh)"
		;;
		6)
		bash -c "$(curl -fsSL https://gwen124.ml/tools.sh)"
		;;
		7)
		bash -c "$(curl -fsSL https://gwen124.ml/tools.sh)"
		;;
		8)
		bash -c "$(curl -fsSL https://gwen124.ml/tools.sh)"
		;;
		9)
		bash -c "$(curl -fsSL https://gwen124.ml/tools.sh)"
		;;		
        0 ) exic
		;;
		*)
		echo "请输入正确数字。 "
    esac
}

function menu(){
    echo "                            "
	red "说明 ：此类目为Docker容器项目文件，请安装Docker&Docker Compose后使用"
	blue "所有容器路径都映射于：/opt/Docker文件夹内 "
	echo "                            "
    green "请选择你接下来使用的脚本："
    echo "                            "
	yellow "1. 安装Docker&Docker Compose"
    yellow "2. Nginx Proxy Manager-Docker Compose"
    yellow "3. Watchtower-Docker"
    yellow "4. Syncthing-Docker"
	yellow "5. Alist-Docker"
	yellow "6. QingLong-Docker"
    yellow "7. Easyimage-Docker"
    yellow "8. 其他Docker项目"
	yellow "9. 其他Docker Compose项目"
    echo "                            "
    red "0. 返回主菜单"
	green "=================================================================================="
    read -e -p "请输入选项:" page4NumberInput
    case "$page4NumberInput" in
		1 ) docker ;;
        2 ) nginxpm ;;
        3 ) watchtower ;;
        4 ) syncthing ;;
		5 ) alistdocker ;;
		6 ) qinglong ;;
        7 ) easyimage ;;
        8 ) odocker ;;
		9 ) compose ;;
        0 ) exit 0;;
		 *) echo "请输入正确数字。 "
    esac
}
menu