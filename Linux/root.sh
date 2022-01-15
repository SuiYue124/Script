#!/bin/bash
#  时区与地区设置: 
sudo cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
sudo timedatectl set-timezone Asia/Shanghai
# 将当前的 UTC 时间写入硬件时钟 (硬件时间默认为UTC)
sudo timedatectl set-local-rtc 0
# 启用NTP时间同步：
sudo timedatectl set-ntp yes

# 防火墙设置
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F
apt-get -y purge netfilter-persistent

# 超时设置
egrep -q "^\s*.*ClientAliveInterval\s\w+.*$" /etc/ssh/sshd_config && sed -ri "s/^\s*.*ClientAliveInterval\s\w+.*$/ClientAliveInterval 60/" /etc/ssh/sshd_config || echo "ClientAliveInterval 60" >> /etc/ssh/sshd_config
egrep -q "^\s*.*ClientAliveCountMax\s\w+.*$" /etc/ssh/sshd_config && sed -ri "s/^\s*.*ClientAliveCountMax\s\w+.*$/ClientAliveCountMax 30/" /etc/ssh/sshd_config || echo "ClientAliveCountMax 30" >> /etc/ssh/sshd_config

# 允许root认证登录及允许密码认证
sudo lsattr /etc/passwd /etc/shadow
sudo chattr -i /etc/passwd /etc/shadow
sudo chattr -a /etc/passwd /etc/shadow
sudo lsattr /etc/passwd /etc/shadow
read -p "你设置的ROOT密码:" mima
echo root:$mima | sudo chpasswd root
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
sudo service sshd restart
sudo reboot