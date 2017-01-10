//
//  HJMineViewModel.swift
//  AiXianFeng
//
//  Created by zhouxuanhe on 2016/12/27.
//  Copyright © 2016年 zhouxuanhe. All rights reserved.
//

import UIKit
import SVProgressHUD
import YYModel

class HJMineViewModel: NSObject {

    var arrDiscount = [HJMyDiscountModel]()
    
    
    
    func loadData(finished:@escaping ([HJMyDiscountModel]) -> ()) {
        let urlString : NSString = "http://iosapi.itcast.cn/loveBeen/MyCoupon.json.php"
        let parameter = ["call":"9"]
        NetworkingTools.shared.request(method: .POST, urlString: urlString as String, parameters: parameter) { (responsObject, error) in
            
            if ( error != nil  || responsObject == nil){
                SVProgressHUD.showInfo(withStatus: "数据出错了")
            }
            
            
            let dict1   =  responsObject as! [String : Any]  
            guard let dictData = dict1["data"] as? [[String : Any]] else {return}
          
            
            for item in dictData {
                let model = HJMyDiscountModel(dict: item)
                //let model = HJIconsModel(dict:item3)
                 self.arrDiscount.append(model)
            }
            
            finished(self.arrDiscount)
            
        }
    }
    
     
    
}
