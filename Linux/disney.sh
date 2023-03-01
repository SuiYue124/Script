#!/bin/bash
if [ "$(uname -m)" = "x86_64" ]; then
  wget -O dp https://github.com/sjlleo/VerifyDisneyPlus/releases/download/1.0Beta/dp_1.0Beta_linux_amd64 && chmod +x dp && clear && ./dp && rm dp
elif [ "$(uname -m)" = "aarch64" ]; then
  wget -O dp https://github.com/sjlleo/VerifyDisneyPlus/releases/download/1.0Beta/dp_1.0Beta_linux_arm64 && chmod +x dp && clear && ./dp && rm dp
else
  echo "未知的系统架构"
fi
rm -rf $0
