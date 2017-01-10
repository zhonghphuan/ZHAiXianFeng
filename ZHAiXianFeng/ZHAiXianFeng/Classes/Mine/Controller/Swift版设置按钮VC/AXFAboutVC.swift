//
//  AXFAboutVC.swift
//  SpuerYangAngWang
//
//  Created by 王嘉涛 on 2016/12/27.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit

class AXFAboutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        setupUI()
    }

    private func setupUI() {
        let imageView = UIImageView(image: UIImage.init(named: "author"))
        imageView.sizeToFit()
        self.view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(100)
        }
        
        let oneLbl = UILabel(title: "维尼的小熊", textColor: .black, fontSize: 16)
        self.view.addSubview(oneLbl)
        
        oneLbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
        let twoLbl = UILabel(title: "GitHub:https://github.com/ZhongTaoTian", textColor: .gray, fontSize: 11)
        self.view.addSubview(twoLbl)
        
        twoLbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(oneLbl)
            make.top.equalTo(oneLbl.snp.bottom).offset(20)
        }

        let threeLbl = UILabel(title: "新浪微博:http://weibo.com/tianzhongtao", textColor: .gray, fontSize: 11)
        self.view.addSubview(threeLbl)
        
        threeLbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(twoLbl)
            make.top.equalTo(twoLbl.snp.bottom).offset(20)
        }

        let fourLbl = UILabel(title: "技术博客:http://www.jianshu.com/users/5fe7513c7a57/latest_articles", textColor: .gray, fontSize: 11)
        self.view.addSubview(fourLbl)
        
        fourLbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(threeLbl)
            make.top.equalTo(threeLbl.snp.bottom).offset(20)
        }

        
    }

}
