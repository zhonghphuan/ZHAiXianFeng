//
//  ZHTitleView.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/22.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHTitleView: UIButton {

    var clouse: (() -> ())?
    class func liveAnchorView() -> ZHTitleView {
        
        return Bundle.main.loadNibNamed("ZHTitleView", owner: nil, options: nil)?.last as! ZHTitleView
    }
    
    @IBOutlet weak var leftLable: UILabel!

    @IBOutlet weak var midLabel: UILabel!

    override func awakeFromNib() {
        
        self.addTarget(self, action:#selector(peiSong), for: .touchUpInside)
        
    }
    
    func peiSong() {
        if clouse != nil {
            clouse!()
        }
        print("配送")
    }
    
    override func draw(_ rect: CGRect) {
        let textSize = NSString(string: leftLable.text!).size(attributes: [NSFontAttributeName : leftLable.font!])
        let pathRect = CGRect(x:0, y: 0, width: textSize.width + 4, height: textSize.height + 4)
        let path = UIBezierPath(roundedRect: pathRect, cornerRadius: 0)
        
        path.lineWidth = 0.5
        UIColor.clear.setFill()
        UIColor.black.setStroke()
        path.fill()
        path.stroke()
    }
}
