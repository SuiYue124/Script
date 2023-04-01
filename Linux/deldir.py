import shutil
import time

# 设定阈值为 122880MB，如不需要设定阈值，修改值为0。
threshold = 122880

# 指定要删除的目录路径
dir_path = "/path/to/your/dir"

# 设定默认延迟时间为 30 分钟，值为0时立即删除。
default_delay_time_mins = 30
default_delay_time_secs = default_delay_time_mins * 60

# 获取指定目录的使用空间信息
total, used, free = shutil.disk_usage(dir_path)

if used < threshold:
    # 如果当前目录使用空间未达到阈值，则退出脚本。
    exit()
else:
    # 如果当前目录使用空间已经超过阈值，则等待指定的延迟时间后再次检查使用空间是否已经超过阈值，
    # 如果已经超过阈值且阈值不为0，则直接删除指定目录及其中的所有文件和子目录；否则立即删除指定目录及其中的所有文件和子目录。
    if threshold != 0 and default_delay_time_secs > 0:
        time.sleep(default_delay_time_secs)
    total, used, free = shutil.disk_usage(dir_path)
    if used >= threshold or threshold == 0:
        shutil.rmtree(dir_path)
    else:
        exit()
