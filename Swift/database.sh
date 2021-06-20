#!/bin/bash
# 前缀
class_prefix=`sh ../readProperties.sh classPrefix`
# 项目名称
project_name=`sh ../readProperties.sh projectName`
class_name=$class_prefix"DataBase"
auth_info=`sh authorInfo.sh ${project_name} ${class_name}.swift`

DataBaseObject=$class_prefix"DataBaseObject"

base_folder_name="DataBase"
rm -rf $base_folder_name
mkdir $base_folder_name

echo "${auth_info}
import Foundation
import RealmSwift

typealias ${DataBaseObject} = Object

class ${class_name}  {
    /// 配置数据库
     class func configRealm(){
        /// 如果要存储的数据模型属性发生变化,需要配置当前版本号比之前大
        let dbVersion : UInt64 = 1
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = docPath.appending("/${project_name}DB.realm")
        
        let config = Realm.Configuration(fileURL: URL.init(string: dbPath), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: dbVersion, migrationBlock: { (migration, oldSchemaVersion) in
            
        }, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
        Realm.Configuration.defaultConfiguration = config
        Realm.asyncOpen { (result) in
            print(result)
        }
    
     }
}
extension ${class_name} {
    
   class func insert<T>(data : T) where T  : ${DataBaseObject}{
        let realm = try! Realm()
        try! realm.write {
       
            realm.add(data)
        }
    }
    class func getAll<T>()->[T] where T : ${DataBaseObject} {
        var list = [T]()
         let realm = try! Realm()
        let lists = realm.objects(T.self)
       
        for m in lists {
            list.append(m)
        }
        return list.reversed()
    }
    
    
}

" >>  $base_folder_name"/"$class_name".swift"
