//
//  AXFShopNormalView.swift
//  SpuerYangAngWang
//
//  Created by 杨茂盛 on 2016/12/27.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit
import SnapKit
class AXFShopNormalView: UIView {

    var shopNormalViewcoluse:(() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //创建小车视图
        let carImageView = UIImageView.init(image: UIImage.init(named: "v2_shop_empty"))
        let notiLabel = UILabel.init(title: "亲,购物车空空的耶,赶紧挑好吃的吧!", textColor: .lightGray, fontSize: 15)
        let notiBtn = UIButton.init(title: "去逛逛", textColor: .lightGray, fontSize: 14)
   
        notiBtn.backgroundColor = #colorLiteral(red: 0.844186231, green: 0.844186231, blue: 0.844186231, alpha: 1)
        self.addSubview(carImageView)
        self.addSubview(notiLabel)
        self.addSubview(notiBtn)
    
        carImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(200)
            make.size.equalTo(CGSize.init(width: 100, height: 100))
        }
        notiLabel.snp.makeConstraints { (make) in
            make.top.equalTo(carImageView.snp.bottom).offset(20)
            make.centerX.equalTo(carImageView)
        }
        notiBtn.snp.makeConstraints { (make) in
            make.top.equalTo(notiLabel.snp.bottom).offset(10)
            make.centerX.equalTo(notiLabel)
            make.size.equalTo(CGSize.init(width: 100, height: 40))
        }
        notiBtn.layer.cornerRadius = 20
        notiBtn.layer.masksToBounds = true
        notiBtn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
    
    @objc private func dismissVC(){
        
        if shopNormalViewcoluse != nil {
            shopNormalViewcoluse!()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
