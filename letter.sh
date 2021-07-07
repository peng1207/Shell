
value=$1
# 0 首字母小写 1 全部小写 2 全部大写
type_value=$2

# 首字母小写
function firstLowercase(){
first_lowercase=`echo ${value:0:1} | awk '{print tolower($0)}'`
first_lowercase=$first_lowercase${value:1}
value=$first_lowercase
}
# 全部小写
function allLowercase(){
value=$(echo $value | tr '[A-Z]' '[a-z]')
}
#全部大写
function allUppercase(){
value=$(echo $value | tr '[a-z]' '[A-Z]')
}

if [ "${type_value}" == "1" ];then
    allLowercase
elif [ "${type_value}" == "2" ];then
    allUppercase
else
    firstLowercase
fi

echo $value
