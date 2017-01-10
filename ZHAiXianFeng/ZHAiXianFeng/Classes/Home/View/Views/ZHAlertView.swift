//
//  ZHAlertView.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/24.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHAlertView: UIView {

    
    @IBOutlet weak var nameLabel: UILabel!
 
    var desc:String? {
        
        didSet{
            
            nameLabel.text = desc
        }
    }
    
    class func alertView() -> ZHAlertView {
        
        return Bundle.main.loadNibNamed("ZHAlertView", owner: nil, options: nil)?.last as! ZHAlertView
    }

}
