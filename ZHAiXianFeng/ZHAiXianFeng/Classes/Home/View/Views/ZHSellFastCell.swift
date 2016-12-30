//
//  ZHSellFastCell.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/23.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHSellFastCell: UICollectionViewCell {

    //图片
    @IBOutlet weak var imgView: UIImageView!
    //热卖产品名称
    @IBOutlet weak var name: UILabel!
    //450g/盒
    @IBOutlet weak var specificsLabel: UILabel!
    //优惠后价格
    @IBOutlet weak var partner_priceLabel: UILabel!
    //优惠前价格
    @IBOutlet weak var market_priceLabel: UILabel!
    
    @IBOutlet weak var pm_descLabel: UIImageView!
    
    //懒加载添加删除的小视图
    lazy var smallView:ZHSmallView = {
        let smallView = ZHSmallView()
        return smallView
    }()
    
    
    //重写set方法获取模型数据并赋值
     var sellFastCellModel:ZHSellFastModel? {
        
        didSet{
    
            guard let url = URL(string: (sellFastCellModel?.img)!) else {return}
            imgView.sd_setImage(with: url, placeholderImage: UIImage(named: "v2_placeholder_square"))
            name.text = sellFastCellModel?.name
            specificsLabel.text = sellFastCellModel?.specifics
            partner_priceLabel.text = "$" + (sellFastCellModel?.partner_price?.cleanDecimalPointZear())!
            market_priceLabel.text = "$" + (sellFastCellModel?.market_price?.cleanDecimalPointZear())!
            pm_descLabel.isHidden = (sellFastCellModel?.pm_desc == "")
  
            //判断是否补货中
            guard let numStr = sellFastCellModel?.number?.description else { return }
            let isTrue = sellFastCellModel?.number == 0 || numStr == "0"
            smallView.isHidden = isTrue
            labelTip.isHidden = !isTrue
            
            //中划线
            let attribs = [NSStrikethroughStyleAttributeName : NSNumber.init(integerLiteral: NSUnderlineStyle.styleSingle.rawValue)]
            guard let str = market_priceLabel.text else {return}
            let attrString =  NSAttributedString(string: str, attributes: attribs)
            market_priceLabel.attributedText = attrString

            //给加减小空间赋值
            guard let number = sellFastCellModel?.number else { return }
            smallView.number = number
            smallView.name = sellFastCellModel?.name
   
            //解决cell重用问题
            smallView.count = sellFastCellModel?.count ?? 0
  
        }
    }
    
    lazy var labelTip:UILabel = {
       
        let labelTip = UILabel(title: "补货中", textColor: UIColor.red, fontSize: 12)
        return labelTip
    }()
    
    /***********************************华丽的分割线**************************************/
    
    override func awakeFromNib() {
        
        self.contentView.backgroundColor = UIColor.white
        addSubview(labelTip)
        addSubview(smallView)
        
        labelTip.snp.makeConstraints({ (make) in
            make.bottom.equalTo(self).offset(-13)
            make.trailing.equalTo(self).offset(-5)
        })
        smallView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-13)
            make.trailing.equalTo(self).offset(-5)
            make.width.equalTo(75)
            make.height.equalTo(22)
        }
        
        smallView.addTarget(self, action: #selector(didClickSmallControl(smallView:)), for: .valueChanged)
    
    }
 
    //监听到count的值变化,并给该模型赋值
    @objc private func didClickSmallControl(smallView:ZHSmallView) {
        sellFastCellModel?.count = smallView.count
        if smallView.isIncrementClicked == true {
            let imgCenter = imgView.center
            let keywindow = UIApplication.shared.keyWindow
            let convertPoint = imgView.convert(imgCenter, to: keywindow)
            NotificationCenter.default.post(name: NSNotification.Name(kSellFastIncreaseActionNotification), object: sellFastCellModel, userInfo: nil)
            
            NotificationCenter.default.post(name: NSNotification.Name(kAnimationNotification), object: sellFastCellModel, userInfo: ["convertPoint":convertPoint,"img":imgView])
            
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(kSellFastReduceActionNotification), object: sellFastCellModel, userInfo: nil)
            
        }
    }
    
    //移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
