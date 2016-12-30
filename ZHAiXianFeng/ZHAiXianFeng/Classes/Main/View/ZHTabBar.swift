//
//  ZHTabBar.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/22.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHTabBar: UITabBar {

    //定义闭包传递点击按钮消息
    var shoppingCarClosure: (() -> ())?
    //懒加载中间按钮
    
    lazy var shoppingCarBtn : UIButton = {
        
      
        
        let btn = UIButton()
        //设置图片
        let image = UIImage.createNewImage(withColor: UIImage(named: "shopCart"), multiple: 0.88)
        let imageSelect = UIImage.createNewImage(withColor: UIImage(named: "shopCart_r"), multiple: 0.88)
        btn.setImage(image, for: .normal)
        btn.setImage(imageSelect, for: .selected)
        btn.setTitle("购物车", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btn.setTitleColor(UIColor.orange, for: .selected)
        btn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        btn.setImagePosition(spacing: 2)
        btn.sizeToFit()
        return btn
    }()
    
     lazy var redView : ZHRedHotView = {
        let redView = ZHRedHotView.redHotView()
        redView.subviews[1].isHidden = true
        return redView
    }()
    //重写init方法添加中间按钮

    override init(frame: CGRect) {
        
        super.init(frame: frame)
     
    
//        self.addSubview(self.shoppingCarBtn)
        self.addSubview(redView)
//        //监听按钮点击事件
//        self.shoppingCarBtn.addTarget(self, action: #selector(shoppingCarClick), for: .touchUpInside)
//        
        //通知->监听购物车数据增加
        NotificationCenter.default.addObserver(self, selector: #selector(increase(noti:)), name: NSNotification.Name(rawValue: kSellFastIncreaseActionNotification), object: nil)
        //通知->监听购物车数据减少
        NotificationCenter.default.addObserver(self, selector: #selector(reduce(noti:)), name: NSNotification.Name(rawValue: kSellFastReduceActionNotification), object: nil)
        
 
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(tap:)))
        redView.addGestureRecognizer(tap)
    
    }
    
    @objc private func tap(tap:UITapGestureRecognizer){
        
        if shoppingCarClosure != nil {
            shoppingCarClosure!()
        }
    }
    
    @objc private func increase(noti:Notification) {
       
        ZHShoppingCar.shared.count += 1
        redViewAnimation(time: 0.8)
    }
    
    @objc private func reduce(noti:Notification) {
        ZHShoppingCar.shared.count -= 1
        redViewAnimation(time: 0)
    }
    
    
    private func redViewAnimation(time:TimeInterval) {
        
        let strLabel =  redView.subviews[1].subviews[0] as! UILabel
        strLabel.text = "\(ZHShoppingCar.shared.count)"
        redView.subviews[1].isHidden = (ZHShoppingCar.shared.count == 0)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            self.redView.subviews[1].transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.redView.subviews[1].transform = CGAffineTransform.identity
            }, completion: nil)
        }

    }
    
    

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
  
        self.addSubview(redView)
    }

    
    @objc private func shoppingCarClick(btn: UIButton){
        btn.shakeToShowView()
        shoppingCarClosure?()
    }

    //给tabBar添加子视图,重新布局内部视图位置,需要重写layoutSubviews
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        //遍历子视图,添加中间的Button
        let width = UIScreen.main.bounds.width / 4
        let height = self.bounds.height
        
        var index = 0
        for sub in subviews{

            //判断如果是UITabBarButton类型才继续
            if sub.isKind(of: NSClassFromString("UITabBarButton")!) {
                sub.frame = CGRect(x: CGFloat(index) * width, y: 0, width: width, height: height)
                index += (index == 1 ? 2 : 1)
            }
        }
        redView.center = CGPoint(x: self.center.x + width * 0.5, y: height * 0.5)
        redView.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 4, height: self.bounds.height)
    }

}
