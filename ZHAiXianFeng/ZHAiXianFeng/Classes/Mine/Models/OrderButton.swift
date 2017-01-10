//
//  OrderButton.swift
//  SpuerYangAngWang
//
//  Created by 杨茂盛 on 2016/12/27.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit
import YYModel
class OrderButton: NSObject,YYModel{
    var type: Int = -1
    var text: String?
    func modelContainerPropertyGenericClass() -> [String : Any]? {
        return ["OrderButton" : OrderButton.self]
    }
    init(dict:[String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}


