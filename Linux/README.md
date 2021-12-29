# 说明

## VPS密钥账户改成ROOT登陆
- **获取root权限，更改密码**。
```shell
sudo -i
passwd							# 默认密码为password（或者更改脚本内默认密码）
```
- **执行脚本**
```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/root.sh)"
```
- **更改自己的密码**。


## VPS端口开放 
```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/openport.sh)"
```

## 解决Ubuntu超时掉线的问题 
```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/ClientAliveInterval.sh)"
```

## VPS时间修改
```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/Time.sh)"
```

## [测试解锁流媒体情况](https://github.com/lmc999/RegionRestrictionCheck)
```shell
bash <(curl -L -s https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh)
```

## [FRPS](https://github.com/MvsCode/frps-onekey)
- **GitHub、阿里云二选一**
```shell
sudo -i
```
- **GitHub**
```shell
wget https://raw.githubusercontent.com/MvsCode/frps-onekey/master/install-frps.sh -O ./install-frps.sh
```
- **阿里云**
```shell
wget https://code.aliyun.com/MvsCode/frps-onekey/raw/master/install-frps.sh -O ./install-frps.sh
```
- **安装**
```shell
chmod 700 ./install-frps.sh&&./install-frps.sh install
```

## [宝塔面板](https://github.com/aaPanel/BaoTa)
- **安装宝塔面板**
```shell
wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh && bash install.sh
```
- **宝塔面板无需手机登陆**
```shell
echo "{\"uid\":1000,\"username\":\"admin\",\"serverid\":1}" > /www/server/panel/data/userInfo.json
```

## [TG代理一键搭建](https://github.com/cutelua/mtg-dist)
- **输入命令后显示**：`> Input service PORT, or press Enter to use a random port` **这个是输入您要设置端口，不设置的话回车默认端口**
- **然后显示**：`> Input a domain for FakeTLS, or press Enter to use "hostupdate.vmware.com"` **回车默认hostupdate.vmware.com，可以输入 FakeTLS 改协议**
- **搭建好以后要查看TG代理链接，输入**：mtg access /etc/mtg.toml
```shell
bash <(wget -qO- https://git.io/mtg.sh)
```

## [X-UI面板](https://github.com/vaxilu/x-ui)（建议搭配宝塔面板使用）
```shell
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
```

## 一个检查NetFlix和DisneyPlus的脚本
### [NetFlix](https://github.com/sjlleo/netflix-verify)
- **X86_64**：
```shell
wget -O nf https://github.com/sjlleo/netflix-verify/releases/download/2.61/nf_2.61_linux_amd64 && chmod +x nf && clear && ./nf
```
- **CDN Mirror (For IPv6)**:
```shell
wget -O nf https://cdn.jsdelivr.net/gh/sjlleo/netflix-verify/CDNRelease/nf_2.61_linux_amd64 && chmod +x nf && clear && ./nf
```
- **ARM64**：
```shell
wget -O nf https://github.com/sjlleo/netflix-verify/releases/download/2.61/nf_2.61_linux_arm64 && chmod +x nf && clear && ./nf
```
### [DisneyPlus](https://github.com/sjlleo/VerifyDisneyPlus)
```shell
  wget -O dp https://github.com/sjlleo/VerifyDisneyPlus/releases/download/1.01/dp_1.01_linux_amd64 && chmod +x dp && clear && ./dp
```

## BBR+锐速一键脚本2021 BBR+锐速一键脚本
### 分为两个版本：
- **不卸载内核**:
```shell
wget -N --no-check-certificate "https://github.000060000.xyz/tcpx.sh"; chmod +x tcpx.sh
```
- **不卸载内核**:
```shell
wget -N --no-check-certificate "https://github.000060000.xyz/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
```

## 各种测试脚本
### [bench.sh](https://github.com/teddysun/across)
- **查看Linux 系统信息，测试网络带宽（到世界主要机房）及硬盘读写速率**
```shell
wget -qO- bench.sh | bash
```
**或**
```shell
curl -Lso- bench.sh | bash
```
- [Superspeed.sh](https://github.com/ernisn/superspeed)
- **使用全国各地三大运营商的 speedtest 测速节点进行全面测速，主要是对国内的测速。**
```shell
bash <(curl -Lso- https://git.io/superspeed)
```
### [测试回程Ping值](https://github.com/helloxz/mping)
```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/helloxz/mping/master/mping.sh)"
```