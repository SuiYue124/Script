# 说明
<details>
<summary>🔻Freenom 续期🔻</summary>
<br>

1. 修改配置文件

    ```sh
    RepoFileExtensions="js py ts html"
    ```

2. 添加定时拉取任务并运行

    ```sh
    ql raw https://raw.githubusercontent.com/GWen124/Script/master/QingLong/Freenom/FNplus.py
    ```

3. 添加环境变量 

| 变量 / key   | 描述                     | 示例 / value                        |
| ------------ | ------------------------ | ----------------------------------- |
| FN_ID        | Freenom 用户名           | 1234567890@gmail.com                |
| FN_PW        | Freenom 密码             | 12345678                            |
| MAIL_USER    | 发件人邮箱用户名         | address@vip.qq.com 或 123456@qq.com |
| MAIL_ADDRESS | 发件人邮箱地址           | address@vip.qq.com 或 123456@qq.com |
| MAIL_PW      | 发件人邮箱授权码         | xxxxxxxxxxxxxxxx 看下方链接         |
| MAIL_HOST    | 发件人邮箱服务器         | smtp.qq.com 不填默认为这个          |
| MAIL_PORT    | 邮箱服务器端口           | 465 不填默认为这个                  |
| MAIL_TO      | 收件人邮箱可与发件人相同 | address@vip.qq.com 或 123456@qq.com |

4. 运行一次 `FN_extend.py` 测试

<br />
</details>
