#!/bin/bash

input_name=$1
echo "name $input_name"
if [ "$input_name" == "" ];then
echo "请输入类名 不需要前缀和后缀 例如 XXHomeView 只输入Home"
read -r input_name
fi

if [ "$input_name" == "" ];then
exit
fi

# 前缀
class_prefix=`sh ../readProperties.sh classPrefix`
class_prefix_lowercased=`sh ../letter.sh ${class_prefix} 1`
# 项目名称
project_name=`sh ../readProperties.sh projectName`
baseView=`sh ../readProperties.sh baseView`
baseLabel=`sh ../readProperties.sh baseLabel`
baseTableView=`sh ../readProperties.sh baseTableView`
baseCollectionView=`sh ../readProperties.sh baseCollectionView`
baseScrollView=`sh ../readProperties.sh baseScrollView`
baseTextField=`sh ../readProperties.sh baseTextField`
baseButton=`sh ../readProperties.sh baseButton`
baseImageView=`sh ../readProperties.sh baseImageView`
baseTableViewCell=`sh ../readProperties.sh baseTableViewCell`
baseTextView=`sh ../readProperties.sh baseTextView`
baseCollectionViewCell=`sh ../readProperties.sh baseCollectionViewCell`
baseTableViewHeaderFooterView=`sh ../readProperties.sh baseTableViewHeaderFooterView`
baseCollectionReusableView=`sh ../readProperties.sh baseCollectionReusableView`
echo "请输入view的继承类 请输入以下的编号 0:UIView; 1:UITableViewCell; 2:UICollectionViewCell; 3:UITableViewHeaderFooterView; 4:UICollectionReusableView;"
class_name=""
super_class_name=""
super_view="self"
isBreak=1
while [ $isBreak ]
do
r1=""
echo "请输入编号"
read -r r1
if [ $r1 = "0" ];then
class_name=$class_prefix$input_name"View"
super_class_name="${baseView}"
super_view="self"
break;
elif [ $r1 = "1" ];then
class_name=$class_prefix$input_name"TableCell"
super_class_name="${baseTableViewCell}"
super_view="self.contentView"
break;
elif [ $r1 = "2" ];then
class_name=$class_prefix$input_name"CollectionCell"
super_class_name="${baseCollectionViewCell}"
super_view="self.contentView"
break;
elif [ $r1 = "3" ];then
class_name=$class_prefix$input_name"TableHeaderFooterView"
super_class_name="${baseTableViewHeaderFooterView}"
super_view="self.contentView"
break;
elif [ $r1 = "4" ];then
class_name=$class_prefix$input_name"ReusableView"
super_class_name="${baseCollectionReusableView}"
super_view="self"
break;
else
    echo "请重新输入编号"

fi
echo "class name is $class_name"
done
 
echo "类名为：$class_name"
echo "project_name $project_name\n"
auth_info=`sh authorInfo.sh ${project_name} ${class_name}.swift`
echo "头部信息为 $auth_info"


echo "请输入该类的属性变量对应编号（例如 UIView 则输入1） 0:退出; 1:UIView; 2:UILabel; 3:UITableView; 4:UICollectionView; 5:UIScrollView; 6:UITextField; 7:UIButton; 8:UIStackView; 9:UIImageView; 10:UITextView; 11:UISwitch; 12:UISlider; 13:UIProgressView;"


# 获取变量名称
function getVariableName(){
name=$1
typeValue=$2
if [ $typeValue = "1" ];then
name=$name"View"
elif [ $typeValue = "2" ];then
name=$name"Label"
elif [ $typeValue = "3" ];then
name=$name"TabelView"
elif [ $typeValue = "4" ];then
name=$name"CollectionView"
elif [ $typeValue = "5" ];then
name=$name"ScrollView"
elif [ $typeValue = "6" ];then
name=$name"TF"
elif [ $typeValue = "7" ];then
name=$name"Btn"
elif [ $typeValue = "8" ];then
name=$name"StackView"
elif [ $typeValue = "9" ];then
name=$name"ImgView"
elif [ $typeValue = "10" ];then
name=$name"TV"
elif [ $typeValue = "11" ];then
name=$name"Switch"
elif [ $typeValue = "12" ];then
name=$name"Slider"
elif [ $typeValue = "13" ];then
name=$name"ProgressView"
fi
echo $name
}

# 获取UIView的初始化 懒加载
function getViewInit(){
name=$1
info="private lazy var ${name} : ${baseView} = { \n let v = ${baseView}() \n return v \n}()"
echo "${info}"
}

# 获取UILabel的初始化
function getLabelInit(){
name=$1
echo " private lazy var ${name} : ${baseLabel} = { \n
        return ${baseLabel}.${class_prefix_lowercased}.initLabel(text: "", font: UIFont.systemFont(ofSize: 16), textColor: UIColor.black) \n
    }()"
}

# 获取UITableView的初始化
function getTableInit(){
name=$1
echo "  private lazy var ${name} : ${baseTableView} = {
        let table = ${baseTableView}.${class_prefix_lowercased}.initTable(style: .plain, rowHeight: 44, cellType: <#T##UITableViewCell.Type?#>)
        return table
    }"
}

# 获取UICollectionView的初始化
function getCollectionViewInit(){
name=$1
echo "private lazy var ${name} : ${baseCollectionView} {
        let layout = UICollectionViewFlowLayout()
        let collectionView = ${baseCollectionView}.${class_prefix_lowercased}.initCollection(layout: layout, cellType: <#T##UICollectionViewCell.Type?#>)
        return collectionView
    }()"
}

# 获取UIScrollView的初始化
function getScrollViewInit(){
name=$1
echo "private lazy var ${name} : ${baseScrollView} = {
        let scrollView = ${baseScrollView}()
        return scrollView
    }()"
}

# 获取UITextField的初始化
function getTextFieldInit(){
name=$1
echo " private lazy var ${name} : ${baseTextField} = {
        let textField = ${baseTextField}()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = UIColor.black
        textField.placeholder = ""
        return textField
    }()"
}

# 获取UIButton的初始化
function getButtonInit(){
name=$1
echo " private lazy var ${name} : ${baseButton} = {
        return ${baseButton}.initBtn(title: "", titleColor: .black, img: nil, textFont: UIFont.systemFont(ofSize: 16))
    }()"
}

# 获取UIStackView的初始化
function getStackView(){
name=$1
echo " private lazy var ${name} : UIStackView = {
        let s = UIStackView()
        s.spacing = 0
        s.axis = .vertical
        return s
    }()"
}

# 获取UIImageView的初始化
function getImageViewInit(){
name=$1
echo "private lazy var ${name} : ${baseImageView} = {
        return ${baseImageView}()
    }()"
}

# 获取UITextView的初始化
function getTextViewInit(){
name=$1

echo " private lazy var ${name} : ${baseTextView} = {
        let textV = ${baseTextView}()
        textV.font = UIFont.systemFont(ofSize: 14)
        textV.textColor = .black
        return textV
    }()"
}

# 获取UISwitch的初始化
function getSwitchInit(){
name=$1
echo " private lazy var ${name} : UISwitch = {
        let s = UISwitch()
        s.onTintColor = .green
        return s
    }()"
}

# 获取UISlider的初始化
function getSliderInit(){
name=$1
echo "private lazy var ${name} : UISlider = {
        let s = UISlider()
        s.maximumValue = 100
        s.maximumTrackTintColor = <#des#>
        return s
    }()"
}

# 获取UIProgressView的初始化
function getProgressViewInit(){
name=$1
echo " private lazy var ${name} : UIProgressView = {
        let progress = UIProgressView()
       return progress
    }()"
}

# 获取变量属性初始化入口 由这个函数判断是哪种控件 在进行不同控件的初始化
function getVariableInit(){
name=$1
typeValue=$2
variable_init=""
if [ $typeValue = "1" ];then
variable_init=`getViewInit ${name}`
elif [ $typeValue = "2" ];then
variable_init=`getLabelInit ${name}`
elif [ $typeValue = "3" ];then
variable_init=`getTableInit ${name}`
elif [ $typeValue = "4" ];then
variable_init=`getCollectionViewInit ${name}`
elif [ $typeValue = "5" ];then
variable_init=`getScrollViewInit ${name}`
elif [ $typeValue = "6" ];then
variable_init=`getTextFieldInit ${name}`
elif [ $typeValue = "7" ];then
variable_init=`getButtonInit ${name}`
elif [ $typeValue = "8" ];then
variable_init=`getStackView ${name}`
elif [ $typeValue = "9" ];then
variable_init=`getImageViewInit ${name}`
elif [ $typeValue = "10" ];then
variable_init=`getTextViewInit ${name}`
elif [ $typeValue = "11" ];then
variable_init=`getSwitchInit ${name}`
elif [ $typeValue = "12" ];then
variable_init=`getSliderInit ${name}`
elif [ $typeValue = "13" ];then
variable_init=`getProgressViewInit ${name}`
fi
echo $variable_init"\n"
}

# 获取代理
function getDelegate(){
typeValue=$2
delegate=""
if [ $typeValue = "3" ];then
delegate="\n extension ${class_name} : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return <#des#>
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#des#>
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: <#T##IndexPath#>)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#des#>
    }
}"
elif [ $typeValue = "4" ];then
delegate="extension ${class_name} : UICollectionViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return <#count#> > 0 ? 1 : 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return <#count#>
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : <#cell#> = collectionView.dequeueReusableCell(withReuseIdentifier: <#cellid#>, for: indexPath) as! <#cell#>
        if indexPath.row < <#count#> {
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < <#count#> {
            
        }
    }
}"
fi
echo delegate
}

# 属性初始化 懒加载
variable_init=""
# 添加view
add_ui_to_view=""
# 添加约束
add_constraint=""
# 扩展
extension_data=""
# 循环获取变量
while [ $isBreak ]
do
echo "请输入属性对应的编号"
a=""
read -r a
if [ $a = "0" ];then
break;
fi
echo $a
att=""
echo "请输入创建属性的名称 不用带后缀 会根据类型创建对应后缀（例如 titleLabel 直接输入 title就OK）"
read -r att
variable_name=`getVariableName ${att} ${a}`
echo "variable_name is ${variable_name}"
variable_init=$variable_init`getVariableInit ${variable_name} ${a}`"\n\n"
echo "variable_init is $variable_init"

if [ -n "$add_ui_to_view" ];then
add_ui_to_view=$add_ui_to_view","
fi
add_ui_to_view=$add_ui_to_view${variable_name}
#add_ui_to_view=$add_ui_to_view"${super_view}.addSubview(${variable_name})""\n"
add_constraint=$add_constraint" ${variable_name}.snp.makeConstraints { (make) in \n \n    }""\n"
done



echo "${auth_info}

import UIKit

class ${class_name} : ${super_class_name}{
    ${variable_init}
    
    func setupUI(){
        super.setupUI()
       
        ${super_view}.${class_prefix_lowercased}.addSubviews(views: [${add_ui_to_view}])
    }
    func addConstraintToView(){
        super.addConstraintToView()
        ${add_constraint}
    }
    
}
extension ${class_name} : ${class_prefix}RefreshUIProtocol{
        /// 刷新UI数据
    /// - Parameter data: 数据
    func refreshUI(data : Any){
    
    }
}
${extension_data}
" >> $class_name".swift"
