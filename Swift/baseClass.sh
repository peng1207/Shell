# 前缀
class_prefix=`sh ../readProperties.sh classPrefix`
# 项目名称
project_name=`sh ../readProperties.sh projectName`
# 创建父类的名称
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
baseVC=`sh ../readProperties.sh baseVC`
baseModel=`sh ../readProperties.sh baseModel`
baseNavigationVC=`sh ../readProperties.sh baseNavigationVC`
# 文件后缀
class_suffix=".swift"

# 父类存放的目录
base_folder_name=$1
if [ ! -n "$base_folder_name" ];then
base_folder_name="Base"
fi
# 创建目录
mkdir ${base_folder_name}

# 获取文件授权信息
function getAuthorInfo(){
class_name=$1
auth_info=`sh authorInfo.sh ${project_name} ${class_name}${class_suffix}`
echo "${auth_info}"
}

function mvFile(){
fileName=$1
mv "${fileName}" "${base_folder_name}/"
}
info=`getAuthorInfo ${baseView}`
 
echo "${info}
import UIKit
    
class ${baseView} : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addConstraintToView()
    }
    
    required init?(coder: NSCoder) {
        fatalError(\"init(coder:) has not been implemented\")
    }
    /// 初始化view 或添加view
    func setupUI(){
        self.backgroundColor = .white
    }
    /// 对子view添加约束
    func addConstraintToView(){
        
    }
}
" >> $baseView"${class_suffix}"

mvFile $baseView"${class_suffix}"
