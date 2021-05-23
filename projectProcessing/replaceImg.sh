
#需要被更改的图片的目录
directory=$1
# 图片路径 替换的图片
img_path=$2

if [ "$directory" = "" ];then
    echo "请输入需要更改图片的目录"
    read -r directory
fi

if [ "$img_path" = "" ];then
    echo "请输入替换图片的路径"
    read -r img_path
fi


function replaceImg(){
file_name=$1
img_size=`sips -g pixelWidth -g pixelHeight $file_name`
echo $img_size
w=-1
h=0
for item in $img_size
do
  
    if [ "$file_name" = "$item" ];then
            echo "图片链接"
    elif [ "$item" = "pixelWidth:" ];then
            echo "is pixelWidth"
    elif [ "$item" = "pixelHeight:" ];then
            echo "is pixelHeight"
    else
            echo "item $item"
            if [ $w -eq -1 ];then
                w=$[item]
            else
                h=$[item]
            fi
    fi

done
echo "$w $h"
cp $img_path $file_name
sips -z $w $h $file_name
}


if [ "$directory" = "" -o "$img_path" = "" ];then
    echo "不能进行操作 目录或图片为空"
else
    file_list=`find $directory -name "*.png"`
    echo $file_list
    for item in $file_list
    do
          replaceImg $item
    done
fi

