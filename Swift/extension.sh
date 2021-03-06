#!/bin/bash
#Extension文件夹名称
ex_folder_name="Extension"

# 前缀
class_prefix=`sh ../readProperties.sh classPrefix`
class_suffix=".swift"
class_prefix_lowercased=`sh ../letter.sh ${class_prefix} 1`
echo "class_prefix_lowercased ${class_prefix_lowercased}"
# 项目名称
project_name=`sh ../readProperties.sh projectName`

rm -rf $ex_folder_name
mkdir $ex_folder_name

target_class_name=$class_prefix"Target"
target_protocol=$class_prefix"TargetProtocol"
objec_name=$class_prefix"Object"
view_name=$class_prefix"View"
label_name=$class_prefix"Label"
imageView_name=$class_prefix"ImageView"
button_name=$class_prefix"Button"
scrollView_name=$class_prefix"ScrollView"
tableView_name=$class_prefix"TableView"
collectionView_name=$class_prefix"CollectionView"
navVC_name=$class_prefix"NavVC"
navBar_name=$class_prefix"NavBar"
image_name=$class_prefix"Image"
color_name=$class_prefix"Color"
font_name=$class_prefix"Font"
dateFormatter_name=$class_prefix"DateFormatter"
string_name=$class_prefix"String"
array_name=$class_prefix"Array"
model_protocol="${class_prefix}ModelProtocol"
window_name=$class_prefix"Window"
screen_name=$class_prefix"Screen"
device_name=$class_prefix"Device"
notification_name=$class_prefix"Notification"

function setupTarget(){
auth_info=`sh authorInfo.sh ${project_name} ${target_class_name}${class_suffix}`
echo "${auth_info}
import Foundation

public struct ${target_class_name}<Base> {
    var base : Base
    init(base : Base) {
        self.base = base
    }
}
" >> $ex_folder_name"/"$target_class_name$class_suffix
}

function setupProtocol(){
auth_info=`sh authorInfo.sh ${project_name} ${target_protocol}${class_suffix}`

echo "${auth_info}
import Foundation

public protocol ${target_protocol} {
    associatedtype Base
    var ${class_prefix_lowercased} : ${target_class_name}<Self.Base>{get}
    static var ${class_prefix_lowercased} : ${target_class_name}<Self.Base>.Type {get}
}
extension ${target_protocol} {
    
    public var ${class_prefix_lowercased} : ${target_class_name}<Self>{
        return ${target_class_name}<Self>(base: self)
    }
    public static var ${class_prefix_lowercased} : ${target_class_name}<Self>.Type {
        return ${target_class_name}<Self>.self
    }
}
" >> $ex_folder_name"/"$target_protocol$class_suffix
}


function setupObject(){
auth_info=`sh authorInfo.sh ${project_name} ${objec_name}${class_suffix}`

echo "${auth_info}
import Foundation
extension NSObject : ${target_protocol}{
    
}
extension ${target_class_name} where Base : NSObject {
    public static func identifier()->String{
        return \"\(Base.self)Identifier\"
    }
}
" >> $ex_folder_name"/"$objec_name$class_suffix

}

function setupView(){
auth_info=`sh authorInfo.sh ${project_name} ${view_name}${class_suffix}`

echo "${auth_info}
import Foundation
import UIKit
extension ${target_class_name} where Base : UIView {
    
    /// 添加子view 到当前view上
    /// - Parameter views: 子view 数组
    public func addSubviews<T>(views : [T]) where T : UIView{
        views.forEach { view in
            self.base.addSubview(view)
        }
    }
    
    /// 设置圆角和边框
    /// - Parameters:
    ///   - radis: 圆角大小
    ///   - corners: 圆角方向
    ///   - borderColor: 边框颜色
    ///   - borderWidth: 边框宽度
    public func corner(radis : CGFloat,byRoundingCorners corners: UIRectCorner = .allCorners,borderColor : UIColor?,borderWidth : CGFloat){
        let cornerLayer : ${class_prefix}CornerLayer = getCustomLayer() ?? {
            let layer = ${class_prefix}CornerLayer()
            self.base.layer.masksToBounds = true
            self.base.layer.mask = layer
            return layer
        }()
        cornerLayer.fillColor = self.base.backgroundColor?.cgColor
 
        cornerLayer.radis = radis
        cornerLayer.corners = corners
        cornerLayer.frame = self.base.bounds
        cornerLayer.drawCorner()
        border(color: borderColor, width: borderWidth, radis: radis, corners: corners)
    }
    /// 设置边框
    /// - Parameters:
    ///   - color: 边框颜色
    ///   - width: 边框宽度
    ///   - radis: 边框是否圆角
    ///   - corners: 圆角方向
    public func border(color : UIColor?,width : CGFloat,radis:CGFloat,corners: UIRectCorner = .allCorners){
        let borderLayer : ${class_prefix}BorderLayer = getCustomLayer() ?? {
            let layer = ${class_prefix}BorderLayer()
            self.base.layer.addSublayer(layer)
            return layer
        } ()
        borderLayer.fillColor = self.base.backgroundColor?.cgColor
        borderLayer.lineWidth = width
        borderLayer.strokeColor = color?.cgColor
        borderLayer.radis = radis
        borderLayer.corners = corners
        borderLayer.frame = self.base.bounds
        borderLayer.drawCorner()
        
    }
    private func getCustomLayer<T>()->T?{
        var cornerLayer : T?
        guard let subLayers = self.base.layer.sublayers else {
            return cornerLayer
        }
        for layer in subLayers {
            if let item = layer as? T {
                cornerLayer = item
                break
            }
        }
        return cornerLayer
    }
    
    private class ${class_prefix}CornerLayer : CAShapeLayer {
        var radis : CGFloat = 0
        var corners : UIRectCorner = .allCorners
        func drawCorner(){
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radis, height: radis))
            self.path = path.cgPath
        }
    }
    private class ${class_prefix}BorderLayer : CAShapeLayer{
        var radis : CGFloat = 0
        var corners : UIRectCorner = .allCorners
        func drawCorner(){
            if radis > 0 {
                let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radis, height: radis))
                self.path = path.cgPath
            }else{
                self.path = nil
            }
        }
    }
}

/// frame
extension ${target_class_name} where Base : UIView {
    
    public var x : CGFloat {
        get { self.base.frame.origin.x }
        set{
            var frame = self.base.frame
            frame.origin.x = newValue
            self.base.frame = frame
        }
    }
    public var y : CGFloat {
        get { self.base.frame.origin.y }
        set {
            var frame = self.base.frame
            frame.origin.y = newValue
            self.base.frame = frame
        }
    }
    public var width : CGFloat {
        get { self.base.frame.size.width }
        set {
            var frame = self.base.frame
            frame.size.width = newValue
            self.base.frame = frame
        }
    }
    public var height : CGFloat {
        get { self.base.frame.size.height }
        set {
            var frame = self.base.frame
            frame.size.height = newValue
            self.base.frame = frame
        }
    }
    public var maxX : CGFloat {
        return x + width
    }
    public var maxY : CGFloat {
        return y + height
    }
    public var centerX : CGFloat {
        return x + width / 2.0
    }
    public var centerY : CGFloat {
        return y + height / 2.0
    }
    public var bounds : CGRect {
        return self.base.bounds
    }
}

" >> $ex_folder_name"/"$view_name$class_suffix

}

function setupLabel(){
auth_info=`sh authorInfo.sh ${project_name} ${label_name}${class_suffix}`

echo "${auth_info}
import Foundation
import UIKit

extension ${target_class_name} where Base : UILabel {
    public static func initLabel(text: String? = nil, font : UIFont = UIFont.${class_prefix_lowercased}.font(size: 16),textColor:UIColor = UIColor.black,textAlignment : NSTextAlignment = .left,numberOfLines : Int = 1) -> Base{
        let label = Base()
        label.font = font
        label.text = text
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        return label
    }
}
" >> $ex_folder_name"/"$label_name$class_suffix
}

function setupImageView(){
auth_info=`sh authorInfo.sh ${project_name} ${imageView_name}${class_suffix}`
img_complete_name="${class_prefix}ImgLoadComplete"
img_download_name="${class_prefix}ImgDownload"

echo "${auth_info}
import Foundation
import UIKit
import Kingfisher

/// 图片加载成功回调
public typealias ${img_complete_name} = (_ img : UIImage?)->Void
/// 图片加载进度
public typealias ${img_download_name} = (_ progress : CGFloat)->Void

extension ${target_class_name} where Base : UIImageView {
    
    public func load(urlStr : String,placeholderImg : UIImage? = nil , download : ${img_download_name}? = nil , complete : ${img_complete_name}? = nil){
        guard let url = URL(string: urlStr) else {
            self.base.image = placeholderImg
            return
        }
        load(url: url, placeholderImg: placeholderImg , download: download , complete: complete)
    }
    public func load(url : URL?,placeholderImg : UIImage? = nil , download : ${img_download_name}? = nil  , complete : ${img_complete_name}? = nil){
        guard let url = url else {
            self.base.image = placeholderImg
            return
        }
        self.base.kf.setImage(with: url, placeholder: placeholderImg, options: nil) { current, total in
            let progress = CGFloat(current) / CGFloat(total)
            download?(progress)
        } completionHandler: { result in
            switch result {
            case .success(let imgResult):
                complete?(imgResult.image)
            default:
                complete?(nil)
            }
        }
    }
}
" >> $ex_folder_name"/"$imageView_name$class_suffix

}

function setupButton(){
auth_info=`sh authorInfo.sh ${project_name} ${button_name}${class_suffix}`

echo "${auth_info}
import Foundation
import UIKit

/// 按钮图片的位置
public enum ${class_prefix}ButtonImgLocation {
    case left
    case right
    case top
    case bottom
}

extension ${target_class_name} where Base : UIButton {
    /// 初始化
    /// - Parameters:
    ///   - title: 文字
    ///   - titleColor: 文字颜色
    ///   - img: 图片
    ///   - textFont: 文字大小
    /// - Returns: 当前对象
    public static func initBtn(title : String? = nil,titleColor : UIColor? = nil,img : UIImage?=nil,textFont : UIFont = UIFont.${class_prefix_lowercased}.font(size: 16))->Base{
        let btn = Base(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.setImage(img, for: .normal)
        btn.titleLabel?.font = textFont
        return btn
    }
    /// 设置文字 图片不同状态
    /// - Parameters:
    ///   - title: 文字
    ///   - titleCOlor: 文字颜色
    ///   - img: 图片
    ///   - state: 状态
    public func set(title : String?,titleColor : UIColor?,img : UIImage?,state : Base.State){
        self.base.setTitle(title, for: state)
        self.base.setTitleColor(titleColor, for: state)
        self.base.setImage(img, for: state)
    }
    /// 设置图片的位置 跟文字间距
    /// - Parameters:
    ///   - location: 图片位置
    ///   - space: 间距
    public func set(img location : ${class_prefix}ButtonImgLocation, space : CGFloat){
        
        guard self.base.imageView != nil else {
            return
        }
        guard self.base.titleLabel != nil else {
            return
        }
        
        let imageView_Width = self.base.imageView?.frame.size.width
        let imageView_Height = self.base.imageView?.frame.size.height
        let titleLabel_iCSWidth = self.base.titleLabel?.intrinsicContentSize.width
        let titleLabel_iCSHeight = self.base.titleLabel?.intrinsicContentSize.height
        
        switch location {
        case .left:
            if self.base.contentHorizontalAlignment == .left {
                self.base.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: space, bottom: 0, right: 0)
            } else if self.base.contentHorizontalAlignment == .right {
                self.base.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: space)
            } else {
                let spacing_half = 0.5 * space;
                self.base.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -spacing_half, bottom: 0, right: spacing_half)
                self.base.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: spacing_half, bottom: 0, right: -spacing_half)
            }
        case .right:
            let titleLabelWidth = self.base.titleLabel?.frame.size.width
            if self.base.contentHorizontalAlignment == .left {
                self.base.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: titleLabelWidth! + space, bottom: 0, right: 0)
                self.base.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageView_Width!, bottom: 0, right: 0)
            } else if self.base.contentHorizontalAlignment == .right {
                self.base.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -titleLabelWidth!)
                self.base.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: imageView_Width! + space)
            } else {
                let imageOffset = titleLabelWidth! + 0.5 * space
                let titleOffset = imageView_Width! + 0.5 * space
                self.base.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: imageOffset, bottom: 0, right: -imageOffset)
                self.base.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -titleOffset, bottom: 0, right: titleOffset)
            }
        case .top:
            self.base.imageEdgeInsets = UIEdgeInsets.init(top: -(titleLabel_iCSHeight! + space), left: 0, bottom: 0, right: -titleLabel_iCSWidth!)
            self.base.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageView_Width!, bottom: -(imageView_Height! + space), right: 0)
        case .bottom:
            self.base.imageEdgeInsets = UIEdgeInsets.init(top: titleLabel_iCSHeight! + space, left: 0, bottom: 0, right: -titleLabel_iCSWidth!)
            self.base.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageView_Width!, bottom: imageView_Height! + space, right: 0)
        }
    }
}

" >> $ex_folder_name"/"$button_name$class_suffix

}

function setupScrollView(){
auth_info=`sh authorInfo.sh ${project_name} ${scrollView_name}${class_suffix}`

echo "${auth_info}
import Foundation
import UIKit

extension ${target_class_name} where Base : UIScrollView {
    
    @discardableResult
    public func addHeaderRefresh(complete : ()->Void) -> Base{
        complete()
        return self.base
    }
    @discardableResult
    public func addFooterRefresh(complete : ()->Void) -> Base{
        complete()
        return self.base
    }
    public func stopRefresh(isNoMoreDate : Bool){
        
    }
    public func startRefresh(){
        
    }
}
" >> $ex_folder_name"/"$scrollView_name$class_suffix
}

function setupTableView(){
auth_info=`sh authorInfo.sh ${project_name} ${tableView_name}${class_suffix}`

echo "${auth_info}
import Foundation
import UIKit

extension ${target_class_name} where Base : UITableView {
    public static func initTable(style :Base.Style = .plain,rowHeight : CGFloat = 44,cellType : UITableViewCell.Type? = nil)->Base{
        let table = Base(frame: .zero, style: style)
        table.separatorStyle = .none
        table.rowHeight = rowHeight
        if let type = cellType {
            table.register(type, forCellReuseIdentifier: type.${class_prefix_lowercased}.identifier())
        }
        return table
    }
}
" >> $ex_folder_name"/"$tableView_name$class_suffix

}

function setupCollectionView(){
auth_info=`sh authorInfo.sh ${project_name} ${collectionView_name}${class_suffix}`

echo "${auth_info}
import Foundation
import UIKit

extension ${target_class_name} where Base : UICollectionView{
    public static func initCollection(layout : UICollectionViewLayout?,cellType : UICollectionViewCell.Type?)->Base{
        let flowLayout = layout ?? UICollectionViewFlowLayout()
        let collectionView = Base(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        if let type = cellType {
            collectionView.register(type, forCellWithReuseIdentifier: type.${class_prefix_lowercased}.identifier())
        }
        return collectionView
    }
}

" >> $ex_folder_name"/"$collectionView_name$class_suffix

}

function setupNavVC(){
auth_info=`sh authorInfo.sh ${project_name} ${navVC_name}${class_suffix}`

echo "${auth_info}
import Foundation
import UIKit

extension ${target_class_name} where Base : UINavigationController {
    public static func initialize(){
        let navBar = UINavigationBar.appearance()
        navBar.setBackgroundImage(UIImage.${class_prefix_lowercased}.image(color: UIColor.white), for: .default)
        navBar.shadowImage = UIImage()
        navBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.${class_prefix_lowercased}.font(size: 20),NSAttributedString.Key.foregroundColor : UIColor.black]
    }
    public static var navHeight : CGFloat {
        44.0
    }
}
" >> $ex_folder_name"/"$navVC_name$class_suffix

}

function setupNavBar(){
auth_info=`sh authorInfo.sh ${project_name} ${navBar_name}${class_suffix}`

echo "${auth_info}
import Foundation
import UIKit

extension ${target_class_name} where Base : UINavigationBar {
    
}
" >> $ex_folder_name"/"$navBar_name$class_suffix
}

function setupImage(){
auth_info=`sh authorInfo.sh ${project_name} ${image_name}${class_suffix}`

echo "${auth_info}
import UIKit
extension ${target_class_name} where Base : UIImage {
    
    public static func image(color : UIColor,viewSize : CGSize = CGSize(width: 4, height: 4))->UIImage?{
        let rect: CGRect = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(color.cgColor)
        
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsGetCurrentContext()
        
        return image
    }
}
" >> $ex_folder_name"/"$image_name$class_suffix

}

function setupColor(){
auth_info=`sh authorInfo.sh ${project_name} ${color_name}${class_suffix}`

echo "${auth_info}
import UIKit

extension ${target_class_name} where Base : UIColor {
    
    public static func color(hexString : String,alpha : CGFloat = 1)-> Base{
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if hexString.hasPrefix(\"#\") {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        return self.color(rgb:red, g:green, b: blue, alpha: alpha)
    }
    /// RGB 转颜色
    /// - Parameters:
    ///   - r: r
    ///   - g: g
    ///   - b: b
    ///   - alpha: 透明度
    /// - Returns: 颜色
    public static func color(rgb r : CGFloat , g : CGFloat ,b : CGFloat , alpha : CGFloat = 1) -> Base{
        return Base(red: r, green: g, blue: b, alpha: alpha)
    }
    // UIColor -> Hex String
    public var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let multiplier = CGFloat(255.999999)
        guard self.base.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        
        if alpha == 1.0 {
            return String(
                format: \"#%02lX%02lX%02lX\",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: \"#%02lX%02lX%02lX%02lX\",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
}


" >> $ex_folder_name"/"$color_name$class_suffix

}

function setupFont(){
auth_info=`sh authorInfo.sh ${project_name} ${font_name}${class_suffix}`

echo "${auth_info}
import UIKit

public enum ${class_prefix}FontStyle {
    case \`default\`
    case bold
    case italic
}

extension ${target_class_name} where Base : UIFont {
    public static func font(_ style : ${class_prefix}FontStyle = .default,size : CGFloat) -> Base{
        if style == .bold {
            return Base.boldSystemFont(ofSize: size) as! Base
        }else if style == .italic {
            return Base.italicSystemFont(ofSize: size) as! Base
        }
        return Base.systemFont(ofSize: size) as! Base
    }
}

" >> $ex_folder_name"/"$font_name$class_suffix

}

function setupDateFormatter(){
auth_info=`sh authorInfo.sh ${project_name} ${dateFormatter_name}${class_suffix}`

echo "${auth_info}
import UIKit

extension ${target_class_name} where Base : DateFormatter {
    private static var dateFormater : Base {
        let formater = Base()
        return formater
    }
    
    public static func dateFormater(formater : String) ->  Base {
        let dateFormater = dateFormater
        dateFormater.dateFormat = formater
        return dateFormater
    }
    /// 格式为 yyyy-MM-dd HH:mm:ss
    public static func ymdhms() -> Base {
        return dateFormater(formater: \"yyyy-MM-dd HH:mm:ss\")
    }
    /// 格式为 yyyy-MM-dd
    public static func ymd() -> Base {
        dateFormater(formater: \"yyyy-MM-dd\")
    }
    /// 格式为 HH:mm:ss
    public static func hms() -> Base {
        dateFormater(formater: \"HH:mm:ss\")
    }
    /// 格式为 yyyy
    public static func year() -> Base {
        dateFormater(formater: \"yyyy\")
    }
    /// 格式为 MM
    public static func month() -> Base {
        dateFormater(formater: \"MM\")
    }
    /// 格式为 dd
    public static func day() -> Base {
        dateFormater(formater: \"dd\")
    }
    /// 格式为  HH
    public static func hour() -> Base {
        dateFormater(formater: \"HH\")
    }
    /// 格式为  mm
    public static func minute() -> Base {
        dateFormater(formater: \"mm\")
    }
    /// 格式为  ss
    public static func second() -> Base {
        dateFormater(formater: \"ss\")
    }

}
" >> $ex_folder_name"/"$dateFormatter_name$class_suffix

}

function setupString(){
auth_info=`sh authorInfo.sh ${project_name} ${string_name}${class_suffix}`

echo "${auth_info}
import Foundation

extension String : ${target_protocol} {
    
}

extension ${target_class_name} where Base == String {
    subscript(to index : Int) -> Base?{
        if index < self.base.count {
            return self.base.prefix(index).base
        }
  
        return nil
    }
    subscript(from index: Int) -> Base?{
        if index < self.base.count {
            return self.base.suffix(index).base
        }
        return nil
    }
    subscript(safe index : Int , length : Int) -> Base?{
        if index >= 0, index + length < self.base.count {
            let startIndex = self.base.index(self.base.startIndex, offsetBy: index)
            let endIndex = self.base.index(self.base.startIndex, offsetBy: index + length)
            return String(self.base[startIndex...endIndex])
        }
        return nil
    }
    public func toJson()->[String : Any]?{
        return nil
    }
    public func toArray()->[Any]?{
        return nil
    }
}

" >> $ex_folder_name"/"$string_name$class_suffix

}


function setupArray(){
auth_info=`sh authorInfo.sh ${project_name} ${array_name}${class_suffix}`

echo "${auth_info}
import Foundation

extension Array : ${target_protocol} {
    
}


extension ${target_class_name} where Base : Collection {
    subscript(safe index: Base.Index) -> Base.Element?{
        if self.base.indices.contains(index) {
            return self.base[index]
        }
        return nil
    }
    
    subscript(safe index :  Base.Index , length : Int) -> [Base.Element]{
         let endIndex = self.base.index(index, offsetBy: length)
        if endIndex <= self.base.endIndex{
           
        }
        return []
    }
    public func toString()->String?{
        return nil
    }
}

" >> $ex_folder_name"/"$array_name$class_suffix

}

function setupModelProtocol(){
auth_info=`sh authorInfo.sh ${project_name} ${model_protocol}${class_suffix}`

echo "${auth_info}
protocol ${model_protocol} : ${target_protocol} {
    
}

extension ${target_class_name} where Base : ${model_protocol} {
    internal static func model(with json : [String : Any]?)->Base?{
        return nil
    }
    internal static func model(with list : [[String : Any]]?)->[Base]?{
        return nil
    }
    internal static func model(with jsonString : String?)->Base?{
        return nil
    }
    internal func toString()->String?{
        return nil
    }
    internal func toJson()->[String : Any]?{
        return nil
    }
    internal func toModel()->Base?{
        return nil
    }
}
" >> $ex_folder_name"/"$model_protocol$class_suffix
}

function setupWindow(){
auth_info=`sh authorInfo.sh ${project_name} ${window_name}${class_suffix}`

echo "${auth_info}

import UIKit

extension ${target_class_name} where Base : UIWindow {
    
    public static func getWindow() -> UIWindow? {
        var window : UIWindow?
        if  #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first , let deletage =  windowScene.delegate as? SceneDelegate{
                window = deletage.window
            }
        }
        if window == nil,let w = UIApplication.shared.delegate?.window {
            window = w
        }
        return window
    }
}

" >> $ex_folder_name"/"$window_name$class_suffix

}

function setupScreen(){
auth_info=`sh authorInfo.sh ${project_name} ${screen_name}${class_suffix}`

echo "${auth_info}

import UIKit

extension ${target_class_name} where Base : UIScreen {
    static func width() -> CGFloat {
        return Base.main.bounds.size.width
    }
    static func height() ->  CGFloat {
        return Base.main.bounds.size.height
    }
    static func scale() ->  CGFloat {
        return Base.main.scale
    }
}

" >> $ex_folder_name"/"$screen_name$class_suffix
}

function setupDevice(){
auth_info=`sh authorInfo.sh ${project_name} ${device_name}${class_suffix}`

echo "${auth_info}

import UIKit

/// 设备类型
public enum ${class_prefix}DeviceType {
    case unknow
    case iphone
    case ipad
    case ipod
}

extension ${target_class_name} where Base : UIDevice {
    static var version : String {
        return Base.current.systemVersion
    }
    static var systemName : String {
        Base.current.systemName
    }
    static var name :  String {
        Base.current.name
    }
    static var model : String {
        Base.current.model
    }
    static var deviceType : ${class_prefix}DeviceType {
        let typeString = model
        var type : ${class_prefix}DeviceType = .unknow
        switch typeString {
        case \"iPhone\":
            type = .iphone
        case \"iPod touch\":
            type = .ipod
        case \"iPad\":
            type = .ipad
        default:
            type = .unknow
        }
        return type
    }
    static var isIpad :  Bool {
        if deviceType == .ipad {
            return true
        }
        return false
    }
    
}
" >> $ex_folder_name"/"$device_name$class_suffix
}

function setupNotification(){
auth_info=`sh authorInfo.sh ${project_name} ${notification_name}${class_suffix}`
complete_name=$class_prefix"NotificationComplete"
echo "${auth_info}

import UIKit

public typealias ${complete_name} = (_ notification : Notification)->Void

extension CYTarget where Base : NotificationCenter {
    
    public static func post(name : String , object : Any? = nil , userInfo : [AnyHashable : Any]? = nil){
        post(noifcationName: NSNotification.Name(name), object: object, userInfo: userInfo)
    }
    public static func post(noifcationName : NSNotification.Name , object : Any? = nil , userInfo : [AnyHashable : Any]? = nil){
        Base.default.post(name: noifcationName, object: object, userInfo: userInfo)
    }
    public static func add(name : String , object : Any? = nil , complete :  ${complete_name}?){
       add(notificationName: NSNotification.Name(name), object: object, complete: complete)
    }
    public static func add(notificationName : NSNotification.Name ,  object : Any? = nil , complete : ${complete_name}?){
        Base.default.addObserver(forName: notificationName, object: object, queue: nil) { notification in
            complete?(notification)
        }
    }
}

" >> $ex_folder_name"/"$notification_name$class_suffix
}

function init(){

setupTarget
setupProtocol
setupObject
setupView
setupLabel
setupImageView
setupButton
setupScrollView
setupTableView
setupCollectionView
setupNavVC
setupNavBar
setupImage
setupColor
setupFont
setupDateFormatter
setupString
setupArray
setupModelProtocol
setupWindow
setupScreen
setupDevice
setupNotification

}

init
