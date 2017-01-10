//
//  AXFMineOrderCostCell.swift
//  SpuerYangAngWang
//
//  Created by 杨茂盛 on 2016/12/29.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit

class AXFMineOrderCostCell: UITableViewCell {

    var model:OrderGoods?{
        didSet{

                self.nameLabel.text = model?.name
                self.countLabel.text = "X\(model!.goods_nums!)"
                self.priceLabel.text = model?.goods_price

        }
    }
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
