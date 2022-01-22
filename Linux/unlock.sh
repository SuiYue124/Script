#!/bin/bash
# By GWen124
blue(){
    echo -e "\033[34m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}


nf86(){
  wget -O nf https://github.com/sjlleo/netflix-verify/releases/download/2.61/nf_2.61_linux_amd64 && chmod +x nf && clear && ./nf
}

nfarm(){
  wget -O nf https://github.com/sjlleo/netflix-verify/releases/download/2.61/nf_2.61_linux_arm64 && chmod +x nf && clear && ./nf
}

dp86(){
   wget -O dp https://github.com/sjlleo/VerifyDisneyPlus/releases/download/1.01/dp_1.01_linux_amd64 && chmod +x dp && clear && ./dp
}

dparm(){
  wget -O dp https://github.com/sjlleo/VerifyDisneyPlus/releases/download/1.01/dp_1.01_linux_arm64 && chmod +x dp && clear && ./dp
}

youtube86(){
  wget -O tubecheck https://cdn.jsdelivr.net/gh/sjlleo/TubeCheck/CDN/tubecheck_1.0beta_linux_amd64 && chmod +x tubecheck && clear && ./tubecheck
}

youtubearm(){
  wget -O tubecheck https://github.com/sjlleo/TubeCheck/releases/download/1.0Beta/tubecheck_1.0beta_linux_arm64 && chmod +x tubecheck && clear && ./tubecheck
}

liumeiti(){
  bash <(curl -L -s https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh)
}



start_menu(){
    clear
	green "==================================流媒体解锁检测================================="
	 yellow " 1. 启动Netflix检测脚本（X86） "
	 yellow " 2. 启动Netflix检测脚本（ARM） "
	 yellow " 3. 启动DisneyPlus检测脚本（X86） "
	 yellow " 4. 启动DisneyPlus检测脚本（ARM） "
	 yellow " 5. Youtube 缓存节点、地域信息检测（X86） "
	 yellow " 6. Youtube 缓存节点、地域信息检测（ARM） "
	 yellow " 7. 流媒体一键检测脚本 "
	 green "================================================================================="
     red " 0. 退出脚本 "
	 green "================================================================================="
    echo
    read -p "请输入数字:" num
    case "$num" in
		1)
		nf86
		;;
		2)
		nfarm
		;;
		3)
	    dp86
		;;
		4)
		dparm
		;;
		5)
	    youtube86
		;;
		6)
	    youtubearm
		;;
		7)
		liumeiti
		;;
		0)
		exit 0
		;;
		*)
	clear
	echo "请输入正确数字"
	sleep 2s
	start_menu
	;;
    esac
}

start_menu