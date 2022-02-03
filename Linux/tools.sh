#!/bin/bash
# By GWen124
# https://github.com/GWen124/Script/tree/master/Linux

ver="202202"
changeLog=""
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

# [[ $(id -u) != 0 ]] && red "请使用“sudo -i”登录root用户后执行本脚本！！！" && exit 1


for i in "${CMD[@]}"; do
    SYS="$i" && [[ -n $SYS ]] && break
done

for ((int=0; int<${#REGEX[@]}; int++)); do
    [[ $(echo "$SYS" | tr '[:upper:]' '[:lower:]') =~ ${REGEX[int]} ]] && SYSTEM="${RELEASE[int]}" && [[ -n $SYSTEM ]] && break
done

[[ -z $SYSTEM ]] && red "不支持VPS的当前系统，请使用主流操作系统" && exit 1


if [[ -f /etc/redhat-release ]]; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
    systemPackage="apt-get"
    systempwd="/lib/systemd/system/"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
    systemPackage="yum"
    systempwd="/usr/lib/systemd/system/"
fi
$systemPackage update -y
$systemPackage upgrade -y
$systemPackage -y install wget curl htop nano python3 python3-pip

IP4=$(curl -s4m2 https://ip.gs/json)
IP6=$(curl -s6m2 https://ip.gs/json)
WAN4=$(expr "$IP4" : '.*ip\":\"\([^"]*\).*')
WAN6=$(expr "$IP6" : '.*ip\":\"\([^"]*\).*')
COUNTRY4=$(expr "$IP4" : '.*country\":\"\([^"]*\).*')
COUNTRY6=$(expr "$IP6" : '.*country\":\"\([^"]*\).*')
ASNORG4=$(expr "$IP4" : '.*asn_org\":\"\([^"]*\).*')
ASNORG6=$(expr "$IP6" : '.*asn_org\":\"\([^"]*\).*')

IP4="$WAN4 （$COUNTRY4 $ASNORG4）"
IP6="$WAN6 （$COUNTRY6 $ASNORG6）"
if [ -z $WAN4 ]; then
    IP4="当前VPS未检测到IPv4地址"
fi
if [ -z $WAN6 ]; then
    IP6="当前VPS未检测到IPv6地址"
fi

#page1
function vpsopen(){
  bash <(curl -sSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/open.sh)
}

function swap(){
  bash <(curl -sSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/swap.sh)
}

function ssh_port(){
  bash <(curl -sSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/ssh_port.sh)
}

function vps_bbr1(){
   wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
}

function vps_bbr2(){
  wget -N --no-check-certificate "https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
}

function vps_openvz(){
  wget --no-cache -O lkl-haproxy.sh https://github.com/mzz2017/lkl-haproxy/raw/master/lkl-haproxy.sh && bash lkl-haproxy.sh
}

#page2
function bench(){
  wget -qO- bench.sh | bash
}

function server-test(){
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/server-test.sh)"
}

function gfw_push(){
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/gfw_push.sh)"
}

function unlock(){
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/unlock.sh)"
}

#page3
function baota(){
    curl -sSO http://download.bt.cn/install/install_panel.sh && bash install_panel.sh
}

function baota7(){
   wget https://raw.githubusercontent.com/GWen124/Script/master/Linux/LinuxPanel-7.7.0.zip && unzip LinuxPanel-7.7.0.zip && cd /root/panel && bash update.sh
}

function baotap(){
    echo "{\"uid\":1000,\"username\":\"admin\",\"serverid\":1}" > /www/server/panel/data/userInfo.json
}

function nezha(){
  curl -L https://raw.githubusercontent.com/naiba/nezha/master/script/install.sh  -o nezha.sh && chmod +x nezha.sh
sudo ./nezha.sh
}

function alist(){
  curl -fsSL "https://raw.githubusercontent.com/GWen124/Script/master/Linux/alist.sh" | bash -s install
}

#page4
function xui(){
    bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
}

function trojanui(){
    bash <(curl -Ls https://raw.githubusercontent.com/GWen124/Script/master/Linux/trojan-install.sh)
}

function xray(){
    bash <(curl -sL https://raw.githubusercontent.com/GWen124/Script/master/Linux/xray.sh)
}

function v2ray(){
    bash <(curl -s -L https://git.io/v2ray.sh)
}

function telegram(){
    bash <(wget -qO- https://git.io/mtg.sh)
}

#page5
function openwrt(){
  bash <(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/openwrt-local.sh)
}

function frps(){
  wget https://raw.githubusercontent.com/MvsCode/frps-onekey/master/install-frps.sh -O ./install-frps.sh && chmod 700 ./install-frps.sh && ./install-frps.sh install
}

function rclone(){
  curl https://rclone.org/install.sh | sudo bash
}

function gost(){
  curl -fsSL "https://raw.githubusercontent.com/KANIKIG/Multi-EasyGost/master/gost.sh" | bash -s install
}

 function menu(){
    clear
	green "=============================================================="
    echo "                           "
    blue " 当前工具箱版本：v$ver "
    yellow " 更新日志：$changeLog"
    echo "                           "
    green "=============================================================="
    red "检测到VPS信息如下："
    yellow "处理器架构：$arch"
    yellow "虚拟化架构：$virt"
    yellow "操作系统：$CMD"
    yellow "内核版本：$kernelVer"
    yellow "IPv4地址：$IP4"
    yellow "IPv6地址：$IP6"
    green "=============================================================="
    echo "                            "
    red "请选择你接下来的操作"
    echo "                            "
    echo "1. 系统相关"
    echo "2. VPS检测"
    echo "3. 面板相关"
    echo "4. 科学上网"
    echo "5. 其他工具"
    echo "                            "
    echo "0. 退出脚本"
    echo "                            "
    green "=============================================================="
    blue " 本脚本理论支持：CentOS7+ / Debian9+ / Ubuntu16.04+"
    blue " 此脚本源于网络，仅仅只是汇聚脚本功能，方便大家使用而已！"
	blue " 我的仓库：https://github.com/GWen124 "
	green "=============================================================="
    read -p "请输入选项:" menuNumberInput
    case "$menuNumberInput" in
        1 ) page1 ;;
        2 ) page2 ;;
        3 ) page3 ;;
        4 ) page4 ;;
        5 ) page5 ;;
        0 ) exit 0
    esac
}

function page1(){
	echo "                            "
    green "请选择你接下来的操作"
    echo "                            "
    echo "1. VPS开机大礼包（请设置好ROOT密码后运行）"
    echo "2. 虚拟内存SWAP一键脚本 "
    echo "3. 更改SSH端口"
    echo "4. BBR一键加速（稳定版）"
    echo "5. BBR一键加速（最新版）"
    echo "6. openvz BBR一键加速"
    echo "                            "
    echo "0. 返回主菜单"
    read -p "请输入选项:" page1NumberInput
    case "$page1NumberInput" in
        1 ) vpsopen ;;
        2 ) swap ;;
        3 ) ssh_port ;;
        4 ) vps_bbr1 ;;
        5 ) vps_bbr2 ;;
        6 ) vps_openvz ;;
        0 ) menu
    esac
}

function page2(){
    echo "                            "
    green "请选择你准备安装的面板"
    echo "                            "
    echo "1. Bench：查看系统信息，测试本地到世界主要机房速度及硬盘读写速率"
    echo "2. VPS 回程路由、路由跟踪测试"
    echo "3. 监测IP是否被墙并推送消息至Telegram "
    echo "4. 流媒体解锁检测"
    echo "                            "
    echo "0. 返回主菜单"
    read -p "请输入选项:" page2NumberInput
    case "$page2NumberInput" in
        1 ) bench ;;
        2 ) server-test ;;
        3 ) gfw_push ;;
        4 ) unlock ;;
        0 ) menu
    esac
}

function page3(){
    echo "                            "
    green "请选择你接下来使用的脚本"
    echo "                            "
    echo "1. 宝塔面板一键官方脚本"
    echo "2. 宝塔面板降级到v7.7"
    echo "3. 宝塔面板无需手机登陆"
    echo "4. 哪吒面板"
    echo "5. Alist一键安装脚本"
    echo "                            "
    echo "0. 返回主菜单"
    read -p "请输入选项:" page3NumberInput
    case "$page3NumberInput" in
        1 ) baota ;;
        2 ) baota7 ;;
        3 ) baotap ;;
        4 ) nezha ;;
        5 ) alist ;;
        0 ) menu
    esac
}

function page4(){
    echo "                            "
    green "请选择你接下来的操作"
    echo "                            "
    echo "1. X-UI面板（建议搭配宝塔面板使用）"
    echo "2. Trojan-UI一键脚本 "
    echo "3. XRay一键脚本 "
	echo "4. V2Ray一键脚本"
	echo "5. TG代理一键搭建 "
    echo "                            "
    echo "0. 返回主菜单"
    read -p "请输入选项:" page4NumberInput
    case "$page4NumberInput" in
        1 ) xui ;;
        2 ) trojanui ;;
        3 ) xray ;;
		4 ) v2ray ;;
		5 ) telegram ;;
        0 ) menu
    esac
}

function page5(){
    echo "                            "
    green "请选择你需要的探针"
    echo "                            "
    echo "1. OpenWrt本地一键编译脚本"
    echo "2. frp内网穿透一键安装"
	echo "1. Rclone官方一键安装脚本"
	echo "1. 隧道gost一键安装脚本"
    echo "                            "
    echo "0. 返回主菜单"
    read -p "请输入选项:" page5NumberInput
    case "$page5NumberInput" in
        1 ) openwrt ;;
        2 ) frps ;;
		3 ) rclone ;;
		4 ) gost ;;
        0 ) menu
    esac
}

menu