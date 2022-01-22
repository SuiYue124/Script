#!/bin/bash
# By GWen124
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
$systemPackage -y install wget curl htop nano

bench(){
  wget -qO- bench.sh | bash
}

server-test(){
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/server-test.sh)"
}

vpsip(){
  curl ip.p3terx.com
}

gfw_push(){
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/gfw_push.sh)"
}

unlock(){
  bash -c "$(curl -fsSL bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/unlock.sh)")"
}

xui(){
    bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
}

trojanui(){
    bash <(curl -Ls https://raw.githubusercontent.com/GWen124/Script/master/Linux/trojan-install.sh)
}

xray(){
    bash <(curl -sL https://raw.githubusercontent.com/GWen124/Script/master/Linux/xray.sh)
}

v2ray(){
    bash <(curl -s -L https://git.io/v2ray.sh)
}

telegram(){
    bash <(wget -qO- https://git.io/mtg.sh)
}


baota(){
    wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh && sudo bash install.sh
}

baotap(){
    echo "{\"uid\":1000,\"username\":\"admin\",\"serverid\":1}" > /www/server/panel/data/userInfo.json
}

baota7(){
   wget https://raw.githubusercontent.com/GWen124/Script/master/Linux/LinuxPanel-7.7.0.zip && unzip LinuxPanel-7.7.0.zip && cd /root/panel && bash update.sh
}

vps_bbr1(){
   wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
}

vps_bbr2(){
  wget -N --no-check-certificate "https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
}

vps_openvz(){
  wget --no-cache -O lkl-haproxy.sh https://github.com/mzz2017/lkl-haproxy/raw/master/lkl-haproxy.sh && bash lkl-haproxy.sh
}

vpsopen(){
  bash <(curl -sSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/open.sh)
}

frps(){
  wget https://raw.githubusercontent.com/MvsCode/frps-onekey/master/install-frps.sh -O ./install-frps.sh && chmod 700 ./install-frps.sh && ./install-frps.sh install
}

swap(){
  bash <(curl -sSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/swap.sh)
}

ssh_port(){
  bash <(curl -sSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/ssh_port.sh)
}

nezha(){
  curl -L https://raw.githubusercontent.com/naiba/nezha/master/script/install.sh  -o nezha.sh && chmod +x nezha.sh
sudo ./nezha.sh
}

rclone(){
  curl https://rclone.org/install.sh | sudo bash
}

alist(){
  curl -fsSL "https://raw.githubusercontent.com/GWen124/Script/master/Linux/alist.sh" | bash -s install
}

openwrt(){
  bash <(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/openwrt-local.sh)
}


start_menu(){
    clear
	green "================================================================================="
     blue " 本脚本支持：CentOS7+ / Debian9+ / Ubuntu16.04+"
	 blue " 我的仓库：https://github.com/GWen124 "
	 blue " 本脚本仓库：https://github.com/GWen124/Script"
     blue " 此脚本源于网络，仅仅只是汇聚脚本功能，方便大家使用而已！"
	green "================================================================================="
      red " 脚本测速会大量消耗 VPS 流量，请悉知！"
	green "==================================VPS检测========================================"
     yellow " 1. Bench：查看系统信息，测试本地到世界主要机房速度及硬盘读写速率"
	 yellow " 2. VPS 回程路由、路由跟踪测试 "
	 yellow " 3. 查看本机IP和服务商 "
	 yellow " 4. 监测IP是否被墙并推送消息至Telegram "
	 yellow " 5. 流媒体解锁检测 "
	green "==================================科学上网一键脚本==============================="
	 yellow " 6. X-UI面板（建议搭配宝塔面板使用） "
	 yellow " 7. Trojan-UI一键脚本 "
	 yellow " 8. XRay一键脚本 "
	 yellow " 9. V2Ray一键脚本 "
	 yellow " 10. TG代理一键搭建 "
	green "==================================宝塔面板======================================="
	 yellow " 11. Ubuntu系统一键官方脚本 "
	 yellow " 12. 宝塔面板无需手机登陆 "
	 yellow " 13. 宝塔面板降级到v7.7 "
	green "==================================BBR加速========================================"
	 yellow " 14. BBR一键加速（稳定版）"
	 yellow " 15. BBR一键加速（最新版）"
	 yellow " 16. openvz BBR一键加速 "
	green "==================================其他工具======================================="
	 yellow " 17. VPS开机大礼包（请设置好ROOT密码后运行） "
	 yellow " 18. frp内网穿透一键安装 "
	 yellow " 19. 虚拟内存SWAP一键脚本 "
	 yellow " 20. 更改SSH端口 "
	 yellow " 21. 哪吒面板 "
	 yellow " 22. Rclone官方一键安装脚本 "
	 yellow " 23. Alist一键安装脚本 "
	 yellow " 24. OpenWrt本地一键编译脚本 "
	 green "================================================================================="
     red " 0. 退出脚本 "
	 green "================================================================================="
    echo
    read -p "请输入数字:" num
    case "$num" in
    	1)
		bench
		;;
		2)
		server-test
		;;
		3)
		vpsip
		;;
		4)
		gfw_push
		;;
		5)
		unlock
		;;
		6)
		xui
		;;
		7)
		trojanui
		;;
		8)
		xray
		;;
		9)
		v2ray
		;;
		10)
		telegram
		;;
		11)
		baota
		;;
		12)
		baotap
		;;
		13)
		baota7
		;;
		14)
		vps_bbr1
		;;
		15)
		vps_bbr2
		;;
		16)
		vps_openvz
		;;
		17)
		vpsopen
		;;
		18)
		frps
		;;
		19)
		swap
		;;
		20)
		ssh_port
		;;
		21)
		nezha
		;;
		22)
		rclone
		;;
		23)
		alist
		;;
		24)
		openwrt
		;;
		0)
		exit 0
		;;
		*)
	clear
	echo "请输入正确数字"
	sleep 2s
	start_menu
	;;
    esac
}

start_menu