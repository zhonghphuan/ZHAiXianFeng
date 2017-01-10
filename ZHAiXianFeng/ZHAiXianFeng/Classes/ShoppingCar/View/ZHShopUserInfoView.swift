//
//  ZHShopUserInfoView.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/28.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHShopUserInfoView: UIView {

    class func userInfoView() ->ZHShopUserInfoView{
        return Bundle.main.loadNibNamed("ZHShopUserInfoView", owner: self, options: nil)?.first as! ZHShopUserInfoView
    }
}
