#!/bin/bash
echo "127.0.0.1    proxy manager" | sudo tee -a /etc/hosts
mkdir -p /home/Docke/Nginx\ Proxy\ Manager
wget -P /home/Docke/Nginx\ Proxy\ Manager https://raw.githubusercontent.com/GWen124/Script/master/Linux/Docker/Nginx%20Proxy%20Manager/docker-compose.yml
cd /home/Docke/Nginx\ Proxy\ Manager && docker-compose up -d
if [ $? -eq 0 ]; then
  echo "容器启动成功！"
else
  echo "容器启动失败！"
fi

