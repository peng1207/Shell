#!/bin/bash
# 前缀
class_prefix=`sh ../readProperties.sh classPrefix`
# 文件后缀
class_suffix=".swift"
# 项目名称
project_name=`sh ../readProperties.sh projectName`
class_name=$class_prefix"RequestManager"
request_model_name=$class_prefix"RequestModel"
auth_info=`sh authorInfo.sh ${project_name} ${class_name}${class_suffix}`

base_folder_name="NetWork"
rm -rf $base_folder_name
mkdir $base_folder_name

echo "${auth_info}
import Foundation
import Alamofire

// 封装请求类 减少跟第三方接触
enum ${class_prefix}HttpMethod {
    case get
    case post
    case head
    case put
    case delete
}

enum ${class_prefix}ResponseFormat {
    case none
    case json
    case data
    case string
}
typealias ${class_prefix}RequestBlock = (_ data : Any? ,_ error: Error?) -> Void

class ${class_name} {
    static fileprivate var requestCacheArr = [DataRequest]()
    
    class func request(_ requestModel : ${class_prefix}RequestModel,requestBlock : ${class_prefix}RequestBlock?) {
        guard let url = requestModel.url else {
           
            if  let block = requestBlock {
                block(nil,nil)
            }
            return
        }
     
        guard let requestUrl = URL(string: url) else {
           
            if  let block = requestBlock {
                block(nil,nil)
            }
            return
        }
        
        var httpMethod : HTTPMethod = .post
        switch requestModel.httpMethod {
        case .get:
            httpMethod = .get
        case .post:
            httpMethod = .post
        case .head :
            httpMethod = .head
        case .put :
            httpMethod = .put
        case .delete:
            httpMethod = .delete
        }
        let dataRequest = Alamofire.AF.request(requestUrl, method: httpMethod, parameters: requestModel.parm)
 
     
        requestModel.isRequest = true
    
        switch requestModel.reponseFormt {
        case .json:
           
            dataRequest.responseJSON { dataResponse in
                requestSuccess(dataResponse: dataResponse, requestModel: requestModel, requestBlock: requestBlock)
            }
        case .data:
            dataRequest.responseData { dataResponse in
                requestSuccess(dataResponse: dataResponse, requestModel: requestModel, requestBlock: requestBlock)
            }
        case .string:
            dataRequest.responseString { dataResponse in
                requestSuccess(dataResponse: dataResponse, requestModel: requestModel, requestBlock: requestBlock)
            }
        default:
            dataRequest.response { dataReponse  in
                requestSuccess(dataResponse: dataReponse, requestModel: requestModel, requestBlock: requestBlock)
            }
        }
        self.requestCacheArr.append(dataRequest)
    }
    
    static func  requestSuccess<T>(dataResponse : AFDataResponse<T> , requestModel : ${request_model_name} ,requestBlock : ${class_prefix}RequestBlock?){
        requestModel.isRequest = false
        guard let block = requestBlock else {
            return
        }
        block(dataResponse.value,dataResponse.error)
       
    }
    class func removeAllCache(){
        for task in self.requestCacheArr {
            task.cancel()
        }
        self.requestCacheArr.removeAll()
    }
    class func remove(task:DataRequest) {
        
    }
    
}


" >> $base_folder_name"/"$class_name$class_suffix


auth_info=`sh authorInfo.sh ${project_name} ${request_model_name}${class_suffix}`
echo "${auth_info}
import Foundation

class ${class_prefix}RequestModel {
    /// 请求链接
    var url : String?
    /// 请求参数
    var parm : [String: Any]?
    /// 是否正在请求中
    var isRequest : Bool = false
    var httpMethod : ${class_prefix}HttpMethod = .post
    var reponseFormt : ${class_prefix}ResponseFormat = .json
    //MARK: 上传文件需要的数据
    /// 文件数据
    var data : [Data]?
    /// 名称
    var name : String?
    /// 文件名称
    var fileName : [String]?
    /// 文件类型
    var mineType : String?
}
" >> $base_folder_name"/"$request_model_name$class_suffix
