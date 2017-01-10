//
//  AXFMineTopVIew.swift
//  SpuerYangAngWang
//
//  Created by 王嘉涛 on 2016/12/26.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit

class AXFMineTopVIew: UIView {
    
    // 闭包
    var closeBag : (()->())?
    
     override init(frame: CGRect){
        let rect = CGRect(x: 0, y: 0, width: ScreenWidth, height: 150)
        super.init(frame: rect)
        
        setUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUI() {
        
        let topImageView = UIImageView(image: UIImage(named: "v2_my_avatar_bg"))
        topImageView.contentMode = .scaleToFill
        topImageView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: self.bounds.height)
        self.addSubview(topImageView)
        
        let userImageView = UIImageView(image: UIImage(named: "v2_my_avatar"))
        userImageView.contentMode = .scaleToFill
        userImageView.sizeToFit()
        topImageView.addSubview(userImageView)
        
        userImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(topImageView)
            make.top.equalTo(topImageView.snp.top).offset(25)
        }
        
        let lbl = UILabel()
        lbl.text = "13843813838"
        lbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        topImageView.addSubview(lbl)
        
        lbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(topImageView)
            make.top.equalTo(userImageView.snp.bottom).offset(20)
        }
        
        // 设置按钮
        let setBtn = UIButton()
        setBtn.setImage(UIImage.init(named: "v2_my_settings_icon"), for: .normal)
        setBtn.setImage(UIImage.init(named: "v2_my_settings_icon"), for: .highlighted)
        setBtn.addTarget(self, action: #selector(clickSetBtn), for: .touchUpInside)
        setBtn.sizeToFit()
        topImageView.addSubview(setBtn)
        topImageView.isUserInteractionEnabled = true
        setBtn.snp.makeConstraints { (make) in
            make.top.equalTo(userImageView)
            make.trailing.equalTo(topImageView).offset(-10)
        }
    }
    
    func clickSetBtn() {
        closeBag?()
    }
}
