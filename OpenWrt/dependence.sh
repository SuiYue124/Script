#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) ImmortalWrt.org

function Delete_useless(){
if [[ "${SOURCE_CODE}" == "AMLOGIC" ]]; then
  echo "清理ubuntu无用插件,扩展空间"
  docker rmi `docker images -q`
  sudo -E apt-get -qq remove -y --purge azure-cli ghc* zulu* llvm* firefox google* powershell openjdk* msodbcsql17 mongodb* moby* snapd* mysql*
fi
sudo rm -rf /etc/apt/sources.list.d/* /usr/share/dotnet /usr/local/lib/android /usr/lib/jvm /opt/ghc /swapfile
}

function install_mustrelyon(){
# 安装大雕列出的编译openwrt依赖
${INS} update -y
${INS} full-upgrade -y
${INS} install -y ack antlr3 aria2 asciidoc autoconf automake autopoint binutils bison build-essential \
bzip2 ccache cmake cpio curl device-tree-compiler fastjar flex gawk gettext gcc-multilib g++-multilib \
git gperf haveged help2man intltool libc6-dev-i386 libelf-dev libglib2.0-dev libgmp3-dev libltdl-dev \
libmpc-dev libmpfr-dev libncurses5-dev libncursesw5-dev libreadline-dev libssl-dev libtool lrzsz \
mkisofs msmtp nano ninja-build p7zip p7zip-full patch pkgconf python2.7 python3 python3-pip libpython3-dev qemu-utils \
rsync scons squashfs-tools subversion swig texinfo uglifyjs upx-ucl unzip vim wget xmlto xxd zlib1g-dev
}

function ophub_amlogic-s9xxx(){
# 安装我仓库需要的依赖
${INS} install -y rename pigz libfuse-dev
# 安装打包N1需要用到的依赖
${INS} install -y $(curl -fsSL https://is.gd/depend_ubuntu2204_openwrt)
}

function update_apt_source(){
# 安装nodejs 16 和yarn
${INS} install -y apt-transport-https gnupg2
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
${INS} install -y nodejs gcc g++ make
${INS} update -y
${INS} install -y yarn

node --version
yarn --version

${INS} autoremove -y --purge
${INS} clean
}

function main(){
	if [[ -n "${BENDI_VERSION}" ]]; then
		INS="sudo apt-get"
		echo "开始升级ubuntu插件和安装依赖....."
		install_mustrelyon
		ophub_amlogic-s9xxx
		update_apt_source
	else
		INS="sudo -E apt-get -qq"
		Delete_useless
		install_mustrelyon
		ophub_amlogic-s9xxx
		update_apt_source
	fi
}

main