//
//  HJMyDiscountModel.swift
//  AiXianFeng
//
//  Created by zhouxuanhe on 2016/12/27.
//  Copyright © 2016年 zhouxuanhe. All rights reserved.
//

import UIKit

class HJMyDiscountModel: NSObject {

    var start_time: String?  //2015-12-03
    var end_time: String?  //2018-12-09
    var value: String? //5.00元
    var name: String? //[转盘抽奖]鲜蜂精选券
    var desc: String? // 限购买“精选”标签类商品，商品满39元可用，每笔订单只能使用一张优惠券，限在线支付
    
    
    
    /**
     /**
     重写 setValue:(id)value forUndefinedKey:(NSString *)key 防止崩溃
     */
     - (void)setValue:(id)value forUndefinedKey:(NSString *)key {
     
     if ([key isEqualToString:@"description"]) {
     
     self.desc = value;
     }
     }
     */
    init(dict:[String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    

    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "description" {
            self.desc = value as! String?
        }
    }
}
