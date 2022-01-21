# !/usr/bin/env python3
# -*- coding: utf-8 -*-
# Telegram自动签到

'''
new Env('Telegram自动签到');
cron=0 12 * * * python3 AutoCheckin.py
'''

import os
import time
from telethon import TelegramClient, events, sync

api_id = [012345,34567]	#输入api_id，一个账号一项
api_hash = ['asdfadsgasdg3dbsrhwerb','adfawg4qg43h34hwg3qw4g']	#输入api_hash，一个账号一项

robot_map = {'@BywaveguguBot':'/checkin','@WooMaiBot':'/check_in'}

session_name = api_id[:]
for num in range(len(api_id)):
	session_name[num] = "id_" + str(session_name[num])
	client = TelegramClient(session_name[num], api_id[num], api_hash[num])
	client.start()
	for (k,v) in robot_map.items():
		print("Start checkin: ", k)
		client.send_message(k, v) #设置机器人和签到命令
		time.sleep(3)
		client.send_read_acknowledge(k)	#将机器人回应设为已读
	print("Done! Session name:", session_name[num])	
os._exit(0)