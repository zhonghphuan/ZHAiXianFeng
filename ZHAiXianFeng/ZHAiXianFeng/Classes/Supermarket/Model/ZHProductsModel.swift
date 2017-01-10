//
//  ZHProductsModel.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/25.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHProductsModel: NSObject {

    var id: String?
    var name: String?
    var store_nums: String?
    var sort: String?
    var brand_id: String?
    var hot_degree: String?
    var safe_day: String?
    var market_price: String?
    var cid: String?
    var category_id: String?
    var pcid: String?
    var brand_name: String?
    var ismix: String?
    var pre_img: String?
    var pre_imgs: String?
    var cart_group_id: String?
    var source_id: String?
    var tag_ids: String?
    var attribute: String?
    var specifics: String?
    var product_id: String?
    var dealer_id: String?
    var price: String?
    var number: NSNumber?
    var had_pm: NSNumber?
    var pm_desc: String?
    var is_xf: NSNumber?
    var img: String?

    var count: Int?
    
    
    init(dict:[String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
