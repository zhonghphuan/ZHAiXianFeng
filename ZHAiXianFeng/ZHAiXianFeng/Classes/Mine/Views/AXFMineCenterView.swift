//
//  AXFMineCenterView.swift
//  SpuerYangAngWang
//
//  Created by 王嘉涛 on 2016/12/26.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit

class AXFMineCenterView: UIView {

    var closeOrderBag : (()->())?
    
    var closeCouponBag : (()->())?
    
    var closeMessageBag : (()->())?

    
    @IBOutlet weak var orderBtn: UIButton!
    
    @IBOutlet weak var couponBtn: UIButton!
    
    @IBOutlet weak var messageBtn: UIButton!
    
    @IBOutlet weak var lineOne: UIView!
    
    @IBOutlet weak var lineTwo: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.orderBtn.addTarget(self, action: #selector(clickOrderBtn), for: .touchUpInside)
        self.couponBtn.addTarget(self, action: #selector(clickCouponBtn), for: .touchUpInside)
        self.messageBtn.addTarget(self, action: #selector(clickMessageBtn), for: .touchUpInside)

    }
    class func CenterView()->(AXFMineCenterView){
    return Bundle.main.loadNibNamed("AXFMineCenterView", owner: self, options: nil)?.first as!AXFMineCenterView
    }
    
    func clickOrderBtn() {
        closeOrderBag?()
    }
    
    func clickCouponBtn() {
        closeCouponBag?()
    }

    func clickMessageBtn() {
        closeMessageBag?()
    }

}
