#!/usr/bin/env bash
#!/bin/bash
appIcon_path="/Users/huangshupeng/Documents/test/ScanProject/ScanProject/Assets.xcassets/AppIcon.appiconset"
appIconJson_path="$appIcon_path/Contents.json"

image_path='/Users/huangshupeng/Documents/Shell/1024.png'
size_values=`cat $appIconJson_path|awk -F"[size]" '/size/{print $0}'`
echo "\nget image size"
mails=$(echo $size_values | tr "," " ")
index=0
size_list=()
for addr in $mails
do
    if [ $addr != ":" ];then
        if [ $addr != '"size"' ];then
            size_list[$(($index))]=$addr
            echo "$index === $addr"
            let "index++"
        fi
    fi
done
echo "\n ------*******-----"


echo $size_values

echo "\nget image filename"
filename_values=`cat $appIconJson_path|awk -F"[filename]" '/filename/{print $0}'`
filename_mails=$(echo $filename_values | tr "," " ")
index=0
filename_list=()
for addr in $filename_mails
do
    if [ $addr != ":" ];then
        if [ $addr != '"filename"' ];then
            filename_list[$(($index))]=$addr
            echo "$index === $addr"
            let "index++"
        fi
    fi
done
 
echo "\nget image scale"
scale_values=`cat $appIconJson_path|awk -F"[scale]" '/scale/{print $0}'`
scale_mails=$(echo $scale_values | tr "," " ")
index=0
scale_list=()
for addr in $scale_mails
do
    if [ $addr != ":" ];then
        if [ $addr != '"scale"' ];then
            scale_list[$(($index))]=$addr
            echo "$index === $addr"
            let "index++"
        fi
    fi
done

function removeStr(){
value=$1
value=${value#\"}
value=${value%\"}
echo $value
}

#读取数据
size_list_length=${#size_list[@]}
echo $size_list_length
for ((i=0; i<$size_list_length; i++))
do
    size=${size_list[$i]}
    filename=${filename_list[$i]}
    scale=${scale_list[$i]}
    size_=$(echo $size | tr "x" " ")
    w=0
    h=0
    for addr in $size_
    do
        addr=`removeStr $addr`
        echo "----- $addr"
        if [ $w -eq 0 ];then
            w=$[addr]
        else
            h=$[addr]
        fi
      
    done
    echo "w $w h $h"
        filename=`removeStr $filename`
    echo "i is $i value is $w x $h  filename $filename scale $scale"
    multiple=1
    if [ $scale == '"2x"' ];then
        echo "2x"
        multiple=2
    elif [ $scale == '"3x"' ];then
        echo "3x"
        multiple=3
    else
        echo "1x"
        multiple=1
    fi
    w=$(($w*$multiple))
    h=$(($h*$multiple))
    echo "w is $w h is $h"
    new_icon_path="$appIcon_path/$filename"
    echo $new_icon_path
    echo $image_path
    cp $image_path $new_icon_path
    sips -z $w $h $new_icon_path
done


 
