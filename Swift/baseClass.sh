#!/bin/bash
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
baseNavigationVC=`sh ../readProperties.sh baseNavigationVC`
# 文件后缀
class_suffix=".swift"

# 父类存放的目录
base_folder_name=$1
if [ ! -n "$base_folder_name" ];then
base_folder_name="Base"
fi
rm -rf ${base_folder_name}
# 创建目录
mkdir ${base_folder_name}

# 获取文件授权信息
function getAuthorInfo(){
class_name=$1
auth_info=`sh authorInfo.sh ${project_name} ${class_name}${class_suffix}`
echo "${auth_info}"
}


function setupBaseView(){
info=`getAuthorInfo ${baseView}`
echo "${info}
import UIKit
import SnapKit

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

" >> $base_folder_name"/"$baseView$class_suffix
 
}

function setupBaseLabel(){
info=`getAuthorInfo ${baseLabel}`
echo "${info}
import UIKit
import SnapKit
class ${baseLabel}: UILabel {
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
" >> $base_folder_name"/"$baseLabel$class_suffix

}

function setupBaseTableView(){
info=`getAuthorInfo ${baseTableView}`
echo "${info}
import UIKit
import SnapKit

class ${baseTableView} : UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
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
" >> $base_folder_name"/"$baseTableView$class_suffix

}

function setupBaseCollectionView(){
info=`getAuthorInfo ${baseCollectionView}`
echo "${info}
import UIKit
import SnapKit

class ${baseCollectionView} : UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
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

" >> $base_folder_name"/"$baseCollectionView$class_suffix
}

function setupBaseScrollView(){
info=`getAuthorInfo ${baseScrollView}`
echo "${info}
import UIKit
import SnapKit

class ${baseScrollView} : UIScrollView {
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

" >> $base_folder_name"/"$baseScrollView$class_suffix
}

function setupBaseTextField(){
info=`getAuthorInfo ${baseTextField}`
echo "${info}
import UIKit
import SnapKit

class ${baseTextField} : UITextField {
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
" >> $base_folder_name"/"$baseTextField$class_suffix
}

function setupBaseButton(){
info=`getAuthorInfo ${baseButton}`
echo "${info}
import UIKit
import SnapKit

class ${baseButton} : UIButton {
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

" >> $base_folder_name"/"$baseButton$class_suffix
}

function setupBaseImageView(){
info=`getAuthorInfo ${baseImageView}`
echo "${info}
import UIKit
import SnapKit

class ${baseImageView} : UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
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
" >> $base_folder_name"/"$baseImageView$class_suffix

}

function setupBaseTableViewCell(){
info=`getAuthorInfo ${baseTableViewCell}`
echo "${info}
import UIKit
import SnapKit

class ${baseTableViewCell} : UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addConstraintToView()
    }
    required init?(coder: NSCoder) {
        fatalError(\"init(coder:) has not been implemented\")
    }
    /// 初始化view 或添加view
    func setupUI(){
        self.selectionStyle = .none
    }
    /// 对子view添加约束
    func addConstraintToView(){
        
    }
}
" >> $base_folder_name"/"$baseTableViewCell$class_suffix
}

function setupBaseTextView(){
info=`getAuthorInfo ${baseTextView}`

echo "${info}
import UIKit
import SnapKit

class ${baseTextView} : UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
        addConstraintToView()
    }
    required init?(coder: NSCoder) {
        fatalError(\"init(coder:) has not been implemented\")
    }
    /// 初始化view 或添加view
    func setupUI(){
       
    }
    /// 对子view添加约束
    func addConstraintToView(){
        
    }
}

" >> $base_folder_name"/"$baseTextView$class_suffix
}

function setupBaseCollectionViewCell(){
info=`getAuthorInfo ${baseCollectionViewCell}`

echo "${info}
import UIKit
import SnapKit

class ${baseCollectionViewCell} : UICollectionViewCell {
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
       
    }
    /// 对子view添加约束
    func addConstraintToView(){
        
    }
}
" >> $base_folder_name"/"$baseCollectionViewCell$class_suffix

}

function setupBaseTableViewHeaderFooterView(){
info=`getAuthorInfo ${baseTableViewHeaderFooterView}`

echo "${info}
import UIKit
import SnapKit

class ${baseTableViewHeaderFooterView} : UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
        addConstraintToView()
    }
    required init?(coder: NSCoder) {
        fatalError(\"init(coder:) has not been implemented\")
    }
    /// 初始化view 或添加view
    func setupUI(){
       
    }
    /// 对子view添加约束
    func addConstraintToView(){
        
    }
}
" >> $base_folder_name"/"$baseTableViewHeaderFooterView$class_suffix

}

function setupBaseCollectionReusableView(){
info=`getAuthorInfo ${baseCollectionReusableView}`

echo "${info}
import UIKit
import SnapKit

class ${baseCollectionReusableView} : UICollectionReusableView {
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
       
    }
    /// 对子view添加约束
    func addConstraintToView(){
        
    }
}
" >> $base_folder_name"/"$baseCollectionReusableView$class_suffix

}

function setupBaseVC(){
info=`getAuthorInfo ${baseVC}`

echo "${info}
import UIKit
import SnapKit

class ${baseVC} : UIViewController,UINavigationControllerDelegate,UIGestureRecognizerDelegate{
    /// 是否右滑返回
    public var canLeftPop : Bool = true
    /// 是否隐藏导航栏
    var isHiddenNav : Bool = false
    override var preferredStatusBarStyle: UIStatusBarStyle{
         return .lightContent
     }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addConstraintToView()
        bindEvent()
        bindData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupPopGesture()
    }

    /// 初始化view 或添加view
    public func setupUI(){
        self.edgesForExtendedLayout = []
    }
    /// 对子view添加约束
    public func addConstraintToView(){
        
    }
    public func bindEvent(){
        
    }
    public func bindData(){
        
    }
    private func setupPopGesture(){
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let count = self.navigationController?.viewControllers.count , count == 1 {
            return false
        }
        return self.canLeftPop
    }
    deinit {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
}
" >> $base_folder_name"/"$baseVC$class_suffix

}

function setupBaseNavigationVC(){
info=`getAuthorInfo ${baseNavigationVC}`

echo "${info}
import UIKit

class ${baseNavigationVC} : UINavigationController{
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if  self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    override var childForStatusBarHidden: UIViewController?{
        return self.topViewController
    }
    override var childForStatusBarStyle: UIViewController?{
        return self.topViewController
    }
}
" >> $base_folder_name"/"$baseNavigationVC$class_suffix
}

function init(){

setupBaseView
setupBaseLabel
setupBaseTableView
setupBaseCollectionView
setupBaseScrollView
setupBaseTextField
setupBaseButton
setupBaseImageView
setupBaseTableViewCell
setupBaseTextView
setupBaseCollectionViewCell
setupBaseTableViewHeaderFooterView
setupBaseCollectionReusableView
setupBaseVC
setupBaseNavigationVC

}

init

