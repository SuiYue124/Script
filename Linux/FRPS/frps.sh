#!/bin/bash
if [ "$(uname -m)" = "x86_64" ]; then
  wget https://raw.githubusercontent.com/GWen124/Script/master/Linux/FRPS/AMD-install-frps.sh -O ./install-frps.sh && rm install-frps.sh
elif [ "$(uname -m)" = "aarch64" ]; then
  wget https://raw.githubusercontent.com/GWen124/Script/master/Linux/FRPS/ARM-install-frps.sh -O ./install-frps.sh && rm install-frps.sh
else
  echo "未知的系统架构"
fi
rm -rf $0
