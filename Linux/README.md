# 自用一键脚本

<br />

		bash -c "$(curl -fsSL https://gwen124.ml/tools.sh)"

<br />
		
#



---

<details>
<summary>🔻ZeroTier Moon搭建🔻</summary>
<br>

- 安装ZeroTier后先保存本机[ d71XXXXXX ]地址
```sh
*** Waiting for identity generation...

*** Success! You are ZeroTier address [ d71XXXXXX ]
```

- 云服务器填写ZeroTier ID加入虚拟网络
```sh
sudo zerotier-cli join 8bd5124fd****3d4
```

- 配置 Moon
- 进入 zerotier-one 程序所在的目录，默认为 /var/lib/zerotier-one。
```sh
cd /var/lib/zerotier-one
```

- 生成 moon.json 配置文件
```sh
sudo zerotier-idtool initmoon identity.public >> moon.json
```

- 编辑 moon.json 配置文件
- 将配置文件中的 "stableEndpoints": [] 修改成 "stableEndpoints": ["ServerIP/9993"]，将 ServerIP 替换成云服务器的公网IP。
```sh
sudo nano moon.json
```

- 生成 .moon 文件
```sh
sudo zerotier-idtool genmoon moon.json
```

- 将生成的 000000xxxxxxxxxx.moon 移动到 moons.d 目录
- moon 配置文件的名一般为10个前导零+本机的节点ID
```sh
sudo mkdir moons.d
sudo mv ./*.moon ./moons.d/
```

- 重启 zerotier-one 服务
```sh
sudo systemctl restart zerotier-one
```

- 客户端加入 Moon
- 将命令中的两组 xxxxxxxxxx 都替换成 moon 的节点ID（本机ZeroTier地址）。
```sh
zerotier-cli orbit xxxxxxxxxx xxxxxxxxxx
```

- 检查是否添加成功
```sh
zerotier-cli listpeers
```

<br />
</details>

---
