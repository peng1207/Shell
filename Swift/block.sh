#!/bin/bash
# 前缀
class_prefix=`sh ../readProperties.sh classPrefix`
# 项目名称
project_name=`sh ../readProperties.sh projectName`
class_file_name="${class_prefix}Block.swift"
auth_info=`sh authorInfo.sh ${project_name} ${class_file_name}`
echo "
    ${auth_info}
    
/// 空参数的闭包
typealias ${class_prefix}VoidBlock = ()->Void
/// IndexPath参数的闭包
typealias ${class_prefix}IndexPathBlock = (_ index : IndexPath)->Void
/// String 参数的闭包
typealias ${class_prefix}StringBlock = (_ str : String?)->Void
/// Int 参数的闭包
typealias ${class_prefix}IndexBlock = (_ index : Int)->Void
/// Any 参数的闭包
typealias ${class_prefix}AnyBlock = (_ any : Any?)->Void
/// Bool 参数的闭包
typealias ${class_prefix}BoolBlock = (_ isTrue : Bool)->Void
" >> $class_file_name


