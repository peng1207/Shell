# 前缀
class_prefix=`sh ../readProperties.sh classPrefix`
# 项目名称
project_name=`sh ../readProperties.sh projectName`
class_name="${class_prefix}Protocol"
class_suffix=".swift"
auth_info=`sh authorInfo.sh ${project_name} ${class_name}${class_suffix}`

refreshUI_protocol="${class_prefix}RefreshUIProtocol"


echo "${auth_info}


public protocol ${refreshUI_protocol} {
     func refreshUI(data : Any?)
}
" >> $class_name$class_suffix
