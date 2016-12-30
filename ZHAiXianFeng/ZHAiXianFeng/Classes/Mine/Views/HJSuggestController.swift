//
//  HJSuggestController.swift
//  AiXianFeng
//
//  Created by zhouxuanhe on 2016/12/27.
//  Copyright © 2016年 zhouxuanhe. All rights reserved.
//

import UIKit
import SVProgressHUD
import SnapKit

class HJSuggestController: UIViewController,UITextViewDelegate {

    
    lazy var suggestLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "你的批评和建议能帮助我们更好的完善产品,请留下你的宝贵意见"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 0
        return lbl
    }()
    lazy var placeHolderLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "请输入你的意见(300字以内)"
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.textColor = UIColor.gray
        lbl.numberOfLines = 0
        return lbl
    }()
    lazy var textView: UITextView = {
        let tv = UITextView()
         tv.delegate = self
        return tv
    }()
    lazy var numLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 10)
        return lbl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        let item = UIBarButtonItem(title: "发送", fontSize: 14, spacing: 0, target: self, action: #selector(actionSendSuggest))
        self.navigationItem.rightBarButtonItem = item
        self.navigationController?.title = "反馈意见";
        self.view.backgroundColor = UIColor.lightGray
        
        self.view.addSubview(textView)
        self.view.addSubview(placeHolderLabel)
        self.view.addSubview(suggestLabel)
        self.view.addSubview(numLabel)
        numLabel.isHidden = true
       
        //边界宽度,边界颜色
        self.textView.layer.borderWidth = 0.2
        self.textView.layer.borderColor = UIColor.lightGray.cgColor
        //让文字从顶部输入
        self.automaticallyAdjustsScrollViewInsets = false
        
        //设置属性
        self.placeHolderLabel.isUserInteractionEnabled = false
        
        
        suggestLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(8)
             make.leading.equalTo(self.view).offset(8)
            make.trailing.equalTo(self.view).offset(-8)
        }
        textView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.view).offset(8)
            make.trailing.equalTo(self.view).offset(-8)
            make.top.equalTo(suggestLabel.snp.bottom).offset(10)
            make.height.equalTo(200)
        }
        placeHolderLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.view).offset(8)
            //make.trailing.equalTo(self.view).offset(-8)
            make.top.equalTo(textView.snp.top)
        }
        numLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(textView).offset(-8)
            make.trailing.equalTo(textView).offset(-8)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - 消息编写成功,发送
    func actionSendSuggest() {
        if numLabel.text == "" {
            SVProgressHUD.showError(withStatus: "请输入内容")
        }else {
            
            SVProgressHUD.showSuccess(withStatus: "发送成功")
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //这个判断相当于是textfield中的点击return的代理方法
        if text == "\n" {
            textView.resignFirstResponder()//关闭键盘
            
            return false
        }
        //在输入过程中 判断加上输入的字符 是否超过限定字数
         var str: String = textView.text + text
         if str.characters.count > 30 {
            let start = str.index(str.endIndex, offsetBy: -1)
            textView.text = textView.text.substring(to: start)
            self.numLabel.text = "30/30"
            return false
        }
        return true
        
    }
 

    func textViewDidChange(_ textView: UITextView) {
        self.placeHolderLabel.isHidden = true
        self.numLabel.isHidden = false
        ////实时显示字数
        self.numLabel.text = "\(textView.text.characters.count)" + "/30"
        
        if textView.text.characters.count >= 30 {
            
            let start = textView.text.index(textView.text.endIndex, offsetBy: -1)
            textView.text = textView.text.substring(to: start)
            self.numLabel.text = "30/30"
        }
         //取消按钮点击权限，并显示提示文字
        if textView.text.characters.count == 0 {
            self.placeHolderLabel.isHidden = false
        }
        
    }
}
