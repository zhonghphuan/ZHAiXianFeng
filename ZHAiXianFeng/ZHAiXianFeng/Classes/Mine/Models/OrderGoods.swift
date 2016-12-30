//
//  OrderGoods.swift
//  SpuerYangAngWang
//
//  Created by 杨茂盛 on 2016/12/27.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit
import YYModel
class OrderGoods: NSObject,YYModel {
    var goods_id: String?
    var goods_price: String?
    var real_price: String?
    var isgift: Int = -1
    var name: String?
    var specifics: String?
    var brand_name: String?
    var img: String?
    var is_gift: Int = -1
    var goods_nums: String?
  
    
    
    @nonobjc func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["OrderGoods" : OrderGoods.self]
    }
    init(dict:[String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
