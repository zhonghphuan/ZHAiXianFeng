//
//  ZHBaseVC.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/22.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit


class ZHBaseVC: UIViewController,CAAnimationDelegate {

    lazy var itemLeft = UIBarButtonItem()
    lazy var itemRigth = UIBarButtonItem()
    lazy var searchBarviewModel = ZHSearchBarVM()
    var animationLayers: [CALayer]?
    
    var animationBigLayers: [CALayer]?
    
    // MARK: 商品添加到购物车动画
    func addProductsAnimation(_ imageView: UIImageView) {
        
        if (self.animationLayers == nil)
        {
            self.animationLayers = [CALayer]();
        }
        
        let frame = imageView.convert(imageView.bounds, to: view)
        let transitionLayer = CALayer()
        transitionLayer.frame = frame
        transitionLayer.contents = imageView.layer.contents
        self.view.layer.addSublayer(transitionLayer)
        self.animationLayers?.append(transitionLayer)
        //imageView中点
        let p1 = transitionLayer.position;
        //动画终点位置
        let p3 = CGPoint(x: ScreenWidth - ScreenWidth / 4 - ScreenWidth / 8 - 4, y: self.view.layer.bounds.size.height - 40);
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath();
        
        path.move(to: CGPoint(x: p1.x, y: p1.y))
        path.addCurve(to: CGPoint(x: p3.x, y: p3.y), control1: CGPoint(x: p1.x, y: p1.y - 30), control2: CGPoint(x: p3.x, y: p1.y - 30))
        
        positionAnimation.path = path;
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.9
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.isRemovedOnCompletion = false
        
        let transformAnimation = CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        transformAnimation.toValue = NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1))
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation,transformAnimation, opacityAnimation];
        groupAnimation.duration = 0.8
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.delegate = self;
        
        transitionLayer.add(groupAnimation, forKey: "cartParabola")
    }
    
    // MARK: - 添加商品到右下角购物车动画
    func addProductsToBigShopCarAnimation(_ imageView: UIImageView) {
        if animationBigLayers == nil {
            animationBigLayers = [CALayer]()
        }
        let frame = imageView.convert(imageView.bounds, to: view)
        let transitionLayer = CALayer()
        transitionLayer.frame = frame
        transitionLayer.contents = imageView.layer.contents
        self.view.layer.addSublayer(transitionLayer)
        self.animationBigLayers?.append(transitionLayer)
        
        let p1 = transitionLayer.position;
        let p3 = CGPoint(x: ScreenWidth - 40, y: ScreenHeight - 40);
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath();
        
        path.move(to: CGPoint(x: p1.x, y: p1.y))
        path.addCurve(to: CGPoint(x: p3.x, y: p3.y), control1: CGPoint(x: p1.x, y: p1.y - 30), control2: CGPoint(x: p3.x, y: p1.y - 30))
        positionAnimation.path = path;
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.9
        opacityAnimation.fillMode = kCAFillModeForwards
        opacityAnimation.isRemovedOnCompletion = true
        
        let transformAnimation = CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        transformAnimation.toValue = NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1))
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, transformAnimation, opacityAnimation];
        groupAnimation.duration = 0.5
        groupAnimation.delegate = self;
        
        transitionLayer.add(groupAnimation, forKey: "BigShopCarAnimation")
    }

    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
         guard let count1 = self.animationLayers?.count else { return }
        if count1 > 0 {
            let transitionLayer = animationLayers?.first
            transitionLayer?.isHidden = true
            transitionLayer?.removeFromSuperlayer()
            animationLayers?.removeFirst()
            view.layer.removeAnimation(forKey: "cartParabola")
        }
        
        guard let count2 = self.animationBigLayers?.count else { return }
        if count2 > 0 {
            let transitionLayer = animationBigLayers?.first
            transitionLayer?.isHidden = true
            transitionLayer?.removeFromSuperlayer()
            animationBigLayers?.removeFirst()
            view.layer.removeAnimation(forKey: "BigShopCarAnimation")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNav()
        //监听通知
        
        NotificationCenter.default.addObserver(self, selector: #selector(alert(noti:)), name: NSNotification.Name(rawValue: kAlertNotification), object: nil)

    }
    
    @objc private func alert(noti:Notification) {
        
        let maskView = UIView(frame: UIScreen.main.bounds)
        maskView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        
        //弹框
        let alertView = ZHAlertView.alertView()
        let name:String = noti.object as! String
        alertView.desc = name
        let keywindow = UIApplication.shared.keyWindow
        keywindow?.addSubview(maskView)
        keywindow?.addSubview(alertView)
        
        alertView.snp.makeConstraints { (make) in
            make.centerX.equalTo(keywindow!)
            make.centerY.equalTo(keywindow!).offset(-20)
            make.width.equalTo(210)
            make.height.equalTo(160)
        }
        
        alertView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: [], animations: {
            alertView.alpha = 1
            alertView.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        }, completion: { isok in
            
            //延迟1s
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                maskView.removeFromSuperview()
                alertView.removeFromSuperview()
            }
            
        })
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ZHBaseVC {
    
    func setNav() {
 
        let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spaceItem.width = -15
        //设置返回按钮
        let itemLeft = UIBarButtonItem(title: "扫一扫", imageName: "icon_black_scancode", target: self, action: #selector(scan))
        self.navigationItem.leftBarButtonItems = [spaceItem,itemLeft]

        //设置返回按钮
        let itemRigth = UIBarButtonItem(title: "搜 索", imageName: "icon_search", target: self, action: #selector(search))
        self.navigationItem.rightBarButtonItems = [spaceItem,itemRigth]
        let titView =  ZHTitleView.liveAnchorView()
        self.navigationItem.titleView = titView
        titView.clouse = {
            let vc = AXFCellOneCustomVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    func scan() {
        print("扫一扫")
    }

    func search() {
        
       print("搜索")
        
        let tagSearchVC = ZHSearchBarVC()
        searchBarviewModel.loadSearchDate { (isok) in
            let array2 = self.searchBarviewModel.arraySearch as![Any]
            tagSearchVC.dataSource = array2
            self.navigationController?.pushViewController(tagSearchVC, animated: true)
        }

    }
    
}


