//
//  ZHShoppingCarCellIDCell.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/27.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHShoppingCarCellIDCell: UITableViewCell {

    var closue: (() -> ())?
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var shoppingCarModel:ZHSellFastModel? {
    
        didSet{
            productNameLabel.text = "[精选]" + (shoppingCarModel?.name)!
            priceLabel.text = "$" + (shoppingCarModel?.partner_price?.cleanDecimalPointZear())!
            //给加减小空间赋值
            guard let number = shoppingCarModel?.number else { return }
            smallView.number = number
            smallView.name = shoppingCarModel?.name
            smallView.count = shoppingCarModel?.count ?? 1
        }
    }
    
    //懒加载添加删除的小视图
    lazy var smallView:ZHSmallView = {
        let smallView = ZHSmallView()
        return smallView
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addSubview(smallView)
        smallView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.trailing.equalTo(self).offset(-5)
            make.width.equalTo(75)
            make.height.equalTo(22)
        }
        
        smallView.addTarget(self, action: #selector(didClickSmallControl(smallView:)), for: .valueChanged)
    }

    //监听到count的值变化,并给该模型赋值
    @objc private func didClickSmallControl(smallView:ZHSmallView) {
        let count  = smallView.count
        shoppingCarModel?.count = count
        //增加
        if smallView.isIncrementClicked == true {
            //将模型数据添加到购物车中,如果不包含该模型,则加入购物车
            if ZHShoppingCar.shared.shopCarModelArray.contains(shoppingCarModel!) == false  {
                ZHShoppingCar.shared.shopCarModelArray.append(shoppingCarModel!)
            }
             NotificationCenter.default.post(name: NSNotification.Name(kSellFastIncreaseActionNotification), object: shoppingCarModel, userInfo: nil)

        }else{
        //减少
            if count == 0 && ZHShoppingCar.shared.shopCarModelArray.contains(shoppingCarModel!) == true{
                let index = ZHShoppingCar.shared.shopCarModelArray.index(of: shoppingCarModel!)
                ZHShoppingCar.shared.shopCarModelArray.remove(at: index!)
            }
            if count == 0 {
                if  closue != nil{
                    closue!()
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name(kSellFastReduceActionNotification), object: shoppingCarModel, userInfo: nil)
        }
    }

}
