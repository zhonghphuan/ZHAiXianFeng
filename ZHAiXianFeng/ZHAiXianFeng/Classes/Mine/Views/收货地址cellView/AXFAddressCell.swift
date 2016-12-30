//
//  AXFAddressCell.swift
//  SpuerYangAngWang
//
//  Created by 王嘉涛 on 2016/12/27.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit

class AXFAddressCell: UITableViewCell {
    
    // 跳转控制器的闭包
    var jumpClose : (()->())?
    
    // 名字
    @IBOutlet weak var nameLbl: UILabel!
    // 电话号
    @IBOutlet weak var phoneNumLbl: UILabel!
    // 收货地址
    @IBOutlet weak var ressLbl: UILabel!
    // 编辑按钮
    @IBOutlet weak var editBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.editBtn.addTarget(self, action: #selector(clickEditBtn), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc private func clickEditBtn() {
        
        jumpClose?()
    }
}
