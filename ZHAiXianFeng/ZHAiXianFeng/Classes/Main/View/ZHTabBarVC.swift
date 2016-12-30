//
//  ZHTabBarVC.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/22.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHTabBarVC: UITabBarController {


    override func viewDidLoad() {
        super.viewDidLoad()

        //自定义tabBar
        
        let zhTabBar = ZHTabBar()
        //由于系统tabBar是只读属性不能赋值,采用KVC
        
        self.setValue(zhTabBar, forKey: "tabBar")
        
        //监听按钮点击事件
        
        zhTabBar.shoppingCarClosure = { [weak self] in
            let nav = ZHNavgationVC(rootViewController: ZHShoppingCarVC())
            self?.present(nav, animated: true, completion: nil)
        }

        addCustomChildVC()
    }
    // MARK:- 添加子视图控制器
    
    private func addCustomChildVC() {
        
        addChildViewController(ZHHomeVC(), title: "首页", imageName: "v2_home",index:0)
        addChildViewController(ZHSupermarketVC(), title: "闪电超市", imageName: "v2_order",index:1)
        addChildViewController(AXFMineController(), title: "我的", imageName: "v2_my",index:2)
   
    }
    
    // MARK:- 添加每个子视图控制器
    
    private func addChildViewController(_ childController: UIViewController,title: String,imageName: String,index: Int) {
        
        childController.tabBarItem.tag = index
        //设置文字
        childController.title = title
        childController.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .selected)
        childController.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 10)], for: .normal)
        //微调文字位置
        childController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        //可以设置徽章
        childController.tabBarItem.badgeColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        childController.tabBarItem.badgeValue = "10"
        //取消徽章
        childController.tabBarItem.badgeValue = nil
        //设置图片
        let image = UIImage.createNewImage(withColor: UIImage(named:imageName), multiple: 0.85)
        let selectedImage = UIImage.createNewImage(withColor: UIImage(named:imageName + "_r"), multiple: 0.85)
        childController.tabBarItem.image = image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        childController.tabBarItem.selectedImage = selectedImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        //可以设置图片偏移
        childController.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 3, 0, -3)
        
        let nav = ZHNavgationVC(rootViewController: childController)
        self.addChildViewController(nav)
    }
    
    
    //让tabBar按钮图片点击后"抖一下"
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        var index = 0
        
        for subView in tabBar.subviews {
            //会同时打印全部tabBar按钮,通过tag值遍历点击的是哪个按钮
            if subView.isKind(of: NSClassFromString("UITabBarButton")!) {
                if index == item.tag {
                    
                    for v in subView.subviews {
                        
                        if v.isKind(of: NSClassFromString("UIImageView")!) {
                            
                            //这里已经找到了按钮上的图片,可以进行动画了
                            v.shakeToShowView()
                        }
                    }
                }
                index += 1
            }
        }
    }
}
