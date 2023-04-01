import os
import time

# 设定阈值为 122880MB
threshold = 122880

# 指定要删除的文件路径和名称
filename = "/path/to/your/file"

# 设定默认延迟时间为 30 分钟（单位：秒）
default_delay_time_mins = 30
default_delay_time_secs = default_delay_time_mins * 60

# 获取指定目录的可用空间信息
statvfs = os.statvfs(os.path.dirname(filename))
free_space = statvfs.f_frsize * statvfs.f_bavail / (1024 ** 2)

if free_space < threshold:
    # 如果当前目录可用空间不足，则等待指定的延迟时间后再检查容量是否达到删除阈值
    time.sleep(default_delay_time_secs)
    statvfs = os.statvfs(os.path.dirname(filename))
    free_space = statvfs.f_frsize * statvfs.f_bavail / (1024 ** 2)
    if free_space < threshold:
        os.remove(filename)
else:
    # 目录可用空间充足，直接删除指定文件
    os.remove(filename)
