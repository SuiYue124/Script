# 说明

### VPS密钥账户改成ROOT登陆
- 获取root权限，更改密码。
```yaml
sudo -i
passwd							# 默认密码为password（或者更改脚本内默认密码）
```
- 执行脚本
```yaml
bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/root.sh)"
```
- 更改自己的密码。


### VPS端口开放 
```yaml
bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/openport.sh)"
```

### 解决Ubuntu超时掉线的问题 
```yaml
bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/ClientAliveInterval.sh)"
```

### VPS时间修改
```yaml
bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/Time.sh)"
```

### [测试回程Ping值](https://github.com/helloxz/mping)
```yaml
bash -c "$(curl -fsSL https://raw.githubusercontent.com/helloxz/mping/master/mping.sh)"
```

### [测试解锁流媒体情况](https://github.com/lmc999/RegionRestrictionCheck)
```yaml
bash <(curl -L -s https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh)
```

### [FRPS](https://github.com/MvsCode/frps-onekey)
- GitHub、阿里云二选一
- GitHub
```yaml
sudo -i
```
```yaml
wget https://raw.githubusercontent.com/MvsCode/frps-onekey/master/install-frps.sh -O ./install-frps.sh
```
- 阿里云
```yaml
wget https://code.aliyun.com/MvsCode/frps-onekey/raw/master/install-frps.sh -O ./install-frps.sh
```
```yaml
chmod 700 ./install-frps.sh&&./install-frps.sh install
```

### [宝塔面板](https://github.com/aaPanel/BaoTa)
- 安装宝塔面板
```yaml
wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh && bash install.sh
```
- 宝塔面板无需手机登陆
```yaml
sed -i "s|bind_user == 'True'|bind_user == 'XXXX'|" /www/server/panel/BTPanel/static/js/index.js
```

### [TG代理一键搭建](https://github.com/cutelua/mtg-dist)
- 输入命令后显示：`> Input service PORT, or press Enter to use a random port` 这个是输入您要设置端口，不设置的话回车默认端口
- 然后显示：`> Input a domain for FakeTLS, or press Enter to use "hostupdate.vmware.com"` 回车默认hostupdate.vmware.com，可以输入 FakeTLS 改协议
- 搭建好以后要查看TG代理链接，输入：mtg access /etc/mtg.toml
```yaml
bash <(wget -qO- https://git.io/mtg.sh)
```

### [X-UI面板](https://github.com/vaxilu/x-ui)建议搭配宝塔面板使用
```yaml
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
```