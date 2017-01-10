//
//  AXFEditCell.swift
//  SpuerYangAngWang
//
//  Created by 王嘉涛 on 2016/12/27.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit

class AXFEditCell: UITableViewCell {

    // 名字
    @IBOutlet weak var nameTextFiled: UITextField!
    // 电话号
    @IBOutlet weak var phoneNumTextFiled: UITextField!
    // 城市
    @IBOutlet weak var cityTextFiled: UITextField!
    // 地址
    @IBOutlet weak var ressTextFiled: UITextField!
    // 详细地址
    @IBOutlet weak var detailedTextFiled: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var addressModel : AXFAddressModel? {
        
        didSet{
            nameTextFiled.text = addressModel?.accept_name
            phoneNumTextFiled.text = addressModel?.telphone
            cityTextFiled.text = addressModel?.city_name
            let str = addressModel?.address
            let ress = str?.components(separatedBy: " ").first
            let detailed = str?.components(separatedBy: " ").last
            
            ressTextFiled.text = ress
            detailedTextFiled.text = detailed
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
