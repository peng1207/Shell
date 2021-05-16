#!/bin/bash
#Extension文件夹名称
ex_folder_name="Extension"

# 前缀
class_prefix=`sh ../readProperties.sh classPrefix`
# 项目名称
project_name=`sh ../readProperties.sh projectName`


mkdir $ex_folder_name

label_file_name=$class_prefix"Label.swift"
tableView_file_name=$class_prefix"TableView.swift"
button_file_name=$class_prefix"Button.swift"
color_file_name=$class_prefix"Color.swift"
# 创建Label扩展
auth_info=`sh authorInfo.sh ${project_name} ${label_file_name}`
echo " ${auth_info}
import Foundation
import UIKit
extension NSObjectProtocol where Self : UILabel{
    /// 初始化
    /// - Parameters:
    ///   - text: 内容
    ///   - font: 字体大小
    ///   - textColor: 颜色
    ///   - textAlignment: 文字对齐
    ///   - numberOfLines: 行数
    /// - Returns: 当前对象
    static func initlabel(text: String? = nil, font : UIFont = UIFont.systemFont(ofSize: 16),textColor:UIColor = UIColor.black,textAlignment : NSTextAlignment = .left,numberOfLines : Int = 1) -> Self{
        let label = Self()
        label.font = font
        label.text = text
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        return label
    }
}
" >> $label_file_name
# 创建TabelView 扩展
auth_info=`sh authorInfo.sh ${project_name} ${tableView_file_name}`
echo "${auth_info}
import Foundation
import UIKit
extension NSObjectProtocol where Self : UITableView{
    /// 初始化
    /// - Parameters:
    ///   - style: 风格
    ///   - rowHeight: 高度
    /// - Returns: 当前对象
    static func initTable(style : UITableViewStyle = .plain,rowHeight : CGFloat = 44)->Self{
        let table = Self(frame: .zero, style: style)
        table.separatorStyle = .none
        table.rowHeight = rowHeight
        return table
    }
}
" >> $tableView_file_name
# 创建Button扩展
auth_info=`sh authorInfo.sh ${project_name} ${button_file_name}`
echo "${auth_info}
import Foundation
import UIKit
extension NSObjectProtocol where Self : UIButton{
    /// 初始化
    /// - Parameters:
    ///   - title: 默认标题
    ///   - titleColor: 默认标题颜色
    ///   - img: 默认图片
    ///   - textFont: 字体大小
    /// - Returns: 当前对象
    static func initBtn(title : String? = nil,titleColor : UIColor? = nil,img : UIImage?=nil,textFont : UIFont = UIFont.systemFont(ofSize: 18))->Self{
        let btn = Self(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.setImage(img, for: .normal)
        btn.titleLabel?.font = textFont
        return btn
    }
}" >> $button_file_name
#创建UIColor扩展
auth_info=`sh authorInfo.sh ${project_name} ${color_file_name}`
echo "${auth_info}
import Foundation
import UIKit
public extension UIColor{
    /// 十六进制字符串颜色值转颜色
    /// - Parameters:
    ///   - hex: 十六进制字符串颜色值
    ///   - alpha: 透明度([0,1]) 默认为1
    /// - Returns: 颜色
    class func color (hex: String,alpha: CGFloat = 1) -> UIColor {
        var cString: String = hex.uppercased().trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        if (cString.count != 6) {
            return UIColor.gray
        }
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        return UIColor.color(rgb: CGFloat(r), g: CGFloat(g), b: CGFloat(b), alpha: alpha)
    }
    /// RGB 转颜色
    /// - Parameters:
    ///   - r: r
    ///   - g: g
    ///   - b: b
    ///   - alpha: 透明度
    /// - Returns: 颜色
    class func color(rgb r : CGFloat , g : CGFloat ,b : CGFloat , alpha : CGFloat = 1) -> UIColor{
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
}
/// 十六进制字符串颜色值转颜色
/// - Parameters:
///   - hex: 十六进制字符串颜色值
///   - alpha: 透明度([0,1]) 默认为1
/// - Returns: 颜色
public func ${class_prefix}Color(for hex: String,alpha: CGFloat = 1) -> UIColor{
    return UIColor.color(hex: hex,alpha: alpha)
}
/// rgb转字符串
/// - Parameters:
///   - r: r
///   - g: g
///   - b: b
///   - alpha: 透明度
/// - Returns: 颜色
public func ${class_prefix}Color(withRbg r :CGFloat, g : CGFloat,b : CGFloat, alpha: CGFloat = 1)->UIColor{
    return UIColor.color(rgb: r, g: g, b: b, alpha: alpha)
}
" >> $color_file_name


mv "${label_file_name}" "${ex_folder_name}/"
mv "${tableView_file_name}" "${ex_folder_name}/"
mv "${button_file_name}" "${ex_folder_name}/"
mv "${color_file_name}" "${ex_folder_name}/"
