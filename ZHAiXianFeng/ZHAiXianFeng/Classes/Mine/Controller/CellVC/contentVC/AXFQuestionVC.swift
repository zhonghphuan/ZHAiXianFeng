//
//  AXFQuestionVC.swift
//  SpuerYangAngWang
//
//  Created by 王嘉涛 on 2016/12/26.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit

class AXFQuestionVC: AXFBaseCellVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "常见问题"
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.separatorStyle = .singleLine
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
