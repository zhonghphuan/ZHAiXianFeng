//
//  ZHHomeViewModel.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/22.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit
import SVProgressHUD


class ZHHomeViewModel: NSObject {
    
    
    lazy var arrayFocus = [ZHFocusModel]()
    lazy var arrayActivities = [ZHActivitiesModel]()
    lazy var arrayicons = [ZHIconsModel]()
    
    lazy var arraySellFast = [ZHSellFastModel]()
    
    
    
    //这里需要做下数据库缓存
    func loadCarouselDate( finished:@escaping ((Bool) -> ())) {
        
        let parameters = ["call":1]
        NetworkingTools.shared.request(method: .POST, urlString: urlFocus, parameters: parameters) { (responseObject, error) in
            
            if error != nil {
                 SVProgressHUD.showError(withStatus: errorTip)
                finished(false)
                return
            }
            
            guard let dict = responseObject as? [String : Any] else {finished(false);return}
            guard let dictData = dict["data"] as? [String : Any] else {finished(false);return}
            guard let arrayFocus = dictData["focus"] as? [[String : Any]]else {finished(false);return}
            guard let arrayActivities = dictData["activities"] as? [[String : Any]] else {finished(false);return}
            guard let arrayicons = dictData["icons"] as? [[String : Any]] else {finished(false);return}


            //轮播器转模型数据
            for item1 in arrayFocus{
                let arrayFocusModel = ZHFocusModel(dict: item1)
                self.arrayFocus.append(arrayFocusModel)
            }
            //新年惠转模型数据
            for item2 in arrayActivities{
                let arrayActivitiesModel = ZHActivitiesModel(dict: item2)
                self.arrayActivities.append(arrayActivitiesModel)
            }
            //分类图标转模型数据
            for item3 in arrayicons{
                let arrayiconsModel = ZHIconsModel(dict: item3)
                self.arrayicons.append(arrayiconsModel)
            }
            SVProgressHUD.dismiss()
            //回调的网络 请求的轮播器数据结果
            finished(true)
        }
    }
    
    func loadSellFastDate(finished:@escaping ((Bool) -> ())) {
        
       
        let parameters = ["call":2]
        NetworkingTools.shared.request(method: .POST, urlString: urlFirstSell, parameters: parameters) { (responseObject, error) in
            
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
                self.arraySellFast.append(arraySellFastModel)
            }
            
            SVProgressHUD.dismiss()
            //回调的网络 请求的轮播器数据结果
            finished(true)
        }
    }
    

}
