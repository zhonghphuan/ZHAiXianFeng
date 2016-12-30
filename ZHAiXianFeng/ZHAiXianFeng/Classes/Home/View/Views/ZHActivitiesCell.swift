//
//  ZHSellFastCell.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/23.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit
import SnapKit

class ZHActivitiesCell: UICollectionViewCell {

    //懒加载图片
    lazy var imgView:UIImageView = {
       
        let imgView2 = UIImageView()
        
        return imgView2
    }()
    
    //重写set方法获取模型数据并赋值
    var activitiesCellModel:ZHActivitiesModel? {
        
        didSet{
            let url = URL(string: (activitiesCellModel?.img)!)
            imgView.sd_setImage(with: url!)
        }
    }
    //初始化方法
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         setupUI()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //加载UI界面
    func setupUI() {
        
        self.contentView.addSubview(imgView)
        self.contentView.backgroundColor = #colorLiteral(red: 0.9371759295, green: 0.937307179, blue: 0.9371344447, alpha: 1)
        imgView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalTo(self.contentView)
        }
    }
}
