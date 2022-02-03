#!/bin/bash

yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F
apt-get -y purge netfilter-persistent
yellow "原生系统防火墙禁用成功"
