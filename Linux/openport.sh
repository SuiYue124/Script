#!/bin/bash
iptables -P INPUT ACCEPT &&
iptables -P FORWARD ACCEPT &&
iptables -P OUTPUT ACCEPT &&
iptables -F &&
apt-get -y purge netfilter-persistent &&
reboot