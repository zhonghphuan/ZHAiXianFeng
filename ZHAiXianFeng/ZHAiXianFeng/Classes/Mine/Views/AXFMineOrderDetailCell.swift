//
//  AXFMineOrderDetailCell.swift
//  SpuerYangAngWang
//
//  Created by 杨茂盛 on 2016/12/28.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit

class AXFMineOrderDetailCell: UITableViewCell {
    
    var model:OrderStatus?{
        didSet{

                self.timeLabel.text = model?.status_time
            
            if (model?.status_title?.contains("订单提交成功"))! {
                lineView.isHidden = true
                contentLabel.numberOfLines = 2
                let str = model?.status_desc?.components(separatedBy: ":")
                contentLabel.text = (str?.first)! + "\\n" + (str?.last)!
                
            }
            
            if (model?.status_title?.contains("已完成"))! {
                topLine.isHidden = true
                iconImageView.image = UIImage(named: "order_yellowMark")
            }else{
                 iconImageView.image = UIImage(named: "order_grayMark")
            }
                self.contentLabel.text = model?.status_desc
       
                self.statusLabel.text = model?.status_title
        }
    }
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }    
}
