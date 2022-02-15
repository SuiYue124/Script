# 说明
### 饿了么吃货豆-elm.js
```
h5.ele.me
export elmck='SID=***'
```
### 滴滴果园-dd_fruit.js
```
game.xiaojukeji.com
export DD_TOKEN='token1,token2'
```
### 快手果园ks_fruit.js
```
ug-fission.kuaishou.com
export KS_COOKIE='client_key=***;did=***;kuaishou.api_st=***;ud=***;ver=***;'
```
### 美团-meituan.js，mt_fruit.js
```
浏览器抓包
进美团官网：https://www.meituan.com
F12审查元素-登录账号-工作台选 网络，找到www.meituan.com的封包，Cookie中找到token值，复制出来
export mtTk='这里填token值，不带分号'
可关闭神券膨胀，不想关，删除变量
export sjpz="false"
```
### 中国联通-Chinaunicom.js
<details>
<summary>说明</summary>

功能：签到，签到任务，多账号用 @ 分隔

	export ltphone="" #手机号

	export ltpwd="" #登录6位密码

</details>