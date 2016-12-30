//
//  NetworkingTools.swift
//  Swift网络框架封装
//
//  Created by ZH on 2016/11/14.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit
import AFNetworking

enum HTTPMethod:Int {
    case GET = 0
    case POST
}

class NetworkingTools: AFHTTPSessionManager {
    // MARK:- 网络单例工具
    static let shared: NetworkingTools = {
        let tools = NetworkingTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        tools.responseSerializer.acceptableContentTypes?.insert("text/json")
        tools.requestSerializer = AFJSONRequestSerializer();
        return tools
    }()
    
    func request(method: HTTPMethod,urlString: String,parameters: Any?,finished: @escaping (Any?,Error?) -> ()) {
        //成功的回调参数
        let successCallBack = { (task: URLSessionDataTask,responseObject: Any?) -> () in
            //这里需要使用到参数
            finished(responseObject, nil)
        }
        
        //失败的回调参数
        let failureCallBack = { (task: URLSessionDataTask?, error: Error) -> () in
            //输出错误信息
            print(error)
            finished(nil, error)
        }
        
        if method == .GET {
            self.get(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }else{
            
            self.post(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
        
    }
}
