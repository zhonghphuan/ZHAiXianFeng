//
//  Common.swift
//  MySinaWeiBo
//
//  Created by ZH on 2016/11/15.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

let accountPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("account.plist")

//网络请求接口
let urlFocus =          "http://iosapi.itcast.cn/loveBeen/focus.json.php"
let urlFirstSell =      "http://iosapi.itcast.cn/loveBeen/firstSell.json.php"
let urlSupermarket =    "http://iosapi.itcast.cn/loveBeen/supermarket.json.php"

//搜索
let urlSearch =         "http://iosapi.itcast.cn/loveBeen/search.json.php"
let urlSearchRes =      "http://iosapi.itcast.cn/loveBeen/promotion.json.php"



//第三方登录授权配置信息

let client_id = "1750957467"
let client_secret = "b02a4fd54858841c536f328c83680081"
let redirect_uri = "http://www.itheima.com"

//定义切换根视图控制器的通知名称
let kChoseRootViewController = "kChoseRootViewController"

//通知
//弹框提示
let kAlertNotification = "alertNotification"
//模型增加
let kSellFastIncreaseActionNotification = "sellFastIncreaseActionNotification"
//模型减少
let kSellFastReduceActionNotification = "sellFastReduceActionNotification"
//购物车数据变化
let kShoppingCarChangedNotification = "shoppingCarChangedActionNotification"

let kAnimationNotification = "AnimationActionNotification"
//预留
let kProductActionNotification = "productActionNotification"
let kSellFastActionNotification = "sellFastActionNotification"
let kSmallViewActionNotification = "smallViewActionNotification"


//网络状态
let errorTip = "世界上最遥远的距离就是没有网络"

//随机颜色
func randomColor() -> UIColor {
    let r = CGFloat(arc4random() % 256) / 255.0
    let g = CGFloat(arc4random() % 256) / 255.0
    let b = CGFloat(arc4random() % 256) / 255.0
    return UIColor(red: r, green:g, blue: b, alpha: 1)
}

//屏幕的尺寸信息
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
let navBarHeight: CGFloat = 64


//Home 属性
let HotViewMargin: CGFloat = 8
let HomeCollectionViewCellMargin: CGFloat = 8
let CollectionHeaderViewHeigth:CGFloat = 20
let CollectionFooterViewHeigth:CGFloat = 60
let cycleScrollViewHeigth:CGFloat = 160.0
let iconViewHeigth:CGFloat = 90.0

//定义全局的格式化对象
let sharedDateFormater = DateFormatter()

let atSomeRegex = try! NSRegularExpression(pattern: "@\\w+", options: [])
let topicRegex = try! NSRegularExpression(pattern: "#.*?#", options: [])
let urlRegex = try! NSRegularExpression(pattern: "(http|ftp|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?", options: [])
let emoticonRegex = try! NSRegularExpression(pattern: "\\[.*?\\]", options: [])
