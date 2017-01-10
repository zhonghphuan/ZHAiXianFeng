//
//  ZHSmallView.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/24.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit
import SnapKit

class ZHSmallView: UIControl {


    var count:Int = 0 {
        didSet{
            numLabel.isHidden = (count == 0)
            reduceBtn.isHidden = (count == 0)
            numLabel.text = "\(count)"
        }
    }
    var number:NSNumber?
    var name:String?
    var isIncrementClicked:Bool?
    var smallViewClosure:(() -> ())?
    //增加的按钮
    lazy var increaseBtn:UIButton = {
       let increaseBtn = UIButton(type: .custom)
        increaseBtn.setImage(UIImage(named:"v2_increase"), for: .normal)
        increaseBtn.setBackgroundImage(UIImage(named:"v2_noselected"), for: .highlighted)
        return increaseBtn
    }()
    
    //减少的按钮
    lazy var reduceBtn:UIButton = {
        let reduceBtn = UIButton(type: .custom)
        reduceBtn.setImage(UIImage(named:"v2_reduce"), for: .normal)
        reduceBtn.setBackgroundImage(UIImage(named:"v2_noselected"), for: .highlighted)
        return reduceBtn
    }()
    
    //中间文字
    lazy var numLabel:UILabel = {
        let numLabel = UILabel()
        numLabel.font = UIFont.systemFont(ofSize: 12)
        numLabel.textColor = .black
        numLabel.textAlignment = .center
        return numLabel
    }()
    // MARK:- 初始化
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        //添加
        addSubview(increaseBtn)
        addSubview(reduceBtn)
        addSubview(numLabel)
       
        numLabel.isHidden = (count == 0)
        reduceBtn.isHidden = (count == 0)
        //布局
        reduceBtn.snp.makeConstraints { (make) in
            make.leading.top.equalTo(self)
            make.width.equalTo(22)
            make.height.equalTo(22)
        }
        
        increaseBtn.snp.makeConstraints { (make) in
            make.trailing.top.equalTo(self)
            make.width.equalTo(22)
            make.height.equalTo(22)
        }
        
        numLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(reduceBtn)
            make.centerX.equalTo(self)
        }
        
        //监听按钮点击
        increaseBtn.addTarget(self, action: #selector(increaseAction(btn:)), for: .touchUpInside)
        reduceBtn.addTarget(self, action: #selector(reduceAction(btn:)), for: .touchUpInside)
        
    }
    
    func increaseAction(btn:UIButton) {

        if count >=  Int(number!) {
            //弹框回调提示
            //发出通知
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kAlertNotification), object: name, userInfo: nil)
            return
        }
        count += 1

        isIncrementClicked = true
        sendActions(for: .valueChanged)
    }
    
    func reduceAction(btn:UIButton) {
        if count <= 0 {
            return
        }
        count -= 1

        isIncrementClicked = false
        sendActions(for: .valueChanged)
    }
    
    //移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
        
    }
}
