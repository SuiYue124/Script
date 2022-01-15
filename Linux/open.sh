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