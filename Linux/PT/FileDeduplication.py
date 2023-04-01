import os
import shutil

# 指定要处理的文件夹路径和保留顺序和优先级
folder_path = '/root/Wen/GoogleDrive/GoogleDriveWen'
keep_order = ['REMUX', 'UHD', '2160p', '1080p', '720p']
priority = {
    'CHD': 1,
    'CHDBits': 2,
    'CHDTV': 3,
    'HDS': 4,
    'HDSky': 5,
    'HDSTV': 6,
    'MTEAM': 7,
    'CNHK': 8,
    'WIKI': 9,
    'TTG': 10,
    'NGB': 11,
    'HDChina': 12,
    'CtrlHD': 13,
    'FRDS': 14,
    'BEITAI': 15,
    'CMCT': 16
}

# 扫描文件夹并获取符合条件的子文件夹
subfolders = []
for root, dirs, files in os.walk(folder_path):
    for dir in dirs:
        if any(keyword in dir.upper() for keyword in keep_order):
            subfolders.append(os.path.join(root, dir))

# 计算每个发布组下最高优先级的格式
max_priority = {}
for folder in subfolders:
    group_name = folder.split('-')[-1].split('@')[-1].split('.')[0].upper()
    file_format = [f for f in keep_order if f in folder.upper()][0]
    priority_score = priority.get(group_name, 999)
    if group_name not in max_priority or (priority_score < max_priority[group_name]['priority'] and file_format == 'REMUX'):
        max_priority[group_name] = {'format': file_format, 'priority': priority_score, 'path': folder}

# 根据保留顺序和优先级对子文件夹排序
sorted_folders = [folder for keyword in keep_order for folder in subfolders if keyword in folder.upper()]

# 删除排序后的剩余文件夹
for folder in sorted_folders[:-1]:
    group_name = folder.split('-')[-1].split('@')[-1].split('.')[0].upper()
    file_format = [f for f in keep_order if f in folder.upper()][0]
    if max_priority[group_name]['format'] == file_format:
        print(f'Keeping {folder}')
    else:
        print(f'Deleting {folder}')
        shutil.rmtree(folder)
