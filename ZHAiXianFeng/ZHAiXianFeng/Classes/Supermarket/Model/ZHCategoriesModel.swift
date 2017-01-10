//
//  ZHCategoriesModel.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/25.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHCategoriesModel: NSObject {

    var id: String?
    var name: String?
    var icon: String?
    var sort: String?
    var visibility: String?
    var pcid: String?
    var disabled_show: NSNumber?
    var productArray: [ZHSellFastModel]?
    
    init(dict:[String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
