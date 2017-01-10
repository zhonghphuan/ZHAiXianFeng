//
//  HomeCollectionFooterView.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/23.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class HomeCollectionFooterView: UICollectionReusableView {
    var taplabel:(() ->())?
    let titleLabel: UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "点击查看更多商品 >"
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        titleLabel.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: CollectionFooterViewHeigth)
        addSubview(titleLabel)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(tap:)))
        addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tap(tap:UITapGestureRecognizer){
        
        if taplabel != nil {
            taplabel!()
        }
    }
    
    func hideLabel() {
        self.titleLabel.isHidden = true
    }
    
    func showLabel() {
        self.titleLabel.isHidden = false
    }
    
    func setFooterTitle(_ text: String, textColor: UIColor) {
        titleLabel.text = text
        titleLabel.textColor = textColor
    }


}
