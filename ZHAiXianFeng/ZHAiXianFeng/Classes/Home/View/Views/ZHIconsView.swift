//
//  ZHIconsView.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/23.
//  Copyright © 2016年 ZH. All rights reserved.

import UIKit
import SDWebImage

class ZHIconsView: UIView {

    var count:Int?
    var customclosure:((Int)->(Void))?
    var iconsViewModel:[ZHIconsModel]? {
        
        didSet {
            guard let count = iconsViewModel?.count else {
                return
            }
            let width = Int(ScreenWidth) / count
            for i in 0..<count {
                let imageName = iconsViewModel?[i].img
                let title = iconsViewModel?[i].name
                let btn = UIButton.init(title: title!, textColor: UIColor.black, fontSize: 12)
                let url = URL(string: imageName!)
                btn.sd_setImage(with: url, for: .normal, placeholderImage: UIImage(named:"icon_icons_holder"))
                
                btn.frame = CGRect(x: CGFloat(i * width) + 10, y: CGFloat(width) * 0.5 - 38  , width: CGFloat(width) - 20, height: 50)
                btn.tag = i
                let lab = UILabel(title: title!, textColor: UIColor.black, fontSize: 12)
                lab.textAlignment = .center
                lab.frame = CGRect(x: CGFloat(i * width) + 10 , y: CGFloat(width) * 0.5 + 10, width: CGFloat(width) - 20, height: 30)
                lab.tag = i
                self.addSubview(lab)
                self.addSubview(btn)
                
                lab.isUserInteractionEnabled = true
                btn.addTarget(self, action: #selector(actionBtn(btn:)), for: .touchUpInside)
                let tap = UITapGestureRecognizer(target: self, action: #selector(tap(recognizer:)))
                lab.addGestureRecognizer(tap)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZHIconsView {
    
    //label的手势跳转回调
    func tap(recognizer:UITapGestureRecognizer) {
        let lab:UILabel = recognizer.view as! UILabel
        goWebVC(index: lab.tag)
    }
    //btn按钮的点击回调
    func actionBtn(btn:UIButton) {
        goWebVC(index: btn.tag)
    }
    //闭包回调跳转到webView
    func goWebVC(index:Int){
        if customclosure != nil {
            customclosure!(index)
        }
    }
    
}
