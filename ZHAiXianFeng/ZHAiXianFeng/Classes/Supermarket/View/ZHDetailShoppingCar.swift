//
//  ZHDetailShoppingCar.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/28.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHDetailShoppingCar: UIView {
    
 
    @IBOutlet weak var cyView: UIView!
    @IBOutlet weak var numlbl: UILabel!
    
    var detailModel:ZHSellFastModel? {
        
        didSet{
            guard let number = self.detailModel?.number else { return }
            smallView.number = number
            smallView.name = detailModel?.name
            smallView.count = detailModel?.count ?? 0
            smallView.reduceBtn.isHidden = false
            smallView.numLabel.isHidden = false
            cyView.isHidden = (detailModel?.count == 0 || ZHShoppingCar.shared.shopCarModelArray.count == 0)

            numlbl.text = "\(detailModel!.count!)"
        }
    }
    //懒加载添加删除的小视图
    lazy var smallView:ZHSmallView = {
        let smallView = ZHSmallView()
        return smallView
    }()
    
    override func awakeFromNib() {
 
 
        addSubview(smallView)
        smallView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self).offset(-6)
            make.left.equalTo(self).offset(80)
            make.width.equalTo(75)
            make.height.equalTo(22)
        }
        smallView.addTarget(self, action: #selector(didClickSmallControl(smallView:)), for: .valueChanged)
        
    }
    
    //监听到count的值变化,并给该模型赋值
    @objc private func didClickSmallControl(smallView:ZHSmallView) {
        let count  = smallView.count
        detailModel?.count = count
        cyView.isHidden = (ZHShoppingCar.shared.count == 0)
        numlbl.text = "\(detailModel!.count!)"
        if smallView.isIncrementClicked == true {
            if count == 0 {
                 numlbl.text = "1"
            }
            NotificationCenter.default.post(name: NSNotification.Name(kSellFastIncreaseActionNotification), object: detailModel, userInfo:nil)
            redViewAnimation(time: 0)
        }else{
            
            if count == 0 {
                smallView.reduceBtn.isHidden = false
                smallView.numLabel.isHidden = false
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(kSellFastReduceActionNotification), object: detailModel, userInfo: nil)
             redViewAnimation(time: 0)
        }
    }
    
    private func redViewAnimation(time:TimeInterval) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            self.cyView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
               self.cyView.transform = CGAffineTransform.identity
            }, completion: nil)
        }
        
    }
    
    //移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    
    class func detailShoppingCar() -> ZHDetailShoppingCar {
        return Bundle.main.loadNibNamed("ZHDetailShoppingCar", owner: nil, options: nil)?.last as! ZHDetailShoppingCar
    }
}
