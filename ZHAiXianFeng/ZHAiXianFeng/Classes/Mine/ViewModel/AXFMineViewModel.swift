//
//  AXFMineViewModel.swift
//  SpuerYangAngWang
//
//  Created by 杨茂盛 on 2016/12/27.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit

class AXFMineViewModel: NSObject {
    
    lazy var MineOrderModelArray = [AXFMineOrderModel]()
    
    var orderStatusArray = [OrderStatus]()
    
    //加载数据
    func loadData(finished:@escaping (Bool) ->()){
        let urlString = "http://iosapi.itcast.cn/loveBeen/MyOrders.json.php"
        let parameters = ["call":"13"]
        NetworkingTools.shared.request(method: .POST, urlString: urlString, parameters: parameters){  (responed, error) in
            
            if error != nil{
                finished(false)
            }
            
            let dict = responed as! [String : Any]
            let array = dict["data"] as! [[String : Any]]
            for item1 in array {
                let model = AXFMineOrderModel(dict: item1)
                let array_goods = item1["order_goods"] as! [[[String : Any]]]
                let array_status = item1["status_timeline"] as! [[String:Any]]
                //解析 order_goods
                for (index,arrayitem2) in array_goods.enumerated() {
                    var tmp = [OrderGoods]()
                    for item3 in arrayitem2 {
                        let model_goods = OrderGoods(dict: item3)
                         tmp.append(model_goods)
                    }
                     model.order_goods?[index] = tmp
                }
                //解析 statuses
                var temp = [OrderStatus]()
                for item4 in array_status{
                let model_status = OrderStatus(dict: item4)
                temp.append(model_status)
                }
              model.status_timeline = temp
                self.orderStatusArray = temp
              self.MineOrderModelArray.append(model)
            }
            finished(true)
        }
    }
}
