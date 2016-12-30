//
//  AXFCellFourCustomVC.swift
//  SpuerYangAngWang
//
//  Created by 王嘉涛 on 2016/12/26.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit

class AXFCellFourCustomVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = false
        let lbl = UILabel(title: "你的宝贵批评和建议能帮助我们更好的完善产品,请留下宝贵的意见!", textColor: .black, fontSize: 14)
        lbl.numberOfLines = 10
        self.view.addSubview(lbl)
        lbl.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(70)
            make.leading.equalTo(self.view).offset(8)
            make.trailing.equalTo(self.view).offset(-8)
        }
        
        let textFile = UITextField()
        textFile.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textFile.placeholder = "请输入宝贵意见(300字以内)"
        self.view.addSubview(textFile)
        
        textFile.snp.makeConstraints { (make) in
            make.top.equalTo(lbl.snp.bottom).offset(10)
            make.leading.trailing.equalTo(lbl)
            make.height.equalTo(200)
        }
        
    }

}
