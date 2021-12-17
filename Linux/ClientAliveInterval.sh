#!/bin/bash
# 设置登录超时时间为10分钟 
egrep -q "^\s*.*ClientAliveInterval\s\w+.*$" /etc/ssh/sshd_config && sed -ri "s/^\s*.*ClientAliveInterval\s\w+.*$/ClientAliveInterval 600/" /etc/ssh/sshd_config || echo "ClientAliveInterval 600" >> /etc/ssh/sshd_config
egrep -q "^\s*.*ClientAliveCountMax\s\w+.*$" /etc/ssh/sshd_config && sed -ri "s/^\s*.*ClientAliveCountMax\s\w+.*$/ClientAliveCountMax 3/" /etc/ssh/sshd_config || echo "ClientAliveCountMax 3" >> /etc/ssh/sshd_config