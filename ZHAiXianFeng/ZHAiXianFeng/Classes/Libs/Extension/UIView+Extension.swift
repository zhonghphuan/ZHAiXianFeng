//
//  UIView+Extension.swift
//  MySinaWeiBo
//
//  Created by ZH on 2016/11/14.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK:- 动画
    func shakeToShowView() {
        let animation:CAKeyframeAnimation = CAKeyframeAnimation.init(keyPath: "transform")
        animation.duration = 0.5
        var values = [Any]()
        
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(0.5, 0.1, 1.0)))
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(1.2, 1.2, 1.0)))
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(0.6, 0.6, 1.0)))
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(1.1, 1.1, 1.0)))
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)))
        values.append(NSValue(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
        
        animation.values = values
        self.layer.add(animation, forKey: nil)
        
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        //实现get 和 set 操作layer的圆角
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    //视图层次嵌套比较深的时候 使用代理或者闭包的时候会比较麻烦 可以使用这种方式来解决
    //遍历响应者链条 查找对应的控制器(导航, tabbarVC,tableVC)
    func findNavVC() -> (UINavigationController?) {
        
        var responder = self.next
        
        while responder != nil {
            
            if let obj = responder as? UINavigationController {
                
                return obj
            }
            
            responder = responder?.next
        }
        
        return nil
    }
}


// MARK:- 按钮分类
extension UIButton {
    convenience init(imageName: String = "" ,title: String = "",textColor: UIColor, fontSize: CGFloat) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setImage(UIImage(named:imageName), for: .normal)
    }
    
    func setImagePosition(spacing:CGFloat) {
        
        guard let imageWith = self.imageView?.image?.size.width else { return  }
        guard let imageHeight = self.imageView?.image?.size.height else { return  }
        guard let labelWidth = self.titleLabel?.attributedText?.size().width else { return  }
        guard let labelHeight = self.titleLabel?.attributedText?.size().height else { return  }

        //image中心移动的x距离
        let imageOffsetX = labelWidth / 2
        //image中心移动的y距离
        let imageOffsetY = labelHeight / 2 + spacing / 2
        //label中心移动的x距离
        let labelOffsetX = imageWith/2
        //label中心移动的y距离
        let labelOffsetY = imageHeight / 2 + spacing / 2
        
        self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
        self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
        
   
    }
   
}

// MARK:- label分类
extension UILabel {
    convenience init(title: String, textColor: UIColor, fontSize: CGFloat) {
        self.init()
        self.text = title
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textAlignment = .center
        sizeToFit()
    }
}



