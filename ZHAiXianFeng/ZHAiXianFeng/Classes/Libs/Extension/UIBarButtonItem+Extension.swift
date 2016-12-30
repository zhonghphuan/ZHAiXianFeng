//
//  UIBarButtonItem+Extension.swift
//  MySinaWeiBo
//
//  Created by ZH on 2016/11/12.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    convenience init(title: String = "",imageName: String = "",fontSize:CGFloat = 10,spacing: CGFloat = 2,target: Any?, action: Selector?) {
        
        let btn = UIButton()
        
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitleColor(UIColor.orange, for: .highlighted)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        btn.setImage(UIImage(named: imageName), for: .normal)
//        btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        btn.setImagePosition(spacing: spacing)
        
        //监听按钮点击
        if let ac = action{
            
            btn.addTarget(target, action: ac, for: .touchUpInside)
        }
        
        btn.sizeToFit()
        
        self.init()
        
        self.customView = btn
        
    }
    
}
