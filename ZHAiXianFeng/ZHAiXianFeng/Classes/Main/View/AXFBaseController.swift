//
//  AXFBaseController.swift
//  SpuerYangAngWang
//
//  Created by 杨茂盛 on 2016/12/22.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit

class AXFBaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航栏左右两个按钮
        self.setNav()
        //设置导航栏颜色
        self .setNavColor()
    }
    func setNavColor(){
//        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
         self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9686274529, green: 0.8722725971, blue: 0.4904906162, alpha: 1)
    }
    
    func setNav() {
        
        let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spaceItem.width = -15
        //设置返回按钮
        let itemLeft = UIBarButtonItem(title: "扫一扫", imageName: "icon_black_scancode", target: self, action: #selector(scan))
        self.navigationItem.leftBarButtonItems = [spaceItem,itemLeft]
        
        //设置返回按钮
        let itemRigth = UIBarButtonItem(title: "搜 索", imageName: "icon_search", target: self, action: #selector(search))
        self.navigationItem.rightBarButtonItems = [spaceItem,itemRigth]
        
        self.navigationItem.titleView = ZHTitleView.liveAnchorView()
        
    }
    
    func scan() {
        print("扫一扫")
    }
    
    func search() {
        let tagSearchVC = ZHSearchBarVC()
        
        self.navigationController?.pushViewController(tagSearchVC, animated: true)
    }
}
