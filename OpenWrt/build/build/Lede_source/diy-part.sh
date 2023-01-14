#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
# DIY扩展二合一了，在此处可以增加插件
# 自行拉取插件之前请SSH连接进入固件配置里面确认过没有你要的插件再单独拉取你需要的插件
# 不要一下就拉取别人一个插件包N多插件的，多了没用，增加编译错误，自己需要的才好
# 修改IP项的EOF于EOF之间请不要插入其他扩展代码，可以删除或注释里面原本的代码

TIME() {
[[ -z "$1" ]] && {
	echo -ne " "
} || {
     case $1 in
	r) export Color="\e[31;1m";;
	g) export Color="\e[32;1m";;
	b) export Color="\e[34;1m";;
	y) export Color="\e[33;1m";;
	z) export Color="\e[35;1m";;
	l) export Color="\e[36;1m";;
      esac
	[[ $# -lt 2 ]] && echo -e "\e[36m\e[0m ${1}" || {
		echo -e "\e[36m\e[0m ${Color}${2}\e[0m"
	 }
      }
}
echo
TIME r "删除无用主题"
rm -rf ./feeds/freifunk/themes
rm -rf ./feeds/luci/themes/luci-theme-argon
rm -rf ./feeds/luci/themes/luci-theme-material
TIME r "删除重复插件"
rm -rf ./feeds/packages/admin/netdata
rm -rf ./feeds/luci/applications/luci-app-netdata
rm -rf ./feeds/luci/applications/luci-app-serverchan
rm -rf ./feeds/luci/applications/luci-app-pushbot
# rm -rf ./feeds/luci/applications/luci-app-unblockmusic
rm -rf ./feeds/packages/net/mosdns
echo 
TIME y "添加软件包"
rm -rf package/GWen124 && git clone https://github.com/GWen124/OpenWrt-Software package/GWen124
echo
TIME b "修改 系统文件..."
# curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/OpenWrt/zzz-default-settings > ./package/lean/default-settings/files/zzz-default-settings
curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/OpenWrt/index.htm > ./package/lean/autocore/files/x86/index.htm
curl -fsSL https://raw.githubusercontent.com/GWen124/Script/master/OpenWrt/ethinfo > ./package/lean/autocore/files/x86/sbin/ethinfo
# curl -fsSL https://github.com/GWen124/Script/blob/master/OpenWrt/autocore > ./package/lean/autocore/files/x86/autocore
# curl -fsSL https://github.com/GWen124/Script/blob/master/OpenWrt/tempinfo > ./package/lean/autocore/files/x86/sbin/tempinfo
# curl -fsSL https://github.com/GWen124/Script/blob/master/OpenWrt/cntime > ./package/lean/autocore/files/x86/sbin/cntime
# curl -fsSL https://github.com/GWen124/Script/blob/master/OpenWrt/cpuinfo > ./package/lean/autocore/files/x86/sbin/cpuinfo

# rm -rf ./package/lean/autocore/files/x86/sbin/getcpu
TIME b "系统文件 修改完成"

#echo 
#TIME y "更换内核为5.4"
#sed -i 's/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=5.4/g' ./target/linux/x86/Makefile

echo 
TIME y "更新固件 编译日期"
sed -i "s/2022.02.01/$(TZ=UTC-8 date "+%Y.%m.%d")/g" package/lean/autocore/files/x86/index.htm

echo 
TIME y "自定义固件版本名字"
sed -i "s/OpenWrt /AutoBuild Firmware Compiled By @GWen124 build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" $ZZZ

echo
TIME y "更换golang版本"
rm -rf feeds/packages/lang/golang
svn export https://github.com/sbwml/packages_lang_golang/branches/19.x feeds/packages/lang/golang

echo 
TIME y "调整网络诊断地址到www.baidu.com"
sed -i "/exit 0/d" package/lean/default-settings/files/zzz-default-settings
cat <<EOF >>package/lean/default-settings/files/zzz-default-settings
uci set luci.diag.ping=www.baidu.com
uci set luci.diag.route=www.baidu.com
uci set luci.diag.dns=www.baidu.com
uci commit luci
exit 0
EOF

echo 
TIME y ”关闭开机串口跑码“
sed -i 's/console=tty0//g'  target/linux/x86/image/Makefile

# ttyd设置空密码
#sed -i 's/\/bin\/login/\/bin\/login -f root/' /etc/config/ttyd

echo 
TIME y "修改连接数"
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

## containerd临时关闭hash验证
#sed -i 's/PKG_HASH.*/PKG_HASH:=skip/' feeds/packages/utils/containerd/Makefile

echo
TIME b "菜单 调整..."
sed -i 's/\"services\"/\"control\"/g' feeds/luci/applications/luci-app-wol/luasrc/controller/wol.lua
#sed -i 's/\"services\"/\"control\"/g' package/GWen124/luci-app-accesscontrol-plus/luasrc/controller/miaplus.lua
sed -i 's/\"network\"/\"control\"/g'  package/GWen124/luci-app-oaf/luci-app-oaf/luasrc/controller/appfilter.lua
echo             
TIME b "插件 重命名..."
echo "重命名系统菜单"
#system menu
sed -i 's/"Web 管理"/"Web管理"/g' `grep "Web 管理" -rl ./`
sed -i 's/"备份\/升级"/"备份升级"/g' `grep "备份\/升级" -rl ./`
sed -i 's/"管理权"/"权限管理"/g' feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i 's/"重启"/"立即重启"/g' feeds/luci/modules/luci-base/po/zh-cn/base.po
#sed -i 's/"系统"/"系统设置"/g' feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i 's/"挂载点"/"挂载路径"/g' feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i 's/"启动项"/"启动管理"/g' feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i 's/"软件包"/"软件管理"/g' feeds/luci/modules/luci-base/po/zh-cn/base.po
sed -i 's/"TTYD 终端"/"命令终端"/g' feeds/luci/applications/luci-app-ttyd/po/zh-cn/terminal.po
sed -i 's/"Argon 主题设置"/"主题设置"/g' `grep "Argon 主题设置" -rl ./`
echo "重命名控制菜单"
#others
sed -i 's/"网络存储"/"存储"/g' `grep "网络存储" -rl ./`
sed -i 's/"Turbo ACC 网络加速"/"网络加速"/g' feeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po
sed -i 's/"实时流量监测"/"流量"/g' `grep "实时流量监测" -rl ./`
sed -i 's/"USB 打印服务器"/"打印服务"/g' `grep "USB 打印服务器" -rl ./`
sed -i 's/"带宽监控"/"监控"/g' `grep "带宽监控" -rl ./`
sed -i 's/"在线用户"/"在线设备"/g' package/GWen124/luci-app-onliner/luasrc/controller/onliner.lua
#sed -i 's/"上网时间控制Plus"/"上网时间"/g' package/GWen124/luci-app-accesscontrol-plus/po/zh-cn/miaplus.po
#sed -i 's/"autoipsetadder"/"自动设置IP"/g' `grep "autoipsetadder" -rl ./`
echo "重命名服务菜单"
#services menu
sed -i 's/"解锁网易云灰色歌曲"/"网易音乐"/g' feeds/luci/applications/luci-app-unblockmusic/po/zh-cn/unblockmusic.po
#sed -i 's/天翼家庭云\/云盘提速/天翼云盘/g' feeds/luci/applications/luci-app-familycloud/luasrc/controller/familycloud.lua
sed -i 's/"AdGuard Home"/"AdHome"/g' `grep "AdGuard Home" -rl ./`
sed -i 's/"Frp 内网穿透"/"Frp客户端"/g' `grep "Frp 内网穿透" -rl ./`
sed -i 's/ShadowSocksR Plus+/SSR Plus+/g' package/GWen124/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
sed -i 's/msgstr "UPnP"/msgstr "UPnP服务"/g' feeds/luci/applications/luci-app-upnp/po/zh-cn/upnp.po
sed -i 's/Hello World/VssrVPN/g'  package/GWen124/luci-app-vssr/luasrc/controller/vssr.lua
sed -i 's/"Cloudflare速度测试"/"Cloudflare"/g' package/GWen124/luci-app-cloudflarespeedtest/po/zh-cn/cloudflarespeedtest.po
sed -i 's/"TelegramBot"/"Telegram"/g'  package/GWen124/luci-app-telegrambot/luasrc/controller/telegrambot.lua
#sed -i 's/"DDNS.to内网穿透"/"DDNSTO"/g' `grep "DDNS.to内网穿透" -rl ./`
#sed -i 's/"网页快捷菜单"/"快捷菜单"/g'  package/GWen124/luci-app-shortcutmenu/po/zh-cn/shortcutmenu.po
#sed -i 's/Adblock Plus+/Adb Plus+/g'  package/GWen124/luci-app-adblock-plus/luasrc/controller/adblock.lua
#sed -i 's/CPU占用率限制/CPU调节/g' package/GWen124/luci-app-cpulimit/po/zh_Hans/cpulimit.po
#sed -i 's/"KMS 服务器"/"KMS激活"/g' `grep "KMS 服务器" -rl ./`
#sed -i 's/"WebGuide"/"网页导航"/g' package/GWen124/luci-app-webguide/luasrc/controller/webguide.lua
#sed -i 's/"iKoolProxy 滤广告"/"广告过滤"/g' package/GWen124/luci-app-ikoolproxy/luasrc/controller/koolproxy.lua
#sed -i 's/"Nezha Agent"/"哪吒面板"/g'  package/GWen124/luci-app-nezha/luasrc/controller/nezha-agent.lua
#sed -i 's/"WebGuide"/"网页导航"/g'  package/GWen124/luci-app-webguide/luasrc/controller/webguide.lua
#sed -i 's/"Webd 网盘"/"WebDisk"/g'  package/GWen124/luci-app-webd/po/zh-cn/webd.po
#sed -i 's/"Go 阿里云盘 WebDAV"/"阿里云盘"/g' `grep "Go 阿里云盘 WebDAV" -rl ./`
#sed -i 's/"阿里云盘 WebDAV"/"阿里云盘"/g' `grep "阿里云盘 WebDAV" -rl ./`
#sed -i 's/京东签到服务/京东签到/g' feeds/luci/applications/luci-app-jd-dailybonus/luasrc/controller/jd-dailybonus.lua
#sed -i 's/"UU游戏加速器"/"UU加速器"/g' `grep "UU游戏加速器" -rl ./`
#sed -i 's/UU游戏加速器/UU加速器/g' feeds/luci/applications/luci-app-uugamebooster/po/zh-cn/uuplugin.po
#sed -i 's/"Rclone"/"Rclone挂载"/g' feeds/luci/applications/luci-app-rclone/luasrc/controller/rclone.lua
echo "重命名网络菜单"
#network
sed -i 's/"IP\/MAC绑定"/"地址绑定"/g' feeds/luci/applications/luci-app-arpbind/po/zh-cn/arpbind.po
#sed -i 's/"netports_info"/"网口信息"/g' `grep "netports_info" -rl ./`
sed -i 's/"主机名"/"主机名称"/g' `grep "主机名" -rl ./`
sed -i 's/"接口"/"网络接口"/g' `grep "接口" -rl ./`
echo "重命名存储菜单"
#nas
# sed -i 's/"文件浏览器"/"文件管理"/g' package/GWen124/luci-app-filebrowser/po/zh-cn/filebrowser.po
sed -i 's/"FTP 服务器"/"FTP 服务"/g' feeds/luci/applications/luci-app-vsftpd/po/zh-cn/vsftpd.po
sed -i 's/"Alist 文件列表"/"Alist列表"/g' package/GWen124/luci-app-alist/luci-app-alist/po/zh-cn/alist.po
#vpn
sed -i 's/"ZeroTier"/"ZeroTier虚拟网络"/g' feeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua
TIME b "重命名 完成"
echo
TIME b "自定义文件修复权限"
chmod -R 755 package/GWen124
echo
TIME g "配置更新完成"
