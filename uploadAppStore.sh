# 需要上传ipa的路径
ipa_path=$1;
# 上传到appstore的账号
appstore_account=$2;
# App专用的密码  登录 https://appleid.apple.com/ 安全栏有一个App 专用密码，点击生成一个
appstore_pwd=$3;
echo $ipa_path;
echo $appstore_account;
echo $appstore_pwd;

echo "正在上传"
xcrun altool --upload-app -f $ipa_path -u ${appstore_account} -p $appstore_pwd --verbose
echo "上传成功"
