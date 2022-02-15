# 说明
### 饿了么吃货豆-elm.js
<details>
<summary>说明：</summary>
<br />
抓包：h5.ele.me
	
	export elmck='SID=***'
</details>

### 滴滴果园-dd_fruit.js
<details>
<summary>说明：</summary>
<br />
抓包：game.xiaojukeji.com
	
	export DD_TOKEN='token1,token2'
</details>

### 快手果园ks_fruit.js
<details>
<summary>说明：</summary>
<br />
抓包：ug-fission.kuaishou.com
	
	export KS_COOKIE='client_key=***;did=***;kuaishou.api_st=***;ud=***;ver=***;'
</details>

### 美团-meituan.js，mt_fruit.js
<details>
<summary>说明：</summary>
<br />
进美团官网抓包：https://www.meituan.com
Cookie中找到token值，复制出来

	export mtTk='这里填token值，不带分号'
	
可关闭神券膨胀，不想关，删除变量

	export sjpz="false"
</details>

### 中国联通-Chinaunicom.js
<details>
<summary>说明：</summary>
<br />
功能：签到，签到任务，多账号用 @ 分隔

	export ltphone="" #手机号

	export ltpwd="" #登录6位密码
</details>

### 腾讯自选股 txstock.js
<details>
<summary>说明：</summary>
<br />
注意：APP和公众号都要抓，多账号用#隔开


APP-头像-右上角金币-获取金币，抓get包

https://wzq.tenpay.com/cgi-bin/activity_task_daily.fcgi?


抓到的连接填在下方

    export TxStockAppUrl='https://wzq.ten....#https://wzq.ten....'


请求头header，转换一下格式 https://tooltt.com/header2json/

    export TxStockAppHeader='{"Host":"...","Accept":"..."}#{"Host":"...","Accept":"..."}'



自选股公众号-右下角好福利-福利中心，抓get包

https://wzq.tenpay.com/cgi-bin/activity_task_daily.fcgi?

请求头header，转换一下格式 https://tooltt.com/header2json/

    export TxStockWxHeader='{"Host":"...","Accept":"..."}#{"Host":"...","Accept":"..."}'



提现变量，0代表不提现，1代表提现1元，5代表提现5元

    export TxStockCash='1'

新手变量，0代表不做新手任务，1代表做新手任务

    export TxStockNewbie='1'

分享变量，0代表不做分享互助，1代表做分享互助

    export TxStockHelp='0'

互助变量，0代表不帮助其他用户，否则填用户，用@或者#隔开

    export TxStockHelpOrder='0'
</details>

