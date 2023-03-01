#!/bin/bash
if [ "$(uname -m)" = "x86_64" ]; then
  wget -O tubecheck https://cdn.jsdelivr.net/gh/sjlleo/TubeCheck/CDN/tubecheck_1.0beta_linux_amd64 && chmod +x tubecheck && clear && ./tubecheck && rm tubecheck
elif [ "$(uname -m)" = "aarch64" ]; then
  wget -O tubecheck https://github.com/sjlleo/TubeCheck/releases/download/1.0Beta/tubecheck_1.0beta_linux_arm64 && chmod +x tubecheck && clear && ./tubecheck && rm tubecheck
else
  echo "未知的系统架构"
fi
rm -rf $0
