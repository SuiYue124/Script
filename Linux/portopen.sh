#!/bin/bash

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