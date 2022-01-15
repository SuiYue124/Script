#!/bin/bash
sudo cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
sudo timedatectl set-timezone Asia/Shanghai
sudo timedatectl set-local-rtc 0
sudo timedatectl set-ntp yes

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F
apt-get -y purge netfilter-persistent

egrep -q "^\s*.*ClientAliveInterval\s\w+.*$" /etc/ssh/sshd_config && sed -ri "s/^\s*.*ClientAliveInterval\s\w+.*$/ClientAliveInterval 60/" /etc/ssh/sshd_config || echo "ClientAliveInterval 60" >> /etc/ssh/sshd_config
egrep -q "^\s*.*ClientAliveCountMax\s\w+.*$" /etc/ssh/sshd_config && sed -ri "s/^\s*.*ClientAliveCountMax\s\w+.*$/ClientAliveCountMax 30/" /etc/ssh/sshd_config || echo "ClientAliveCountMax 30" >> /etc/ssh/sshd_config

green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
[[ $EUID -ne 0 ]] && su='sudo' 
lsattr /etc/passwd /etc/shadow >/dev/null 2>&1
chattr -i /etc/passwd /etc/shadow >/dev/null 2>&1
chattr -a /etc/passwd /etc/shadow >/dev/null 2>&1
lsattr /etc/passwd /etc/shadow >/dev/null 2>&1
prl=`grep PermitRootLogin /etc/ssh/sshd_config`
pa=`grep PasswordAuthentication /etc/ssh/sshd_config`
if [[ -n $prl && -n $pa ]]; then
read -p "自定义root密码:" mima
echo root:$mima | $su chpasswd root
$su sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
$su sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
$su service sshd restart
green "VPS当前用户名：root"
green "vps当前root密码：$mima"
else
red "当前vps不支持root账户或无法自定义root密码" && exit 1
fi