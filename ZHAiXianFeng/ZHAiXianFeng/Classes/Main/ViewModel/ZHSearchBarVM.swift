//
//  ZHSearchBarVM.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/29.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit
import SVProgressHUD

class ZHSearchBarVM: NSObject {

    

    var arraySearch = NSArray()
    lazy var arraySearchRes = [ZHSellFastModel]()
    
    func loadSearchDate(finished:@escaping ((Bool) -> ())) {
        let parameters = ["call":6]
        NetworkingTools.shared.request(method: .POST, urlString: urlSearch, parameters: parameters) { (responseObject, error) in
            
            if error != nil {
                SVProgressHUD.showError(withStatus: errorTip)
                finished(false)
                return
            }
            guard let dict = responseObject as? [String : Any] else {finished(false);return}
            guard let arrayData = dict["data"] as? [String : Any] else {finished(false);return}
      
            self.arraySearch = arrayData["hotquery"] as! NSArray
            SVProgressHUD.dismiss()
            //回调的网络 请求的轮播器数据结果
            finished(true)
        }
    }
    
    func loadSearchResDate(finished:@escaping ((Bool) -> ())) {
        let parameters = ["call":8]
        NetworkingTools.shared.request(method: .POST, urlString: urlSearchRes, parameters: parameters) { (responseObject, error) in
            
            if error != nil {
                SVProgressHUD.showError(withStatus: errorTip)
                finished(false)
                return
            }
            guard let dict = responseObject as? [String : Any] else {finished(false);return}
            guard let arrayData = dict["data"] as? [[String : Any]] else {finished(false);return}
            
            //轮播器转模型数据
            for item in arrayData{
                let arraySellFastModel = ZHSellFastModel(dict: item)
                self.arraySearchRes.append(arraySellFastModel)
            }
            
            SVProgressHUD.dismiss()
            //回调的网络 请求的轮播器数据结果
            finished(true)
        }
    }
}
