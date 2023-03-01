[[ $EUID -ne 0 ]] && su='sudo' 
lsattr /etc/passwd /etc/shadow >/dev/null 2>&1
chattr -i /etc/passwd /etc/shadow >/dev/null 2>&1
chattr -a /etc/passwd /etc/shadow >/dev/null 2>&1
lsattr /etc/passwd /etc/shadow >/dev/null 2>&1
prl=`grep PermitRootLogin /etc/ssh/sshd_config`
pa=`grep PasswordAuthentication /etc/ssh/sshd_config`
if [[ -n $prl && -n $pa ]]; then
readp "自定义root密码:" mima
if [[ -n $mima ]]; then
echo root:$mima | $su chpasswd root
$su sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
$su sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
$su service sshd restart
green "VPS当前用户名：root"
green "vps当前root密码：$mima"
echo "                            "
yellow "请妥善保管好登录信息！然后重启VPS确保设置已保存！"
echo "                            "
else
red "当前vps不支持root账户或无法自定义root密码" && exit 1
fi
rm -rf root.sh
