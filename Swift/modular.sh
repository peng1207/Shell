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
#toupper 转大写
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
  
    
    func setupUI(){
        super.setupUI()
    
    }
    func addConstraintToView(){
        super.addConstraintToView()
       
    }
    
}
extension ${view_name} : ${class_prefix}RefreshUIProtocol{
        /// 刷新UI数据
    /// - Parameter data: 数据
    func refreshUI(data : Any){
    
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

class ${vc_name} : SPBaseVC{
    
    private lazy var ${class_name_first_lowercase}View : ${view_name} = {
        return ${view_name}()
    }()
    private lazy var ${class_name_first_lowercase}VM : ${vm_name} = {
        return ${vm_name}()
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

" >> $base_folder_name"/"$vc_folder_name"/"$vc_name$class_suffix
}

function setupVM(){
auth_info=`sh authorInfo.sh ${project_name} ${vm_name}${class_suffix}`

echo "${auth_info}
import Foundation

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

function init(){

setupView
setupModel
setupVC
setupVM
setupServer

}

init
