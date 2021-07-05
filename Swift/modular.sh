#!/bin/bash
class_name=$1
vc_folder_name="VC"
model_folder_name="Model"
vm_folder_name="VM"
view_floder_name="View"
server_floder_name="Server"
# 前缀
class_prefix=`sh ../readProperties.sh classPrefix`
# 文件后缀
class_suffix=".swift"
# 项目名称
project_name=`sh ../readProperties.sh projectName`
#toupper 首字母转小写
class_name_first_lowercase=`echo ${class_name:0:1} | awk '{print tolower($0)}'`
class_name_first_lowercase=$class_name_first_lowercase${class_name:1}
echo "class_name_first_lowercase ${class_name_first_lowercase}"
baseVC=`sh ../readProperties.sh baseVC`
baseView=`sh ../readProperties.sh baseView`
model_name=$class_prefix$class_name"Model"
view_name=$class_prefix$class_name"View"
vc_name=$class_prefix$class_name"VC"
vm_name=$class_prefix$class_name"VM"
server_name=$class_prefix$class_name"Server"
coordinator_name=$class_prefix$class_name"Coordinator"
base_folder_name=$class_name

rm -rf $base_folder_name
mkdir $base_folder_name

mkdir $base_folder_name"/"$vc_folder_name
mkdir $base_folder_name"/"$model_folder_name
mkdir $base_folder_name"/"$vm_folder_name
mkdir $base_folder_name"/"$view_floder_name
mkdir $base_folder_name"/"$server_floder_name







function setupView(){
echo "是否为view 添加属性 y/n"
is_add_to_view=""
read -r is_add_to_view

if [ "${is_add_to_view}" == "y" ];then
sh ./view.sh $class_name
mv ${view_name}${class_suffix} $base_folder_name"/"$view_floder_name"/"$view_name$class_suffix
else
auth_info=`sh authorInfo.sh ${project_name} ${view_name}${class_suffix}`

echo "${auth_info}
import UIKit

class ${view_name} : ${baseView}{
  
    
    override func setupUI(){
        super.setupUI()
    
    }
    override func addConstraintToView(){
        super.addConstraintToView()
       
    }
    
}
extension ${view_name} : ${class_prefix}RefreshUIProtocol{
        /// 刷新UI数据
    /// - Parameter data: 数据
    func refreshUI(data : Any?){
    
    }
}
" >> $base_folder_name"/"$view_floder_name"/"$view_name$class_suffix

fi
}

function setupModel(){
echo "是否为model 添加属性 y/n"
is_add_to_model=""
read -r is_add_to_model

if [ "${is_add_to_model}" == "y" ];then
sh ./model.sh $class_name
mv $model_name$class_suffix $base_folder_name"/"$model_folder_name"/"$model_name$class_suffix

else
auth_info=`sh authorInfo.sh ${project_name} ${model_name}${class_suffix}`

echo "${auth_info}
import Foundation

 struct ${model_name} : ${class_prefix}ModelProtocol {
    
 }
" >> $base_folder_name"/"$model_folder_name"/"$model_name$class_suffix

fi

}

function setupVC(){
auth_info=`sh authorInfo.sh ${project_name} ${vc_name}${class_suffix}`

echo "${auth_info}
import UIKit

class ${vc_name} : ${baseVC}{
    
    private lazy var ${class_name_first_lowercase}View : ${view_name} = {
        return ${view_name}()
    }()
    private lazy var ${class_name_first_lowercase}VM : ${vm_name} = {
        return ${vm_name}()
    }()
    private lazy var ${class_name_first_lowercase}Coordinator : ${coordinator_name} = {
        let coordinator = ${coordinator_name}(vc: self, vm: ${class_name_first_lowercase}VM)
        return coordinator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    /// 初始化view 或添加view
    public override func setupUI(){
        super.setupUI()
        self.view = ${class_name_first_lowercase}View
    }
    /// 对子view添加约束
    public override func addConstraintToView(){
        super.addConstraintToView()
    }
    public override func bindEvent(){
        super.bindEvent()
    }
    public override func bindData(){
        super.bindData()
    }
}

extension ${vc_name} : ${class_prefix}RouteAble{
    static func initVC(parm: [String : Any]?) -> Self {
        let vc = Self()
        return vc
    }
}

" >> $base_folder_name"/"$vc_folder_name"/"$vc_name$class_suffix
}

function setupVM(){
auth_info=`sh authorInfo.sh ${project_name} ${vm_name}${class_suffix}`

echo "${auth_info}
import Foundation

/// 处理页面业务逻辑、网络请求、UI界面显示逻辑，
class ${vm_name} {
    
}
" >> $base_folder_name"/"$vm_folder_name"/"$vm_name$class_suffix

}

function setupServer(){
auth_info=`sh authorInfo.sh ${project_name} ${server_name}${class_suffix}`
echo "${auth_info}
import Foundation

class ${server_name} {
    
}

" >> $base_folder_name"/"$server_floder_name"/"$server_name$class_suffix
}

function setupCoordinator(){
auth_info=`sh authorInfo.sh ${project_name} ${coordinator_name}${class_suffix}`

echo "${auth_info}

import UIKit
/// vc 事件协调员 主要承担控制器跳转、弹框提示
class ${coordinator_name}{
   weak private var vc : UIViewController?
   weak private var vm : ${vm_name}?
    init(vc : UIViewController,vm : ${vm_name}) {
        self.vc = vc
        self.vm = vm
    }
}

" >> $base_folder_name"/"$vm_folder_name"/"$coordinator_name$class_suffix
}

function init(){

setupView
setupModel
setupVC
setupVM
setupCoordinator
setupServer

}

init
