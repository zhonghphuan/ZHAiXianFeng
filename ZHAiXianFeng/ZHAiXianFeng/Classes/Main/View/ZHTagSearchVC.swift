//
//  ZHTagSearchVC.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/29.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHTagSearchVC: UIViewController,UISearchBarDelegate {

    
    lazy var titleView:UIView = {
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 44))
        titleView.backgroundColor = UIColor.clear
        return titleView
    }()
    
    
    lazy var searchBar:UISearchBar = {
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 360, height: 44))
        searchBar.delegate = self
        searchBar.placeholder = "请输入要搜索的文字"
        searchBar.returnKeyType = .next
        searchBar.backgroundColor = UIColor.clear
        searchBar.backgroundImage = UIImage()
        let searBarTextField = searchBar.value(forKey: "_searchField") as! UITextField
        if (searBarTextField.text?.characters.count)! > 0 {
       
            searBarTextField.borderStyle = .roundedRect
            searBarTextField.layer.cornerRadius = 5.0
        }else{
        
        }
        
        
        return searchBar
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(searchBar)
      
    }




}
