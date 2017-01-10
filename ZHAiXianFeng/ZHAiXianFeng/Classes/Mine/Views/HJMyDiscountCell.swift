//
//  HJMyDiscountCell.swift
//  AiXianFeng
//
//  Created by zhouxuanhe on 2016/12/27.
//  Copyright © 2016年 zhouxuanhe. All rights reserved.
//

import UIKit

class HJMyDiscountCell: UITableViewCell {

    @IBOutlet weak var usedImgView: UIImageView!
    @IBOutlet weak var usedLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    
    var myDiscountModel : HJMyDiscountModel? {
        didSet {
            valueLabel.text = "$" + (myDiscountModel?.value!)!
            nameLabel.text = myDiscountModel?.name
            startTimeLabel.text = myDiscountModel?.start_time
            endTimeLabel.text = myDiscountModel?.end_time
            descLabel.text = myDiscountModel?.desc
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
