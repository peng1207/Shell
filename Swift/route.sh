
route_folder_name=$1

# 前缀
class_prefix=`sh ../readProperties.sh classPrefix`
# 文件后缀
class_suffix=".swift"
# 项目名称
project_name=`sh ../readProperties.sh projectName`

app_route_name=$class_prefix"AppRoute"
route_name=$class_prefix"Route"


function setupAppRoute(){
auth_info=`sh authorInfo.sh ${project_name} ${app_route_name}${class_suffix}`

echo "${auth_info}

import UIKit
public enum ${app_route_name} : ${class_prefix}RouteParmAble{
    
    public var any: AnyClass?{
        return nil
    }
    
    public var parm: [String : Any]?{
        return nil
    }
}
" >> ${route_folder_name}"/"${app_route_name}${class_suffix}

}
function setupRoute(){
auth_info=`sh authorInfo.sh ${project_name} ${route_name}${class_suffix}`

echo "${auth_info}

import UIKit
public class ${route_name}{
    static func open(routeParm : ${class_prefix}RouteParmAble,present : Bool = false ,animated : Bool = true){
        var currentVC : UIViewController? = nil
        if let anyClass = routeParm.any as? ${class_prefix}RouteAble.Type, let vc = anyClass.initVC(parm: routeParm.parm) as? UIViewController {
            currentVC = vc
        }else if let anyClass = routeParm.any as? UIViewController.Type {
            currentVC = anyClass.init()
        }
        if let topVC = ${class_prefix}Tool.getTopVC() , let vc = currentVC {
            if present {
                topVC.present(vc, animated: animated, completion: nil)
            }else{
                topVC.navigationController?.pushViewController(vc, animated: animated)
            }
        }
    }
}


" >> ${route_folder_name}"/"${route_name}${class_suffix}

}

function init(){

mkdir ${route_folder_name}
setupRoute
setupAppRoute

}

if [ "${route_folder_name}" == "" ];then
echo "请输入目录"
read -r route_folder_name
fi

if [ "${route_folder_name}" == ""  ];then

echo "目录为空"

else

init

fi
