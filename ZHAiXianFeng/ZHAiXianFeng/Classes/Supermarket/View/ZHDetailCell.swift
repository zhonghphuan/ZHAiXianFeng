//
//  ZHDetailCell.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/27.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHDetailCell: UITableViewCell {

    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var partner_priceLabel: UILabel!
    
    @IBOutlet weak var market_priceLabel: UILabel!

    @IBOutlet weak var specificsLabel: UILabel!

    @IBOutlet weak var cuXiao: UIView!
    
    @IBOutlet weak var brand_nameLabel: UILabel!
    @IBOutlet weak var cuXiaoHeight: NSLayoutConstraint!
    
    
    var detailModel:ZHSellFastModel? {
        
        didSet {
            
            for item in ZHShoppingCar.shared.shopCarModelArray {
                if item.product_id == detailModel?.product_id {
                   
                }
            }
            
            
            nameLabel.text = detailModel?.name
            specificsLabel.text = detailModel?.specifics
            partner_priceLabel.text = "$" + (detailModel?.partner_price?.cleanDecimalPointZear())!
            market_priceLabel.text = "$" + (detailModel?.market_price?.cleanDecimalPointZear())!
            guard let numStr = detailModel?.had_pm?.description else { return }
            let isTrue = detailModel?.had_pm == 0 || numStr == "0"
            cuXiao.isHidden = isTrue
            brand_nameLabel.text = detailModel?.brand_name
            if isTrue == true {
                 cuXiaoHeight.constant = 114 - 49
            }
            //中划线
            let attribs = [NSStrikethroughStyleAttributeName : NSNumber.init(integerLiteral: NSUnderlineStyle.styleSingle.rawValue)]
            guard let str = market_priceLabel.text else {return}
            let attrString =  NSAttributedString(string: str, attributes: attribs)
            market_priceLabel.attributedText = attrString
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    
}
