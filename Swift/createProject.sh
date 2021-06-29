
# 前缀
class_prefix=`sh ../readProperties.sh classPrefix`
class_suffix=".swift"
echo "class_prefix ${class_prefix}"
# 项目名称
project_name=`sh ../readProperties.sh projectName`

original_name="TemplateProject"
tests_name="Tests"
uitests_name="UITests"
xcodeproj_name=".xcodeproj"
project_pbxproj="project.pbxproj"
new_project_pbxproj="newproject.pbxproj"
xcscheme_name=${original_name}".xcscheme"
new_xcscheme_name=${project_name}".xcscheme"



project_path="/Users/huangshupeng/Documents/Shell/"${project_name}

rm -rf ${project_path}
# 拷贝项目
cp -r TemplateProject ${project_path}
# 更改项目名称
mv ${project_path}"/"${original_name} ${project_path}"/"${project_name}
# 修改project文件中 项目名称
function replaceProject(){
mv ${project_path}"/"${original_name}${xcodeproj_name} ${project_path}"/"${project_name}${xcodeproj_name}
sed -e "s/${original_name}/${project_name}/" -e "s/${original_name}/${project_name}/" ${project_path}"/"${project_name}${xcodeproj_name}"/"${project_pbxproj} >  ${project_path}"/"${project_name}${xcodeproj_name}"/"${new_project_pbxproj}
rm -rf ${project_path}"/"${project_name}${xcodeproj_name}"/"${project_pbxproj}
mv ${project_path}"/"${project_name}${xcodeproj_name}"/"${new_project_pbxproj} ${project_path}"/"${project_name}${xcodeproj_name}"/"${project_pbxproj}
}


# 修改项目schemes 项目名称
function replaceScheme(){
sed -e "s/${original_name}/${project_name}/" ${project_path}"/"${project_name}${xcodeproj_name}"/"xcshareddata/xcschemes/${xcscheme_name} > ${project_path}"/"${project_name}${xcodeproj_name}"/"xcshareddata/xcschemes/${new_xcscheme_name}
rm -rf ${project_path}"/"${project_name}${xcodeproj_name}"/"xcshareddata/xcschemes/${xcscheme_name}
}


# 替换 tests 文件
function replaceTests(){
mv ${project_path}"/"${original_name}${tests_name} ${project_path}"/"${project_name}${tests_name}
sed -e "s/${original_name}/${project_name}/" ${project_path}"/"${project_name}${tests_name}"/"${original_name}${tests_name}${class_suffix} > ${project_path}"/"${project_name}${tests_name}"/"${project_name}${tests_name}${class_suffix}
rm ${project_path}"/"${project_name}${tests_name}"/"${original_name}${tests_name}${class_suffix}
}

# 替换 UITests
function replaceUITests(){
mv ${project_path}"/"${original_name}${uitests_name} ${project_path}"/"${project_name}${uitests_name}
sed -e "s/${original_name}/${project_name}/" ${project_path}"/"${project_name}${uitests_name}"/"${original_name}${uitests_name}${class_suffix} > ${project_path}"/"${project_name}${uitests_name}"/"${project_name}${uitests_name}${class_suffix}
rm ${project_path}"/"${project_name}${uitests_name}"/"${original_name}${uitests_name}${class_suffix}

}

# 替换 AppDelegate
function setupAppDelegate(){
appDelegate_name="AppDelegate"
auth_info=`sh authorInfo.sh ${project_name} ${appDelegate_name}.${class_suffix}`
appDelegate_path=${project_path}"/"${project_name}"/"${appDelegate_name}${class_suffix}
rm ${appDelegate_path}

echo "${auth_info}

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if  #available(iOS 13.0, *) {
            
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.backgroundColor = UIColor.white
            APPConfigure.loadRootVC()
            self.window?.makeKeyAndVisible()
        }
        return true
    }

       // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: \"Default Configuration\", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

" >> ${appDelegate_path}
}


# 替换 SceneDelegate
function setupSceneDelegate(){
sceneDelegate_name="SceneDelegate"
auth_info=`sh authorInfo.sh ${project_name} ${sceneDelegate_name}.${class_suffix}`
sceneDelegate_path=${project_path}"/"${project_name}"/"${sceneDelegate_name}${class_suffix}
rm ${sceneDelegate_path}

echo "${auth_info}

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow \`window\` to the provided UIWindowScene \`scene\`.
        // If using a storyboard, the \`window\` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see \`application:configurationForConnectingSceneSession\` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene )
        self.window?.frame = UIScreen.main.bounds
        self.window?.backgroundColor = .white
        APPConfigure.loadRootVC()
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see \`application:didDiscardSceneSessions\` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

" >> ${sceneDelegate_path}
}

app_path=$project_path"/"$project_name"/APP"
modules_path=$app_path"/Modules"
utility_path=$app_path"/Utility"
library_path=$project_path"/"$project_name"/Library"

function setupHomeDirectory(){
 
mkdir ${app_path}
mkdir ${modules_path}
mkdir ${utility_path}
mkdir ${library_path}

}

tabbar_vc_name=""
tabbar_list_vc=""
function setupTabbar(){
main_path=$app_path"/Main"
mkdir ${main_path}
main_vc_path=$main_path"/VC"
main_model_path=$main_path"/Model"
main_view_path=$main_path"/View"
main_vm_path=$main_path"/VM"

mkdir $main_vc_path
mkdir $main_model_path
mkdir $main_view_path
mkdir $main_vm_path
baseNavigationVC=`sh ../readProperties.sh baseNavigationVC`
tabbar_vc_name=$class_prefix"MainTabBarVC"
main_model_name=$class_prefix"MainModel"
main_configure_name=$class_prefix"MainConfigure"

auth_info=`sh authorInfo.sh ${project_name} ${tabbar_vc_name}.${class_suffix}`

echo "${auth_info}

import Foundation
import UIKit

class ${tabbar_vc_name} : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    
    private func initData(){
        self.view.backgroundColor = .white
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .white
        configureDefault()
        self.viewControllers = getListVC()
    }
    
    private func configureDefault(){
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.shadowColor = .black
            appearance.backgroundColor = .white
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            
            let normalAppearance = appearance.stackedLayoutAppearance.normal
            normalAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.paragraphStyle : style]
            
            let selectedAppearance = appearance.stackedLayoutAppearance.selected
            selectedAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.paragraphStyle : style]
           
            tabBar.standardAppearance = appearance
        } else {
            tabBar.barStyle = .default
            tabBarController?.tabBar.isTranslucent = false
            tabBar.shadowImage = UIImage()
            tabBar.backgroundImage = UIImage()
        }
    }
    
    private func getListVC()->[UIViewController]{
        var list : [UIViewController] = []
        for item in ${main_configure_name}.getMainVCConfigure() {
            if let vc = item.vc {
                let navVC = ${baseNavigationVC}(rootViewController: vc)
                navVC.tabBarItem = getTabarItem(model: item)
                list.append(navVC)
            }
        }
        
        return list
    }
    
    private func getTabarItem(model : ${main_model_name})-> UITabBarItem{
        let tmpTabbarItem = UITabBarItem(title: model.title, image: model
                                        .normalImg, selectedImage: model.selectImg)
        if let selectColor = model.selectColor {
            tmpTabbarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : selectColor], for: .selected)
        }
        if let normalColor = model.normalColor {
            tmpTabbarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : normalColor], for: .normal)
        }
        return tmpTabbarItem
    }
    
}


" >> ${main_vc_path}"/"${tabbar_vc_name}${class_suffix}

# 创建model

auth_info=`sh authorInfo.sh ${project_name} ${main_model_name}.${class_suffix}`

echo "${auth_info}

import Foundation
import UIKit

struct ${main_model_name} {
    var title : String = ""
    var selectImg : UIImage?
    var normalImg : UIImage?
    var selectColor : UIColor?
    var normalColor : UIColor?
    var vc : UIViewController?
}
" >> ${main_model_path}"/"${main_model_name}${class_suffix}

# 创建Configure
auth_info=`sh authorInfo.sh ${project_name} ${main_configure_name}.${class_suffix}`

echo "${auth_info}

import Foundation
import UIKit

class ${main_configure_name} {
        
     static func getMainVCConfigure()->[${main_model_name}]{
        var list : [YYMainModel] = []
        ${tabbar_list_vc}
        return list
    }
    private static func getMainModel(title : String,normalImg : UIImage?,selectImg : UIImage?,vc : UIViewController?) -> ${main_model_name}{
        var model = ${main_model_name}()
        model.title = title
        model.normalImg = normalImg
        model.selectImg = selectImg
        model.vc = vc
        model.normalColor = .black
        model.selectColor = .red
        return model
    }
    
}

" >> ${main_vm_path}"/"${main_configure_name}${class_suffix}

}


function setupVC(){

is_tabbar_vc="n"
echo "是否有tabbarContoller y/n"
read -r is_tabbar_vc

if [ "${is_tabbar_vc}" == "y" ];then
    # 创建tabbarContoller
    
    echo "是否为tabbar创建子控制器 y/n"
    read -r is_tabbar_vc
    
    if [ "${is_tabbar_vc}" == "y" ];then
        isBreak=1
        while [ ${isBreak} ]
        do
            echo "\n ***************************\n请输入模块的名称 若不需要，请按回车"
            modular_name=""
            read -r modular_name
            if [ "${modular_name}" != "" ];then
                sh modular.sh ${modular_name}
                
                mv ${modular_name} $modules_path"/"${modular_name}
                vc_name=$class_prefix$modular_name"VC"
                
                tabbar_list_vc=${tabbar_list_vc}"list.append(getMainModel(title: \"\", normalImg: nil, selectImg: nil, vc: ${vc_name}()))\n"
                
            else
                isBreak=0
                break
            fi
        
        
        done
        
        setupTabbar
        
    fi
    
fi

}


function setupAPPConfigure(){
#APPConfigure
appconfigure_name="APPConfigure"
auth_info=`sh authorInfo.sh ${project_name} ${appconfigure_name}.${class_suffix}`
appconfigure_path=${project_path}"/"${project_name}"/"${appconfigure_name}${class_suffix}
rm ${appconfigure_path}
root_vc_name="UIViewController"
if [ "${tabbar_vc_name}" != "" ];then
    root_vc_name=$tabbar_vc_name
fi

echo "${auth_info}
import Foundation
import UIKit

class APPConfigure {
    
    /// 加载主控制器
    static func loadRootVC(){
        var window : UIWindow?
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first , let deletage =  windowScene.delegate as? SceneDelegate{
                window = deletage.window
            }
        }
        if window == nil,let w = UIApplication.shared.delegate?.window {
            window = w
        }
        window?.rootViewController = getRootVC()
    }
    /// 获取主控制器
    /// - Returns: 控制器
    private static func getRootVC()->UIViewController{
        return ${root_vc_name}()
    }
}
" >> ${appconfigure_path}
}

function setupBaseClass(){
sh baseClass.sh "Base"
mv "Base" $library_path"/Base"

}

function setupExtension(){
extension_name="Extension"
sh extension.sh ${extension_name}
mv ${extension_name} $library_path"/"$extension_name
}

function setupNewWork(){
echo "是否需要网络请求 y/n"
}

function setupDataBase(){
echo "是否需要数据库，本地缓存 y/n"
}

function setupPushNotification(){
echo "是否需要推送功能 y/n"
}

function setupLocation(){
echo "是否需要定位功能 y/n"
echo "是否需要地图功能 y/n"
}

function setupAppleHealthy(){
echo "是否需要苹果健康数据 y/n"
}

function setupPhotoCamera(){
echo "是否需要相机、相册功能 y/n"

}

function setupAudio(){
echo "是否需要音频功能 y/n"
}

function setupVideo(){
echo "是否需要视频播放功能 y/n"
}
# 其它模块 比如protocol block enum
function setupOther(){
echo "创建其它模块"
other_path=$library_path"/Other"
rm -rf ${other_path}

mkdir $other_path
sh block.sh
sh protocol.sh
sh enum.sh

mvFile $class_prefix"Block"$class_suffix
mvFile $class_prefix"Protocol"$class_suffix
mvFile $class_prefix"Enum"$class_suffix

function mvFile(){
class_name=$1
mv $class_name  $other_path"/"$class_name

}

}

function setupPodfile(){
file_name=$project_path"/Podfile"
echo $file_name
rm $file_name

echo "
# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'

target '${project_name}' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ${project_name}
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'
  pod 'HandyJSON'
  pod 'Kingfisher'
  pod 'RealmSwift'
  pod 'SnapKit'
  target '${project_name}Tests' do
    inherit! :search_paths
    # Pods for testing
  end

  target '${project_name}UITests' do
    # Pods for testing
  end

end
" >> $file_name
}

function init(){

replaceProject
replaceScheme
replaceTests
replaceUITests
setupAppDelegate
setupSceneDelegate
setupHomeDirectory
setupVC
setupAPPConfigure
setupBaseClass
setupExtension
setupOther
setupNewWork
setupDataBase
setupPushNotification
setupLocation
setupAppleHealthy
setupPhotoCamera
setupAudio
setupVideo
setupPodfile
git init ${project_path}

current_path=$PWD
echo ${current_path}
cd ${project_path}
pod install --verbose
cd ${current_path}

}

init
 



