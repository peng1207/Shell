

# 前缀
class_prefix=`sh ../readProperties.sh classPrefix`
echo "class_prefix ${class_prefix}"
# 项目名称
project_name=`sh ../readProperties.sh projectName`
# 文件后缀
class_suffix=".swift"

class_name=$1

if [ "$class_name" == "" ];then
echo "\n请输入类名 比如 YYHomeModel 只输入Home就可以的 前缀和后缀自动填充"
read -r class_name
fi

if [ "$class_name" == "" ];then
exit
else
class_name=$class_prefix$class_name"Model"
fi

isBreak=1
value_list=""
while [ $isBreak ]
do
echo "添加属性变量 请输入属性的类型 0:String 1:Int、2:Float、3:Double、4:[String : Any]、5:[Any]、6:Set<Any>、7：Any、8：model 输入其它或回车退出当前流程"
type_value=""
read -r type_value

if [ "${type_value}" == "0" ];then
type_value="String"
elif [ "${type_value}" == "1" ];then
type_value="Int"
elif [ "${type_value}" == "2" ];then
type_value="Float"
elif [ "${type_value}" == "3" ];then
type_value="Double"
elif [ "${type_value}" == "4" ];then
type_value="[String : Any]"
elif [ "${type_value}" == "5" ];then
type_value="[Any]"
elif [ "${type_value}" == "6" ];then
type_value="Set<Any>"
elif [ "${type_value}" == "7" ];then
type_value="Any"
elif [ "${type_value}" == "8" ];then
echo "请输入model的全称"
read -r type_value
else
    break;
fi
variable_value=""
echo "请输入变量名字"
read -r variable_value

isVariable=""
optional_value=""
echo "该变量是否可变(var let) y:var n : let;defalut value is var"
read -r isVariable

if [ "${isVariable}" == "n" ];then
isVariable="let"
else
isVariable="var"
fi

echo "该变量是否可选 y：可选(?) n:不可选(!) 默认为不可选"
read -r optional_value
if [ "${optional_value}" == "n" ];then
optional_value="!"
else
optional_value="?"
fi

# 默认值
default_value=""
if [ "${optional_value}" == "!" ];then
echo "请输入默认值"
read -r default_value
fi

value_list=$value_list$isVariable" "$variable_value" : "$type_value$optional_value
if [ "$default_value" == "" ];then
value_list=$value_list"\n    "
else
value_list=$value_list" = "$default_value"\n    "
fi

done

auth_info=`sh authorInfo.sh ${project_name} ${class_name}.${class_suffix}`
echo "${auth_info}
import Foundation

 struct ${class_name} : ${class_prefix}ModelProtocol {
     ${value_list}
 }
" >> $class_name$class_suffix
