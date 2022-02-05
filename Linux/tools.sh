#!/bin/bash
# By GWen124
# https://github.com/GWen124/Script/tree/master/Linux

ver="20220205"
github="https://github.com/GWen124"
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

for i in "${CMD[@]}"; do
    SYS="$i" && [[ -n $SYS ]] && break
done

for ((int=0; int<${#REGEX[@]}; int++)); do
    [[ $(echo "$SYS" | tr '[:upper:]' '[:lower:]') =~ ${REGEX[int]} ]] && SYSTEM="${RELEASE[int]}" && [[ -n $SYSTEM ]] && break
done

[[ -z $SYSTEM ]] && red "不支持VPS的当前系统，请使用主流操作系统" && exit 1

clear
echo "                            "
green "=================================================================================="
echo "                            "
yellow "1.我已使用Root账户登录"
yellow "2.继续使用非Root账户登录"
red "注意：非Root账户可能导致某些脚本不能运行！"
echo "                           "
red "0.退出脚本"
echo "                            "
green "=================================================================================="
read -p "请输入选项:" loginNumberInput
case "$loginNumberInput" in
    1 ) [[ $(id -u) != 0 ]] && red "请使用“sudo -i”登录root用户后执行本脚本！！！" && exit 1 ;;
    2 ) [[ "$USER" == "root" ]] && red "请使用“su xxx”登录非root用户后执行本脚本！！！" && exit 1 ;;
	0 ) exit 1 ;;
esac

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

sudo cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
sudo timedatectl set-timezone Asia/Shanghai
sudo timedatectl set-local-rtc 0
sudo timedatectl set-ntp yes

egrep -q "^\s*.*ClientAliveInterval\s\w+.*$" /etc/ssh/sshd_config && sed -ri "s/^\s*.*ClientAliveInterval\s\w+.*$/ClientAliveInterval 60/" /etc/ssh/sshd_config || echo "ClientAliveInterval 60" >> /etc/ssh/sshd_config
egrep -q "^\s*.*ClientAliveCountMax\s\w+.*$" /etc/ssh/sshd_config && sed -ri "s/^\s*.*ClientAliveCountMax\s\w+.*$/ClientAliveCountMax 30/" /etc/ssh/sshd_config || echo "ClientAliveCountMax 30" >> /etc/ssh/sshd_config

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

COUNT=$(curl -sm2 "https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fraw.githubusercontent.com%2FGWen124%2FScript%2Fmaster%2FLinux%2Ftools.sh&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false" 2>&1) &&
TODAY=$(expr "$COUNT" : '.*\s\([0-9]\{1,\}\)\s/.*') && TOTAL=$(expr "$COUNT" : '.*/\s\([0-9]\{1,\}\)\s.*')

#page1
function rootlogin(){
[[ $EUID -ne 0 ]] && su='sudo' 
lsattr /etc/passwd /etc/shadow >/dev/null 2>&1
chattr -i /etc/passwd /etc/shadow >/dev/null 2>&1
chattr -a /etc/passwd /etc/shadow >/dev/null 2>&1
lsattr /etc/passwd /etc/shadow >/dev/null 2>&1
prl=`grep PermitRootLogin /etc/ssh/sshd_config`
pa=`grep PasswordAuthentication /etc/ssh/sshd_config`
if [[ -n $prl && -n $pa ]]; then
read -p "设置的root密码:" password
echo root:$password | $su chpasswd root
$su sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
$su sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
$su service sshd restart
green "VPS当前用户名：root"
green "vps当前root密码：$password"
echo "                            "
yellow "请妥善保管好登录信息！然后重启VPS确保设置已保存！"
echo "                            "
else
red "当前vps不支持root账户或无法自定义root密码" && exit 1
fi
}

function vpsfirewall(){
    if [ $SYSTEM = "CentOS" ]; then
        systemctl stop oracle-cloud-agent
        systemctl disable oracle-cloud-agent
        systemctl stop oracle-cloud-agent-updater
        systemctl disable oracle-cloud-agent-updater
        systemctl stop firewalld.service
        systemctl disable firewalld.service
        yellow "原生系统防火墙禁用成功"
    else
        iptables -P INPUT ACCEPT
        iptables -P FORWARD ACCEPT
        iptables -P OUTPUT ACCEPT
        iptables -F
        apt-get purge netfilter-persistent -y
        yellow "原生系统防火墙禁用成功"
    fi
}

function swap(){
  bash <(curl -sSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/swap.sh)
}

function ssh_port(){
  bash <(curl -sSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/ssh_port.sh)
}

function bbr(){
    echo "                            "
    green "请选择你接下来使用的脚本"
    echo "                            "
    yellow "1. BBR一键加速（稳定版）"
    yellow "2. BBR一键加速（最新版）"
    yellow "3. openvz BBR一键加速"
    echo "                            "
    red "0. 返回主菜单"
	green "=================================================================================="
    read -p "请输入选项:" bbrNumberInput
    case "$bbrNumberInput" in
        1 ) 
		wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
		;;
        2 ) 
		wget -N --no-check-certificate "https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
		;;
        3 ) 
		wget --no-cache -O lkl-haproxy.sh https://github.com/mzz2017/lkl-haproxy/raw/master/lkl-haproxy.sh && bash lkl-haproxy.sh
		;;
        0 ) menu
    esac
}
	
function acmesh(){
    wget -N https://cdn.jsdelivr.net/gh/Misaka-blog/acme-1key@master/acme1key.sh && chmod -R 777 acme1key.sh && bash acme1key.sh
}


function cssh(){
wget -O "/root/changesource.sh" "https://raw.githubusercontent.com/Netflixxp/jcnf-box/master/sh/changesource.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/changesource.sh"
chmod 777 "/root/changesource.sh"
yellow "下载完成"
    echo "                            "
	yellow " 1. 切换推荐源"
	yellow " 2. 切换中科大源 "
	yellow " 3. 切换阿里源 "
	yellow " 4. 切换网易源 "
	yellow " 5. 切换AWS亚马逊云源 "
	yellow " 6. 还原默认源 "
	echo "                            "
    red " 0. 返回主菜单 "
	green "=================================================================================="
    echo
    read -p "请自行选择切换对应源:" csshNumberInput
    case "$csshNumberInput" in
		1)
		bash changesource.sh
		;;
		2)
		bash changesource.sh cn
		;;
		3)
	    bash changesource.sh aliyun
		;;
		4)
		bash changesource.sh 163
		;;
		5)
	   bash changesource.sh aws
		;;
		6)
	    bash changesource.sh restore
		;;
        0 ) menu
    esac
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

function speedtest(){
  wget -O "/root/speedtest" "https://raw.githubusercontent.com/Netflixxp/jcnf-box/master/sh/speedtest" --no-check-certificate -T 30 -t 5 -d
  chmod +x "/root/speedtest"
  chmod 777 "/root/speedtest"
  yellow "再次使用，可执行 bash /root/speedtest 再次运行"
  ./speedtest
}

function unlock(){
    echo "                            "
	yellow " 1. 启动Netflix检测脚本（X86） "
	yellow " 2. 启动Netflix检测脚本（ARM） "
	yellow " 3. 启动DisneyPlus检测脚本（X86） "
	yellow " 4. 启动DisneyPlus检测脚本（ARM） "
	yellow " 5. Youtube 缓存节点、地域信息检测（X86） "
	yellow " 6. Youtube 缓存节点、地域信息检测（ARM） "
	yellow " 7. 流媒体一键检测脚本 "
	echo "                            "
    red " 0. 返回主菜单 "
	green "=================================================================================="
    echo
    read -p "请输入选项:" unlockNumberInput
    case "$unlockNumberInput" in
		1)
		wget -O nf https://github.com/sjlleo/netflix-verify/releases/download/2.61/nf_2.61_linux_amd64 && chmod +x nf && clear && ./nf
		;;
		2)
		wget -O nf https://github.com/sjlleo/netflix-verify/releases/download/2.61/nf_2.61_linux_arm64 && chmod +x nf && clear && ./nf
		;;
		3)
	    wget -O dp https://github.com/sjlleo/VerifyDisneyPlus/releases/download/1.01/dp_1.01_linux_amd64 && chmod +x dp && clear && ./dp
		;;
		4)
		wget -O dp https://github.com/sjlleo/VerifyDisneyPlus/releases/download/1.01/dp_1.01_linux_arm64 && chmod +x dp && clear && ./dp
		;;
		5)
	    wget -O tubecheck https://cdn.jsdelivr.net/gh/sjlleo/TubeCheck/CDN/tubecheck_1.0beta_linux_amd64 && chmod +x tubecheck && clear && ./tubecheck
		;;
		6)
	    wget -O tubecheck https://github.com/sjlleo/TubeCheck/releases/download/1.0Beta/tubecheck_1.0beta_linux_arm64 && chmod +x tubecheck && clear && ./tubecheck
		;;
		7)
		bash <(curl -L -s https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh)
		;;
        0 ) menu
    esac
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

function aaPanel(){
wget -O "/root/aaPanel.sh" "http://www.aapanel.com/script/install_6.0_en.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/aaPanel.sh"
chmod 777 "/root/aaPanel.sh"
blue "下载完成"
bash "/root/aaPanel.sh"
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

function shadowsocks(){
    wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontents.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh
    chmod +x shadowsocks-all.sh
    ./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
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

function dnat(){
  wget --no-check-certificate -qO dnat.sh https://raw.githubusercontent.com/GWen124/Script/master/Linux/dnat.sh && bash dnat.sh
}

function gost(){
  curl -fsSL "https://raw.githubusercontent.com/KANIKIG/Multi-EasyGost/master/gost.sh" | bash -s install
}

function ddsystem(){
  wget --no-check-certificate -qO ~/Network-Reinstall-System-Modify.sh 'https://www.cxthhhhh.com/CXT-Library/Network-Reinstall-System-Modify/Network-Reinstall-System-Modify.sh' && chmod a+x ~/Network-Reinstall-System-Modify.sh && bash ~/Network-Reinstall-System-Modify.sh -UI_Options
}

 function menu(){
    clear
    echo "                           "
    blue "当前脚本版本：$ver "
	blue "我的仓库：$github "
	echo "                            "
    yellow "更新日志：$changeLog"
    echo "                           "
    green "=================================================================================="
    red "检测到VPS信息如下："
    yellow "处理器架构：$arch"
    yellow "虚拟化架构：$virt"
    yellow "操作系统：$CMD"
    yellow "内核版本：$kernelVer"
    yellow "IPv4地址：$IP4"
    yellow "IPv6地址：$IP6"
    green "=================================================================================="
    echo "                            "
    red "请选择你接下来的操作："
    echo "                            "
    yellow "1. 系统相关"
    yellow "2. VPS检测"
    yellow "3. 面板相关"
    yellow "4. 科学上网"
    yellow "5. 其他工具"
    echo "                            "
    red "0. 退出脚本"
    echo "                            "
    green "=================================================================================="
    blue "本脚本理论支持：CentOS7+ / Debian9+ / Ubuntu16.04+"
    blue "内置脚本均来源于网络，仅仅只是汇聚脚本功能，仅供自用！"
	blue "今日运行次数：$TODAY 总共运行次数：$TOTAL"
	green "=================================================================================="
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
    green "请选择你接下来的操作："
    echo "                            "
    yellow "1. 修改登录方式为 root + 密码 登录"
	yellow "2. 关闭原系统防火墙"
    yellow "3. 虚拟内存SWAP一键脚本 "
    yellow "4. 更改SSH端口"
    yellow "5. 开启BBR一键加速"
	yellow "6. Acme.sh 证书申请脚本"
	yellow "7. Linux换源脚本"
    echo "                            "
    red "0. 返回主菜单"
	green "=================================================================================="
    read -p "请输入选项:" page1NumberInput
    case "$page1NumberInput" in
        1 ) rootlogin ;;
		2) vpsfirewall ;;
        3 ) swap ;;
        4 ) ssh_port ;;
        5 ) bbr ;;
		6 ) acmesh ;;
		7 ) cssh ;;
        0 ) menu
    esac
}

function page2(){
    echo "                            "
    green "请选择你接下来使用的脚本："
    echo "                            "
    yellow "1. Bench：查看系统信息，测试本地到世界主要机房速度及硬盘读写速率"
    yellow "2. VPS 回程路由、路由跟踪测试"
    yellow "3. 监测IP是否被墙并推送消息至Telegram "
    yellow "4. 流媒体解锁检测"
	yellow "5. Speedtest"
    echo "                            "
    red "0. 返回主菜单"
	green "=================================================================================="
    read -p "请输入选项:" page2NumberInput
    case "$page2NumberInput" in
        1 ) bench ;;
        2 ) server-test ;;
        3 ) gfw_push ;;
        4 ) unlock ;;
		5 ) speedtest ;;
        0 ) menu
    esac
}

function page3(){
    echo "                            "
    green "请选择你接下来使用的脚本："
    echo "                            "
    yellow "1. 宝塔面板一键官方脚本"
    yellow "2. 宝塔面板降级到v7.7"
    yellow "3. 宝塔面板无需手机登陆"
	yellow "4. 宝塔面板英文官方版"
    yellow "5. 哪吒面板"
    yellow "6. Alist一键安装脚本"
    echo "                            "
    red "0. 返回主菜单"
	green "=================================================================================="
    read -p "请输入选项:" page3NumberInput
    case "$page3NumberInput" in
        1 ) baota ;;
        2 ) baota7 ;;
        3 ) baotap ;;
		4 ) aaPanel ;;
        5 ) nezha ;;
        6 ) alist ;;
        0 ) menu
    esac
}

function page4(){
    echo "                            "
    green "请选择你接下来的操作："
    echo "                            "
    yellow "1. X-UI面板（建议搭配宝塔面板使用）"
    yellow "2. Trojan-UI一键脚本 "
    yellow "3. XRay一键脚本 "
	yellow "4. V2Ray一键脚本"
	yellow "5. SS、SSR一键脚本"
	yellow "6. TG代理一键搭建 "
    echo "                            "
    red "0. 返回主菜单"
	green "=================================================================================="
    read -p "请输入选项:" page4NumberInput
    case "$page4NumberInput" in
        1 ) xui ;;
        2 ) trojanui ;;
        3 ) xray ;;
		4 ) v2ray ;;
		5 ) shadowsocks ;;
		6 ) telegram ;;
        0 ) menu
    esac
}

function page5(){
    echo "                            "
    green "请选择你需要的工具："
    echo "                            "
    yellow "1. OpenWrt本地一键编译脚本"
    yellow "2. frp内网穿透一键安装"
	yellow "3. Rclone官方一键安装脚本"
	yellow "4. iptables一键中转"
	yellow "5. gost一键中转"
	yellow "6. VPS DD系统"
    echo "                            "
    red "0. 返回主菜单"
	green "=================================================================================="
    read -p "请输入选项:" page5NumberInput
    case "$page5NumberInput" in
        1 ) openwrt ;;
        2 ) frps ;;
		3 ) rclone ;;
		4 ) dnat ;;
		5 ) gost ;;
		6 ) ddsystem ;;
        0 ) menu
    esac
}

menu