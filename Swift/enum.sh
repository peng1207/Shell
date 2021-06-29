
# 前缀
class_prefix=`sh ../readProperties.sh classPrefix`
# 项目名称
project_name=`sh ../readProperties.sh projectName`
class_name="${class_prefix}Enum"
class_suffix=".swift"
auth_info=`sh authorInfo.sh ${project_name} ${class_name}${class_suffix}`

echo "$auth_info

" >> $class_name$class_suffix
