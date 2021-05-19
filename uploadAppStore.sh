# 需要上传ipa的路径
ipa_path=$1;

# 上传到appstore的账号
appstore_account=$2;
# App专用的密码  登录 https://appleid.apple.com/ 安全栏有一个App 专用密码，点击生成一个
appstore_pwd=$3;
ipa_name=".ipa"

result=$(echo $ipa_path | grep "$ipa_name")
if [ "$ipa_path" = "" -o "$result" == "" ];then
    echo "请输入上传ipa的路径"
    read -r ipa_path
fi

if [ "$appstore_account" = "" ];then
echo "请输入上传到appstore的账号"
read -r appstore_account
fi

if [ "$appstore_pwd" = "" ];then
echo "请输入 App专用的密码"
read -r appstore_pwd
fi

echo $ipa_path;
echo $appstore_account;
echo $appstore_pwd;

result=$(echo $ipa_path | grep "$ipa_name")
if [ "$ipa_path" = "" -o "$result" == "" ];then
    echo "上传的ipa的路径为空或错误的文件"
elif [ "$appstore_account" = "" -o "$appstore_pwd" = "" ];then
    echo "账号或密码为空"
else
    echo "正在上传"
    xcrun altool --upload-app -f $ipa_path -u ${appstore_account} -p $appstore_pwd --verbose
    echo "有提示 No errors uploading 证明上传成功"
fi


