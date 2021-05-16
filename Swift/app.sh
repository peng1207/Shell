# app文件夹名称
app_folder_name="APP"
# Modules文件夹名称
modules_folder_name="Modules"
#Utility文件夹名称
utility_folder_name="Utility"
# 创建文件夹
mkdir ${app_folder_name}
mkdir ${modules_folder_name}
mkdir ${utility_folder_name}

ex_folder_name="Extension"
base_folder_name="Base"
mv "${ex_folder_name}" "${utility_folder_name}/"
mv "${base_folder_name}" "${utility_folder_name}/"
#移文件夹到APP下
mv "${modules_folder_name}" "${app_folder_name}/"
mv "${utility_folder_name}" "${app_folder_name}/"
