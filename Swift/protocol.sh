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

public protocol ${class_prefix}RouteAble{
    static func initVC(parm : [String : Any]?)->Self
}

public protocol ${class_prefix}RouteParmAble{
    var any : AnyClass?{get}
    var parm : [String : Any]?{get}
}

" >> $class_name$class_suffix
