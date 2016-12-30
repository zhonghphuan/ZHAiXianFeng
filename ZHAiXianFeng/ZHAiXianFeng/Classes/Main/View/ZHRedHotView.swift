//
//  ZHRedHotView.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/28.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHRedHotView: UIView {


    

    @IBOutlet weak var cyView: UIView!

    @IBOutlet weak var countLabel: UILabel!
    
    var numText:String = "0" {
        
        didSet{
           
            cyView.isHidden = (numText == "0")
         
        }
    }
    
    class func redHotView() -> ZHRedHotView {
        
        return Bundle.main.loadNibNamed("ZHRedHotView", owner: nil, options: nil)?.last as! ZHRedHotView
    }


}
