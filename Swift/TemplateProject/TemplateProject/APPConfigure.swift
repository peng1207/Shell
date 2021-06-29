//
//  APPConfigure.swift
//  TemplateProject
//
//  Created by 黄树鹏 on 2021/6/27.
//

import Foundation
import UIKit

class APPConfigure {
    
    /// 加载主控制器
    static func loadRootVC(){
        var window : UIWindow?
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first , let deletage =  windowScene.delegate as? SceneDelegate{
                window = deletage.window
            }
        }
        if window == nil,let w = UIApplication.shared.delegate?.window {
            window = w
        }
        window?.rootViewController = getRootVC()
    }
    /// 获取主控制器
    /// - Returns: 控制器
    private static func getRootVC()->UIViewController{
        return UIViewController()
    }
}
