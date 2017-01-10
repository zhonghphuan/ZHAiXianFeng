//
//  ZHShoppingCar.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/26.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHShoppingCar: NSObject {
    
    //进入购物车的产品
    lazy var shopCarModelArray = [ZHSellFastModel]()
    var count: Int = 0
    //总商品
    lazy var goodsModelArray = [ZHSellFastModel]()
    
    static let shared: ZHShoppingCar = {
        let car = ZHShoppingCar()
        return car
    }()

    
}
