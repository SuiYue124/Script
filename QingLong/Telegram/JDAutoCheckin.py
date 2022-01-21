# !/usr/bin/env python3
# -*- coding: utf-8 -*-
# Telegram自动签到

'''
new Env('京东助力Telegram提交');
cron=30 0 * * * 1 python3 JDAutoCheckin.py
'''

import os
import time
from telethon import TelegramClient, events, sync
api_id = [0123456, 6543210]	#输入api_id，一个账号一项
api_hash = ['0123456789abcdef0123456789abcdef', 'abcdef0123456789abcdef0123456789']	#输入api_hash，一个账号一项
session_name = api_id[:]
for num in range(len(api_id)):
	session_name[num] = "id_" + str(session_name[num])
	client = TelegramClient(session_name[num], api_id[num], api_hash[num])
	client.start(3)
	client.send_message("@JD_ShareCode_Bot", '/farm 1234567890123456')	
	time.sleep(3)
	client.send_message("@JD_ShareCode_Bot", '/farm 1234567890123456')	
	time.sleep(3)
	client.send_message("@JD_ShareCode_Bot", '/farm 1234567890123456')	
	time.sleep(3)
	client.send_message("@JD_ShareCode_Bot", '/farm 1234567890123456')	
	time.sleep(3)
	client.send_message("@JD_ShareCode_Bot", '/farm 1234567890123456')	
	time.sleep(3)
	client.send_message("@JD_ShareCode_Bot", '/farm 1234567890123456')	
	time.sleep(3)
	client.send_message("@JD_ShareCode_Bot", '/farm 1234567890123456')	
	time.sleep(5)	#延时5秒，等待机器人回应（一般是秒回应，但也有发生阻塞的可能）
	client.send_read_acknowledge("@luxiaoxun_bot")	#将机器人回应设为已读
	print("Done! Session name:", session_name[num])
	
os._exit(0)