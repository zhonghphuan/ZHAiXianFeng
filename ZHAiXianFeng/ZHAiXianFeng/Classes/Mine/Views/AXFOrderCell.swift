//
//  AXFOrderCell.swift
//  SpuerYangAngWang
//
//  Created by 杨茂盛 on 2016/12/27.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit

class AXFOrderCell: UITableViewCell {
    
    var model:AXFMineOrderModel?{
        didSet{
            
            for (index,_) in (model?.order_goods?.enumerated())! {
                if index > 3 {
                    self.goodsImageMore.isHidden = false
                    return
                }
                guard let urlString1 = model?.order_goods?[index][0].img else {return}
                let url1 = URL.init(string: urlString1)
                myGoodsImageViews[index].sd_setImage(with: url1)
     
            }
            orderCreatTimeLabel.text = model?.create_time
            oederGoodsCountLabel.text = "共\(model!.buy_num)件商品"
            orderRealPayLabel.text = "实付$\(model!.real_amount!)元"
         
        }
    }
    
    //订单产生的时间
    @IBOutlet weak var orderCreatTimeLabel: UILabel!
    
    //商品的数量
    @IBOutlet weak var oederGoodsCountLabel: UILabel!
    
    //实付的价钱
    @IBOutlet weak var orderRealPayLabel: UILabel!
    //图片
    
    @IBOutlet weak var goodsImageMore: UIImageView!
    
    @IBOutlet var myGoodsImageViews: [UIImageView]!

    @IBOutlet weak var myGoodsImageView4: UIImageView!
    @IBOutlet weak var myGoodsImageView3: UIImageView!
    @IBOutlet weak var myGoodsImageView2: UIImageView!
    @IBOutlet weak var myGoodsImageView1: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
