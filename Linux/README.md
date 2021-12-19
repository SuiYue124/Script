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

### 测试回程Ping值
```yaml
bash -c "$(curl -fsSL https://raw.githubusercontent.com/helloxz/mping/master/mping.sh)"
```

### FRPS（GitHub、阿里云二选一）
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

### 宝塔面板
- 安装宝塔面板
```yaml
wget -O install.sh http://download.bt.cn/install/install-ubuntu_6.0.sh && bash install.sh
```
- 宝塔面板无需手机登陆
```yaml
echo "{\"uid\":1000,\"username\":\"admin\",\"serverid\":1}" > /www/server/panel/data/userInfo.json
```

