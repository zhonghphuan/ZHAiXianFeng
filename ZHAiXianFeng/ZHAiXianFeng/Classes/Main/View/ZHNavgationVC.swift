//
//  ZHNavgationVC.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/22.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHNavgationVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "v2_my_avatar_bg"), for: UIBarMetrics.default)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        let count = childViewControllers.count
        if count > 0 {
            viewController.view.backgroundColor = UIColor(white: 237.0 / 255.0, alpha: 1)
            //隐藏底部tabBar
            viewController.hidesBottomBarWhenPushed = true
            //设置返回按钮向左边偏移一点点
            let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
            spaceItem.width = -10

            //设置返回按钮
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "v2_goback", target: self, action: #selector(back))
            viewController.navigationItem.leftBarButtonItems = [spaceItem,viewController.navigationItem.leftBarButtonItem!]
            
        }
        super.pushViewController(viewController, animated: animated)

    }
    
    @objc private func back() {
        
        popViewController(animated: true)
    }

}

