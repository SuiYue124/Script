#!/bin/bash

iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F
apt-get -y purge netfilter-persistent
yellow "原生系统防火墙禁用成功"
