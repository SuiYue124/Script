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

green "=================================================================================="
echo "                           "
yellow " 1. 第一次运行可能会时间过长，请耐心等待！"
yellow " 2. 本脚本每次执行都会更新软件包列表和升级所有已安装的软件包！"
echo "                            "
green "=================================================================================="

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

IP4=$(curl -s ipv4.ip.sb)
IP6=$(curl -s ipv6.ip.sb)
WAN4=$(echo "$IP4" | sed 's/{.*"ip":"\([^\"]*\)".*}/\1/')
WAN6=$(echo "$IP6" | sed 's/{.*"ip":"\([^\"]*\)".*}/\1/')
COUNTRY4=$(expr "$IP4" : '.*country\":\"\([^"]*\).*')
COUNTRY6=$(expr "$IP6" : '.*country\":\"\([^"]*\).*')
ASNORG4=$(expr "$IP4" : '.*asn_org\":\"\([^"]*\).*')
ASNORG6=$(expr "$IP6" : '.*asn_org\":\"\([^"]*\).*')
if [ -z "$WAN4" ]; then
    WAN4="未检测到公网IPv4地址"
fi

if [ -z "$WAN6" ]; then
    WAN6="未检测到公网IPv6地址"
fi

COUNT=$(curl -sm2 "https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fraw.githubusercontent.com%2FGWen124%2FScript%2Fmaster%2FLinux%2Ftools.sh&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false" 2>&1) &&
TODAY=$(expr "$COUNT" : '.*\s\([0-9]\{1,\}\)\s/.*') && TOTAL=$(expr "$COUNT" : '.*/\s\([0-9]\{1,\}\)\s.*')

#page1
function linuxopen(){
    echo "                            "
    green "请选择你接下来使用的脚本"
    echo "                            "
    yellow "1. 修改登录方式为 root + 密码 登录"
    yellow "2. SSH一键保持活动连接"
    yellow "3. 同步中国时间"
	yellow "4. 常见依赖安装"
    echo "                            "
    red "0. 返回上级菜单"
	green "=================================================================================="
    read -e -p "请输入选项:" rootNumberInput
    case "$rootNumberInput" in
        1 ) 
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/root.sh)"
		;;
        2 ) 
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/sshh.sh)"
		;;
        3 ) 
		sudo cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
		sudo timedatectl set-timezone Asia/Shanghai
		sudo timedatectl set-local-rtc 0
		sudo timedatectl set-ntp yes
		;;
		4 ) 
		$systemPackage -y install wget curl htop nano python3 python3-pip ca-certificates redboot-tools lsof
		;;
        0 ) page1
		;;
		*)
		echo "请输入正确数字。 "
		;;
    esac
}

function rootlogin(){
    echo "                            "
    green "请选择你接下来使用的脚本"
    echo "                            "
    yellow "1. 增加系统用户"
    yellow "2. 删除系统用户"
    echo "                            "
    red "0. 返回上级菜单"
	green "=================================================================================="
    read -e -p "请输入选项:" rootNumberInput
    case "$rootNumberInput" in
        1 ) 
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/useradd.sh)"
		;;
        2 ) 
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/userdel.sh)"
		;;
        0 ) page1
		;;
		*)
		echo "请输入正确数字。 "
		;;
    esac
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
    red "0. 返回上级菜单"
	green "=================================================================================="
    read -e -p "请输入选项:" bbrNumberInput
    case "$bbrNumberInput" in
        1 ) 
		wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh && rm tcp.sh
		;;
        2 ) 
		wget -N --no-check-certificate "https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh && rm tcp.sh
		;;
        3 ) 
		wget --no-cache -O lkl-haproxy.sh https://github.com/mzz2017/lkl-haproxy/raw/master/lkl-haproxy.sh && bash lkl-haproxy.sh && rm lkl-haproxy.sh
		;;
        0 ) page1
		;;
		*)
		echo "请输入正确数字。 "
		;;
    esac
}
	
function acmesh(){
    wget -N https://cdn.jsdelivr.net/gh/Misaka-blog/acme-1key@master/acme1key.sh && chmod -R 777 acme1key.sh && bash acme1key.sh && rm -rf acme1key.sh
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
    red " 0. 返回上级菜单 "
	green "=================================================================================="
    echo
    read -e -p "请自行选择切换对应源:" csshNumberInput
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
        0 ) page1
		;;
		*)
		echo "请输入正确数字。 "
		;;
    esac
	rm -rf "/root/changesource.sh"
}

function warp(){
    wget -N --no-check-certificate https://gitlab.com/rwkgyg/CFwarp/raw/main/CFwarp.sh && bash CFwarp.sh && rm CFwarp.sh
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
    echo "                            "
	yellow " 1. 启动Netflix检测脚本"
	yellow " 2. 启动DisneyPlus检测脚本"
	yellow " 3. Youtube 缓存节点、地域信息检测"
	yellow " 4. 流媒体一键检测脚本 "
	echo "                            "
    red " 0. 返回上级菜单 "
	green "=================================================================================="
    echo
    read -e -p "请输入选项:" unlockNumberInput
    case "$unlockNumberInput" in
		1)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/netflix.sh)"
		;;
		2)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/disney.sh)"
		;;
		3)
	    bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/tubecheck.sh)"
		;;
		4)
		bash <(curl -L -s https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh)
		;;
        0 ) page2
		;;
		*)
		echo "请输入正确数字。 "
    esac
}

function speedtest(){
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/speedtest.sh)"
}

function lemonbench(){
  curl -fsL https://ilemonra.in/LemonBenchIntl | bash -s fast
}


#page3
function baota(){
    curl -sSO http://download.bt.cn/install/install_panel.sh && bash install_panel.sh && rm install_panel.sh
}

function baota7(){
   wget https://raw.githubusercontent.com/GWen124/Script/master/Linux/LinuxPanel-7.7.0.zip && unzip LinuxPanel-7.7.0.zip && cd /root/panel && bash update.sh && rm -rf LinuxPanel-7.7.0.zip  /root/panel
}

function baotap(){
    echo "{\"uid\":1000,\"username\":\"admin\",\"serverid\":1}" > /www/server/panel/data/userInfo.json
}

function uninstallbaota(){
    wget http://download.bt.cn/install/bt-uninstall.sh && sh bt-uninstall.sh && rm bt-uninstall.sh
}

function aaPanel(){
wget -O "/root/aaPanel.sh" "http://www.aapanel.com/script/install_6.0_en.sh" --no-check-certificate -T 30 -t 5 -d
chmod +x "/root/aaPanel.sh"
chmod 777 "/root/aaPanel.sh"
blue "下载完成"
bash "/root/aaPanel.sh"
rm -rf /root/aaPanel.sh
}

function nezha(){
  curl -L https://raw.githubusercontent.com/naiba/nezha/master/script/install.sh  -o nezha.sh && chmod +x nezha.sh
sudo ./nezha.sh && rm -rf nezha.sh
}

function alist(){
    echo "                            "
	yellow " 1. 安装Alist"
	yellow " 2. 更新Alist"
	yellow " 3. 卸载Alist"
	echo "                            "
    red " 0. 返回上级菜单 "
	green "=================================================================================="
    echo
    read -e -p "请输入选项:" alistNumberInput
    case "$alistNumberInput" in
		1)
		curl -fsSL "https://alist.nn.ci/v3.sh" | bash -s install /opt/Software
		;;
		2)
		curl -fsSL "https://alist.nn.ci/v3.sh" | bash -s update /opt/Software
		;;
		3)
		curl -fsSL "https://alist.nn.ci/v3.sh" | bash -s uninstall /opt/Software
		;;
        0 ) page3
		;;
		*)
		echo "请输入正确数字。 "
    esac
}

#page4
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
        0 ) page4
		;;
		*)
		echo "请输入正确数字。 "
    esac
}

function nginxpm(){
bash -c "$(curl -fsSL  https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/Docker-Compose/nginx-proxy-manager.sh)"
}

function watchtower(){
bash -c "$(curl -fsSL  https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/watchtowersh)"
}

function syncthing(){
bash -c "$(curl -fsSL  https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/syncthing.sh)"
}

function alistdocker(){
bash -c "$(curl -fsSL  https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/alist.sh)"
}

function qinglong(){
bash -c "$(curl -fsSL  https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/qinglong.sh)"
}

function easyimage(){
bash -c "$(curl -fsSL  https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/easyimage.sh)"
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
	yellow " 8. 待定"
	yellow " 9. 待定"
	echo "                            "
    red " 0. 返回上级菜单 "
	green "=================================================================================="
    echo
    read -e -p "请输入选项:" odockerNumberInput
    case "$odockerNumberInput" in
		1)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/qiandao.sh)"
		;;
		2)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/feiyangiptv.sh)"
		;;
		3)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/freenom.sh)"
		;;
		4)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/halo.sh)"
		;;
		5)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/reader.sh)"
		;;
		6)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/calibre-web.sh)"
		;;
		7)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/onenav.sh)"
		;;
		8)
		bash -c "$(curl -fsSL https://gwen124.ml/tools.sh)"
		;;
		9)
		bash -c "$(curl -fsSL https://gwen124.ml/tools.sh)"
		;;		
        0 ) page4
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
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/Docker-Compose/Easyimage/easyimage.sh)"
		;;
		2)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/Docker-Compose/YOURLS/yourls.sh)"
		;;
		3)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/Docker-Compose/Reader/reader.sh)"
		;;
		4)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/Docker-Compose/WikiJS/wikijs.sh)"
		;;
		5)
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/Docker-Compose/calibre.sh)"
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
        0 ) page4
		;;
		*)
		echo "请输入正确数字。 "
    esac
}

#page5
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

ipsec() {
    clear
    green "================================================="
    yellow " IPsec VPN Server一键脚本"
	yellow " 手动添加/删除IPsec账户：nano /etc/ppp/chap-secrets"
	yellow " 查看或更改 IPsec PSK：nano /etc/ipsec.secrets"
    green "================================================="
    blue "  1. 安装IPsec(使用脚本随机生成的 VPN 登录凭证)"
    blue "  2. 安装IPsec(提供你自己的 VPN 登录凭证)"
	blue "  3. 添加IPsec账户"
	blue "  4. 删除IPsec账户"
    blue "  5. 更新IPsec"
	blue "  6. 卸载IPsec"
    blue "  0. 退出脚本"
    green "================================================="
    read -e -p "$(yellow '请输入数字 [0-3]:')" num
    case "$num" in
      1)
        curl -sSf https://raw.githubusercontent.com/hwdsl2/setup-ipsec-vpn/master/vpnsetup.sh -o vpnsetup.sh && sudo sh vpnsetup.sh && mkdir -p /opt/Software/IPsec && mv vpnclient.mobileconfig vpnclient.p12 vpnclient.sswan /opt/Software/IPsec && rm -rf vpnsetup.sh
        ;;
      2)
        curl -sSf https://raw.githubusercontent.com/GWen124/Script/master/Linux/ipsec.sh -o ipsec.sh && sudo sh ipsec.sh && mkdir -p /opt/Software/IPsec && mv vpnclient.mobileconfig vpnclient.p12 vpnclient.sswan /opt/Software/IPsec && rm -rf ipsec.sh
        ;;
      3)
        curl -sSf https://raw.githubusercontent.com/GWen124/Script/master/Linux/ipsecadduser.sh -o ipsecadduser.sh && sudo sh ipsecadduser.sh && rm -rf ipsecadduser.sh
        ;;
	  4)
        curl -sSf https://raw.githubusercontent.com/GWen124/Script/master/Linux/ipsecdeluser.sh -o ipsecdeluser.sh && sudo sh ipsecdeluser.sh && rm -rf ipsecdeluser.sh
        ;;
	  5)
        curl -sSf https://raw.githubusercontent.com/hwdsl2/setup-ipsec-vpn/master/extras/vpnupgrade.sh -o vpnupgrade.sh && sudo sh vpnupgrade.sh && rm -rf vpnupgrade.sh
        ;;
      6)
        curl -sSf https://raw.githubusercontent.com/hwdsl2/setup-ipsec-vpn/master/extras/vpnuninstall.sh -o vpnuninstall.sh && sudo sh vpnuninstall.sh && rm -rf vpnuninstall.sh /opt/Software/IPsec
        ;;
      0)
        page5
        ;;
		*)
		echo "请输入正确数字。 "
    esac
}

#page6
function node(){
  bash -c "$(curl -fsSL https://deb.nodesource.com/setup_16.x)" && $systemPackage install -y nodejs
}

function frps(){
if [ "$(uname -m)" = "x86_64" ]; then
  wget https://raw.githubusercontent.com/GWen124/Script/master/Linux/FRPS/AMD-install-frps.sh -O ./install-frps.sh && rm -r install-frps.sh
elif [ "$(uname -m)" = "aarch64" ]; then
  wget https://raw.githubusercontent.com/GWen124/Script/master/Linux/FRPS/ARM-install-frps.sh -O ./install-frps.sh && rm -r install-frps.sh
else
  echo "未知的系统架构"
fi
}

function rclone(){
  curl https://rclone.org/install.sh | sudo bash && rm -r install.sh
}

function dnat(){
  bash <(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/dnat.sh)
}

function gost(){
  wget --no-check-certificate -O gost.sh https://raw.githubusercontent.com/KANIKIG/Multi-EasyGost/master/gost.sh && chmod +x gost.sh && ./gost.sh && rm -rf gost.sh
}

function ddsystem(){
  wget --no-check-certificate -qO ~/Network-Reinstall-System-Modify.sh 'https://www.cxthhhhh.com/CXT-Library/Network-Reinstall-System-Modify/Network-Reinstall-System-Modify.sh' && chmod a+x ~/Network-Reinstall-System-Modify.sh && bash ~/Network-Reinstall-System-Modify.sh -UI_Options && rm -rf ~/Network-Reinstall-System-Modify.sh
}

function QuickBox(){
  bash <(curl -sLo- https://git.io/qbox-lite) COMMAND
}

function aria2(){
  bash <(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/aria2.sh)
}

function zerotier(){
  curl -s https://install.zerotier.com | sudo bash
}

function chatgpt(){
  bash <(curl -sSL https://gitlab.com/rwkgyg/chatgptbot/raw/main/chatgpt.sh)
}

 function menu(){
    clear
    echo "                           "
    blue "当前脚本版本：$ver "
#	blue "我的Blog：$blog "
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
    yellow "IPv4地址：$WAN4"
    yellow "IPv6地址：$WAN6"
    green "=================================================================================="
    echo "                            "
    red "请选择你接下来的操作："
    echo "                            "
    yellow "1. 系统相关"
    yellow "2. VPS检测"
    yellow "3. 面板相关"
    yellow "4. Docker"
    yellow "5. 科学上网"
    yellow "6. 其他工具"
    echo "                            "
    red "0. 退出脚本"
    echo "                            "
    green "=================================================================================="
    blue "本脚本理论支持：CentOS7+ / Debian9+ / Ubuntu16.04+"
    blue "内置脚本均来源于网络，仅仅只是汇聚脚本功能，仅供自用！"
	blue "如有需要增加的脚本，请联系：https://t.me/WenGe124_Bot"
	yellow "今日运行次数：$TODAY 总共运行次数：$TOTAL"
	green "=================================================================================="
    read -e -p "请输入选项:" menuNumberInput
    case "$menuNumberInput" in
        1 ) page1 ;;
        2 ) page2 ;;
        3 ) page3 ;;
        4 ) page4 ;;
        5 ) page5 ;;
		6 ) page6 ;;
        0 ) exit 0 ;;
		 *) echo "请输入正确数字。 "
    esac
}

function page1(){
	echo "                            "
    green "请选择你接下来的操作："
    echo "                            "
    yellow "1. 开机脚本"
	yellow "2. 系统账户相关"
	yellow "3. 关闭原系统防火墙"
    yellow "4. 虚拟内存SWAP一键脚本 "
    yellow "5. 更改SSH端口"
    yellow "6. 开启BBR一键加速"
	yellow "7. Acme.sh 证书申请脚本"
	yellow "8. Linux换源脚本"
	yellow "9. WARP多功能一键脚本"
    echo "                            "
    red "0. 返回主菜单"
	green "=================================================================================="
    read -e -p "请输入选项:" page1NumberInput
    case "$page1NumberInput" in
        1 ) linuxopen ;;
		2 ) rootlogin ;;
		3) vpsfirewall ;;
        4 ) swap ;;
        5 ) ssh_port ;;
        6 ) bbr ;;
		7 ) acmesh ;;
		8 ) cssh ;;
		9 ) warp ;;
        0 ) menu ;;
		 *) echo "请输入正确数字。 "
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
	yellow "6. LemonBench"
    echo "                            "
    red "0. 返回主菜单"
	green "=================================================================================="
    read -e -p "请输入选项:" page2NumberInput
    case "$page2NumberInput" in
        1 ) bench ;;
        2 ) server-test ;;
        3 ) gfw_push ;;
        4 ) unlock ;;
		5 ) speedtest ;;
		6 ) lemonbench ;;
        0 ) menu;;
		 *) echo "请输入正确数字。 "
    esac
}

function page3(){
    echo "                            "
    green "请选择你接下来使用的脚本："
    echo "                            "
    yellow "1. 宝塔面板一键官方脚本"
    yellow "2. 宝塔面板降级到v7.7"
    yellow "3. 宝塔面板无需手机登陆"
	yellow "4. 卸载宝塔面板"
	yellow "5. 宝塔面板国际版"
    yellow "6. 哪吒面板"
    yellow "7. Alist一键安装脚本"
    echo "                            "
    red "0. 返回主菜单"
	green "=================================================================================="
    read -e -p "请输入选项:" page3NumberInput
    case "$page3NumberInput" in
        1 ) baota ;;
        2 ) baota7 ;;
        3 ) baotap ;;
		4 ) uninstallbaota ;;
		5 ) aaPanel ;;
        6 ) nezha ;;
        7 ) alist ;;
        0 ) menu;;
		 *) echo "请输入正确数字。 "
    esac
}

function page4(){
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
        0 ) menu;;
		 *) echo "请输入正确数字。 "
    esac
}

function page5(){
    echo "                            "
    green "请选择你接下来的操作："
    echo "                            "
    yellow "1. X-UI面板（建议搭配宝塔面板使用）"
    yellow "2. Trojan-UI一键脚本 "
    yellow "3. XRay一键脚本 "
	yellow "4. V2Ray一键脚本"
	yellow "5. SS、SSR一键脚本"
	yellow "6. Telegram代理一键搭建 "
	yellow "7. IPsec VPN Server一键脚本"
    echo "                            "
    red "0. 返回主菜单"
	green "=================================================================================="
    read -e -p "请输入选项:" page5NumberInput
    case "$page5NumberInput" in
        1 ) xui ;;
        2 ) trojanui ;;
        3 ) xray ;;
		4 ) v2ray ;;
		5 ) shadowsocks ;;
		6 ) telegram ;;
		7 ) ipsec ;;
        0 ) menu;;
		 *) echo "请输入正确数字。 "
    esac
}

function page6(){
    echo "                            "
    green "请选择你需要的工具："
    echo "                            "
    yellow "1. Node_16.x"
    yellow "2. Frp内网穿透一键安装"
	yellow "3. Rclone官方一键安装脚本"
	yellow "4. Iptables一键中转"
	yellow "5. Gost一键中转"
	yellow "6. VPS DD系统"
	yellow "7. QuickBox-Lite(仅支持 amd64)"
	yellow "8. Aria2一键安装脚本"
	yellow "9. ZeroTier内网穿透一键安装脚本"
	yellow "10. Telegram ChatGPT Bot"
    echo "                            "
    red "0. 返回主菜单"
	green "=================================================================================="
    read -e -p "请输入选项:" page6NumberInput
    case "$page6NumberInput" in
        1 ) node ;;
        2 ) frps ;;
		3 ) rclone ;;
		4 ) dnat ;;
		5 ) gost ;;
		6 ) ddsystem ;;
		7 ) QuickBox ;;
		8 ) aria2 ;;
		9 ) zerotier ;;
		10 ) chatgpt ;;
        0 ) menu;;
		 *) echo "请输入正确数字。 "
    esac
}

menu





