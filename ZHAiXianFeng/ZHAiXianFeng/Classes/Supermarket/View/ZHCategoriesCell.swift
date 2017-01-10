//
//  ZHCategoriesCell.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/25.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHCategoriesCell: UITableViewCell {

    
    
    @IBOutlet weak var nameLabel: UILabel!
    var categoriesModel:ZHCategoriesModel? {
        
        didSet{
            
            nameLabel.text = categoriesModel?.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
         backgroundColor = UIColor(white: 0.92, alpha: 0.5)
        let shlayer = CAShapeLayer()
        let path = UIBezierPath(rect: self.bounds)
        shlayer.fillColor = UIColor.white.cgColor
        shlayer.path = path.cgPath
        
        let Lineshlayer = CAShapeLayer()
        let lineHeight = self.bounds.size.height * 0.6
        let lineY = (self.bounds.size.height - lineHeight) * 0.5
        let Linepath = UIBezierPath(rect: CGRect(x: 0, y: lineY, width: 4, height: lineHeight))
        Lineshlayer.path = Linepath.cgPath
        Lineshlayer.fillColor = #colorLiteral(red: 0.9921646714, green: 0.7784059048, blue: 0.188852042, alpha: 1).cgColor
        
        let bottomshlayer = CAShapeLayer()
        let bottomlineWidth = self.bounds.size.width
        let bottomlineY = self.bounds.size.height
        let bottomLinepath = UIBezierPath(rect: CGRect(x: 0, y: bottomlineY, width: bottomlineWidth, height: 0.5))
        bottomshlayer.path = bottomLinepath.cgPath
        bottomshlayer.fillColor = UIColor(white: 0.8, alpha: 0.9).cgColor
        
        shlayer.addSublayer(Lineshlayer)
        selectedBackgroundView?.layer.addSublayer(shlayer)
        self.layer.addSublayer(bottomshlayer)
        
    }
    
    
}
