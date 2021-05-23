
# 版本号
version=$1
# build的版本 上传appstore需要的
build_version=$2
# 打包类型
archiveType=$3


if [ "$version" = "" ];then
    echo "请输入版本号"
    read -r version
fi

if [ "$build_version" = "" ];then
    echo "请输入BundleVersion"
    read -r build_version
fi

if [ "$archiveType" = "" ];then
    echo "请输入打包类型 0 dev 1 adhoc 3 appstore 若输入空或其他默认为appstore"
    read -r archiveType
fi


dev_code="0"
adhoc_code="1"
appstore_code="3"


if [ "$archiveType" = "0" -o "$archiveType" = "1" ];then
   echo "archiveType is ${archiveType}"
else
    archiveType=$appstore_code
fi

appstore_user=""
appstore_pwd=""

if [ "$archiveType" = "$appstore_code" ];then
    echo "是否自动上传到appstore  y/n"
    is_upload_appstore=""
    read -r is_upload_appstore
    if [ "$is_upload_appstore" = "y" ];then
            echo "请输入上传到appstore的账号"
            read -r appstore_user
            echo "请输入 App专用的密码"
            read -r appstore_pwd
    fi

fi
# 当前的目录
current_path=$PWD
projectInfo_plist_path="${current_path}/projectInfo.plist"
echo "projectInfo_plist_path is $projectInfo_plist_path"
# info plist 的路径
info_plist_path=$(/usr/libexec/PlistBuddy -c "print infoPlistPath" "${projectInfo_plist_path}")
# 项目名称
project_name=$(/usr/libexec/PlistBuddy -c "print projectName" "${projectInfo_plist_path}")
# 打包项目的路径
project_path=$(/usr/libexec/PlistBuddy -c "print projectPath" "${projectInfo_plist_path}")
# teamID
teamID=$(/usr/libexec/PlistBuddy -c "print teamID" "${projectInfo_plist_path}")
# ipa 保存的路径
ipa_path="$current_path/$project_name"
ipa_name_path="$ipa_path/$project_name.ipa"
# archive 路径
archive_path="${project_path}/${project_name}.xcarchive"
# 打包mobileprovision的名称 不带后缀.mobileprovision
provisioningProfile=""
# 打包方式
method="app-store"
#签名证书
signingCertificate="Apple Distribution"
build_configuration="Release"
if [ "$archiveType" = "$dev_code" ];then
    provisioningProfile=$(/usr/libexec/PlistBuddy -c "print mobileprovisionOfDev" "${projectInfo_plist_path}")
    method="development"
    signingCertificate="Apple Development"
    build_configuration="Debug"
elif [ "$archiveType" = "$adhoc_code" ];then
    provisioningProfile=$(/usr/libexec/PlistBuddy -c "print mobileprovisionOfAdHoc" "${projectInfo_plist_path}")
    method="ad-hoc"
else
    provisioningProfile=$(/usr/libexec/PlistBuddy -c "print mobileprovisionOfAppstore" "${projectInfo_plist_path}")
    method="app-store"
fi

if [ "$project_path" = "" ];then
    echo "项目路径为空 无法进行打包 请到projectInfo.plist 中配置"
    exit
fi

if [ "$project_name" = "" ];then
    echo "项目名称为空 无法进行打包 请到projectInfo.plist 中配置"
    exit
fi

if [ "$info_plist_path" = "" ];then
    info_plist_path="${project_path}/${project_name}/Info.plist"
fi
echo "info_plist_path is ${info_plist_path}"
if [ "$version" != "" ];then
    echo "version is ${version}"
    $(/usr/libexec/PlistBuddy -c "Set CFBundleShortVersionString ${version} " "${info_plist_path}")
fi

if [ "$build_version" != "" ];then
    echo "version is ${build_version}"
        $(/usr/libexec/PlistBuddy -c "Set CFBundleVersion ${build_version} " "${info_plist_path}")
fi
cd $project_path


bundle_identifier=$(/usr/libexec/PlistBuddy -c "print CFBundleIdentifier" "${projectInfo_plist_path}")
echo "bundle_identifier is $bundle_identifier"
#EXPANDED_BUNDLE_ID=$PRODUCT_BUNDLE_IDENTIFIER
#echo "EXPANDED_BUNDLE_ID is $EXPANDED_BUNDLE_ID"
#if [ "$bundle_identifier" != "" ];then
#     $(/usr/libexec/PlistBuddy -c "Set CFBundleIdentifier ${bundle_identifier} " "${info_plist_path}")
#fi

 
echo "生成ExportOptions.plist"
# $(/usr/libexec/PlistBuddy -c "Add :${version_domain} string 00" ${version_path})
exportOptions_plist_path="${current_path}/ExportOptions.plist"

if [ -f "$exportOptions_plist_path" ];then
    rm -r $exportOptions_plist_path
fi

$(/usr/libexec/PlistBuddy -c "Add :destination string export" ${exportOptions_plist_path})
$(/usr/libexec/PlistBuddy -c "Add :method string ${method}" ${exportOptions_plist_path})
$(/usr/libexec/PlistBuddy -c "Add :signingStyle string manual" ${exportOptions_plist_path})
$(/usr/libexec/PlistBuddy -c "Add :stripSwiftSymbols bool NO" ${exportOptions_plist_path})
$(/usr/libexec/PlistBuddy -c "Add :teamID string ${teamID}" ${exportOptions_plist_path})

$(/usr/libexec/PlistBuddy -c "Add :signingCertificate string ${signingCertificate}" ${exportOptions_plist_path})
$(/usr/libexec/PlistBuddy -c "Add :provisioningProfiles dict" ${exportOptions_plist_path})
$(/usr/libexec/PlistBuddy -c "Add :provisioningProfiles:${bundle_identifier} string ${provisioningProfile}" ${exportOptions_plist_path})
# compileBitcode
#$(/usr/libexec/PlistBuddy -c "Add :compileBitcode bool YES" ${exportOptions_plist_path})
#thinning
if [ "$archiveType" = "$dev_code" -o  "$archiveType" = "$adhoc_code" ];then
$(/usr/libexec/PlistBuddy -c "Add :thinning string <none>" ${exportOptions_plist_path})
fi
#exit
#echo "清除"
xcodebuild clean -workspace "${project_name}.xcworkspace" -scheme "${project_name}" -configuration "$build_configuration"
echo "archive "
xcodebuild archive -workspace "${project_name}.xcworkspace" -scheme "${project_name}" -configuration "$build_configuration" -archivePath "${archive_path}" PROVISIONING_PROFILE_SPECIFIER="${provisioningProfile}"
echo "导出ipa"
echo "archive_path is ${archive_path}"
xcodebuild -exportArchive -archivePath "${archive_path}" -exportPath "${ipa_path}" -exportOptionsPlist "${exportOptions_plist_path}"


if [ "$appstore_user" != "" -a "$appstore_pwd" != "" -a -f "$ipa_name_path" ];then
    echo "执行上传"
    upload_path="${current_path}/uploadAppStore.sh"
    sh $upload_path $ipa_name_path $appstore_user $appstore_pwd
fi

rm -rf $archive_path
