//
//  ZHProductsCell.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/25.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHProductsCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var specificslabel: UILabel!
    @IBOutlet weak var pricelabel: UILabel!
    @IBOutlet weak var market_pricelabel: UILabel!
    @IBOutlet weak var jxImgView: UIImageView!
    @IBOutlet weak var buyOneImgVIew: UIImageView!
    //是否热卖
    @IBOutlet weak var had_pmImgView: UIImageView!
 
    //懒加载添加删除的小视图
    lazy var smallView:ZHSmallView = {
        let smallView = ZHSmallView()
        return smallView
    }()
    
    lazy var labelTip:UILabel = {
        
        let labelTip = UILabel(title: "补货中", textColor: UIColor.red, fontSize: 12)
        return labelTip
    }()
    
    var productsModel:ZHSellFastModel? {
        
        didSet{
    
            let url = URL(string: (productsModel?.img)!)
            imgView.sd_setImage(with: url, placeholderImage: UIImage(named: "icon_icons_holder"))
            nameLabel.text = productsModel?.name
            specificslabel.text = productsModel?.specifics
            pricelabel.text = "$" + (productsModel?.partner_price?.cleanDecimalPointZear())!
            market_pricelabel.text = "$" + (productsModel?.market_price?.cleanDecimalPointZear())!
         
            //是否热卖
            had_pmImgView.isHidden = (productsModel?.had_pm == 0)
            //判断是否补货中
            guard let numStr = productsModel?.number?.description else { return }
            let isTrue = productsModel?.number == 0 || numStr == "0"
            smallView.isHidden = isTrue
            labelTip.isHidden = !isTrue
            
            //中划线
            let attribs = [NSStrikethroughStyleAttributeName : NSNumber.init(integerLiteral: NSUnderlineStyle.styleSingle.rawValue)]
            guard let str = market_pricelabel.text else {return}
            let attrString =  NSAttributedString(string: str, attributes: attribs)
            market_pricelabel.attributedText = attrString
            
            //给加减小空间赋值
            guard let number = productsModel?.number else { return }
            smallView.number = number
            smallView.name = productsModel?.name
            //解决cell重用问题
            smallView.count = productsModel?.count ?? 0
        
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(smallView)
        addSubview(labelTip)
        self.selectionStyle = .none
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
        let count  = smallView.count
        productsModel?.count = count
        if smallView.isIncrementClicked == true {
    
            let imgCenter = imgView.center
            let keywindow = UIApplication.shared.keyWindow
            let convertPoint = imgView.convert(imgCenter, to: keywindow)
            NotificationCenter.default.post(name: NSNotification.Name(kSellFastIncreaseActionNotification), object: productsModel, userInfo: nil)
            NotificationCenter.default.post(name: NSNotification.Name(kAnimationNotification), object: productsModel, userInfo: ["convertPoint":convertPoint,"img":imgView])
        }else{
            NotificationCenter.default.post(name: NSNotification.Name(kSellFastReduceActionNotification), object: productsModel, userInfo: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
