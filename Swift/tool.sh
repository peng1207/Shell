# 前缀
class_prefix=`sh ../readProperties.sh classPrefix`
# 项目名称
project_name=`sh ../readProperties.sh projectName`
class_name="${class_prefix}Tool"
class_suffix=".swift"
class_prefix_lowercased=$(echo $class_prefix | tr '[A-Z]' '[a-z]')

auth_info=`sh authorInfo.sh ${project_name} ${class_name}${class_suffix}`

echo "${auth_info}

import UIKit
public struct ${class_name} {
    /// 获取顶部的控制器
    static func getTopVC()->UIViewController?{
        guard let window =  UIWindow.${class_prefix_lowercased}.getWindow() else { return nil }
        return getCurrentVC(from: window.rootViewController)
    }
    /// 获取当前的控制器 一步一步往下获取
    private static func getCurrentVC(from vc : UIViewController?)->UIViewController?{
        guard var vc = vc else { return vc }
        var currentVC : UIViewController? = nil
        if  let presentVC = vc.presentedViewController {
            vc = presentVC
        }
        if let tabbarVC = vc as? UITabBarController {
            currentVC = getCurrentVC(from: tabbarVC.selectedViewController)
        }else if let navVC = vc as? UINavigationController {
            currentVC = getCurrentVC(from: navVC.visibleViewController)
        }else{
            currentVC = vc
        }
        return currentVC
    }
    
}

" >> $class_name$class_suffix
