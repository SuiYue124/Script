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

xui(){
    bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
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

nf86(){
  wget -O nf https://github.com/sjlleo/netflix-verify/releases/download/2.61/nf_2.61_linux_amd64 && chmod +x nf && clear && ./nf
}

nfarm(){
  wget -O nf https://github.com/sjlleo/netflix-verify/releases/download/2.61/nf_2.61_linux_arm64 && chmod +x nf && clear && ./nf
}

dp86(){
   wget -O dp https://github.com/sjlleo/VerifyDisneyPlus/releases/download/1.01/dp_1.01_linux_amd64 && chmod +x dp && clear && ./dp
}

dparm(){
  wget -O dp https://github.com/sjlleo/VerifyDisneyPlus/releases/download/1.01/dp_1.01_linux_arm64 && chmod +x dp && clear && ./dp
}

youtube86(){
  wget -O tubecheck https://cdn.jsdelivr.net/gh/sjlleo/TubeCheck/CDN/tubecheck_1.0beta_linux_amd64 && chmod +x tubecheck && clear && ./tubecheck
}

youtubearm(){
  wget -O tubecheck https://github.com/sjlleo/TubeCheck/releases/download/1.0Beta/tubecheck_1.0beta_linux_arm64 && chmod +x tubecheck && clear && ./tubecheck
}

liumeiti(){
  bash <(curl -L -s https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh)
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


start_menu(){
    clear
	green "========================================================================="
     blue " 本脚本支持：CentOS7+ / Debian9+ / Ubuntu16.04+"
	 blue " 我的仓库：https://github.com/GWen124 "
	 blue " 本脚本仓库：https://github.com/GWen124/Script"
     blue " 此脚本源于网络，仅仅只是汇聚脚本功能，方便大家使用而已！"
	green "========================================================================="
      red " 脚本测速会大量消耗 VPS 流量，请悉知！"
	green "==============================VPS检测===================================="
     yellow " 1. Bench：查看系统信息，测试本地到世界主要机房速度及硬盘读写速率"
	 yellow " 2. VPS 回程路由、路由跟踪测试 "
	 yellow " 3. 查看本机IP和服务商 "
	green "==============================科学上网一键脚本==========================="
	 yellow " 4. X-UI面板（建议搭配宝塔面板使用） "
	 yellow " 5. XRay一键脚本 "
	 yellow " 6. V2Ray一键脚本 "
	 yellow " 7. TG代理一键搭建 "
	green "==============================宝塔面板==================================="
	 yellow " 8. Ubuntu系统一键官方脚本 "
	 yellow " 9. 宝塔面板无需手机登陆 "
	 yellow " 10. 宝塔面板降级到v7.7 "
	green "==============================BBR加速===================================="
	 yellow " 11. BBR一键加速（稳定版）"
	 yellow " 12. BBR一键加速（最新版）"
	 yellow " 13. openvz BBR一键加速 "
	green "==============================流媒体解锁检测============================="
	 yellow " 14. 启动Netflix检测脚本（X86） "
	 yellow " 15. 启动Netflix检测脚本（ARM） "
	 yellow " 16. 启动DisneyPlus检测脚本（X86） "
	 yellow " 17. 启动DisneyPlus检测脚本（ARM） "
	 yellow " 18. Youtube 缓存节点、地域信息检测（X86） "
	 yellow " 19. Youtube 缓存节点、地域信息检测（ARM） "
	 yellow " 20. 流媒体一键检测脚本 "
	green "==============================其他工具==================================="
	 yellow " 21. VPS开机大礼包（请设置好ROOT密码后运行） "
	 yellow " 22. frp内网穿透一键安装 "
	 yellow " 23. 虚拟内存SWAP一键脚本 "
	 yellow " 24. 更改SSH端口 "

     red " 0. 退出脚本 "
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
		xui
		;;
		5)
		xray
		;;
		6)
		v2ray
		;;
		7)
		telegram
		;;
		8)
		baota
		;;
		9)
		baotap
		;;
		10)
		baota7
		;;
		11)
		vps_bbr1
		;;
		12)
		vps_bbr2
		;;
		13)
		vps_openvz
		;;
		14)
		nf86
		;;
		15)
		nfarm
		;;
		16)
	    dp86
		;;
		17)
		dparm
		;;
		18)
	    youtube86
		;;
		19)
	    youtubearm
		;;
		20)
		liumeiti
		;;
		21)
		vpsopen
		;;
		22)
		frps
		;;
		23)
		swap
		;;
		24)
		ssh_port
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