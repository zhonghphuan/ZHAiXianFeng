//
//  ZHSellFastModel.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/23.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHSellFastModel: NSObject {


    //热卖产品名称
    var name: String?
    //买一赠送
    var pm_desc: String?
    //450g/盒
    var specifics: String?
    //优惠后价格
    var partner_price: String?
    //优惠前价格
    var market_price: String?
    //图片
    var img: String?
    //库存
    var number: NSNumber?
    var had_pm: NSNumber?
    var brand_name: String?
    var product_id:NSNumber?

    //多少个
    var count: Int?
    
    init(dict:[String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
