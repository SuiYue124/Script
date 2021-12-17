# 说明

- 解决Ubuntu超时掉线的问题 
```yaml
bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/ClientAliveInterval.sh)"
```


- FRPS

GitHub
```yaml
wget https://raw.githubusercontent.com/MvsCode/frps-onekey/master/install-frps.sh -O ./install-frps.sh
```
阿里云
```yaml
wget https://code.aliyun.com/MvsCode/frps-onekey/raw/master/install-frps.sh -O ./install-frps.sh
```
```yaml
chmod 700 ./install-frps.sh
```
```yaml
./install-frps.sh install
```


- VPS密钥账户改成ROOT登陆
获取root全选
```yaml
sudo -i
```
更改密码，默认密码为123456（或者更改脚本内默认密码）
```yaml
passwd
```
执行脚本
```yaml
bash -c "$(curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/Linux/root.sh)"
```
更改自己的密码。
```yaml
passwd
```