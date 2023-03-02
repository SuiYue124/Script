#!/bin/bash
if [ "$(id -u)" != "0" ]; then
  echo "此脚本必须以root用户身份运行" 1>&2
  exit 1
fi
if find /var/log/ -type f -delete; then
  echo "所有日志文件已成功删除"
  if rm -- "$0"; then
    echo "脚本已成功删除"
  else
    echo "删除脚本时发生错误"
  fi
else
  echo "删除日志文件时发生错误"
fi
