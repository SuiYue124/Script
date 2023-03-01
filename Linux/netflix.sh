#!/bin/bash
if [ "$(uname -m)" = "x86_64" ]; then
  wget -O nf https://github.com/sjlleo/netflix-verify/releases/latest/download/nf_linux_amd64 && chmod +x nf && ./nf && rm nf
elif [ "$(uname -m)" = "aarch64" ]; then
  wget -O nf https://github.com/sjlleo/netflix-verify/releases/latest/download/nf_linux_arm64 && chmod +x nf && ./nf && rm nf
else
  echo "未知的系统架构"
fi
rm -rf $0
