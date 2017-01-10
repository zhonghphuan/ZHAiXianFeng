//
//  AXFCellJumpView.swift
//  SpuerYangAngWang
//
//  Created by 王嘉涛 on 2016/12/26.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit

class AXFCellJumpView: UIView {

    override init(frame: CGRect){
        let rect = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        super.init(frame: rect)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        let imageView = UIImageView(image: UIImage.init(named: "v2_store_empty"))
        imageView.sizeToFit()
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(100)
        }
        
        let lbl = UILabel(title: "亲~还没有收藏的店铺哦!快去吧~", textColor: .black, fontSize: 14)
        self.addSubview(lbl)
        
        lbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(10)
        }
        
    }
}
