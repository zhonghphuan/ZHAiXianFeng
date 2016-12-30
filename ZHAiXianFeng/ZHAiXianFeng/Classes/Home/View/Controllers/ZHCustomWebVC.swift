//
//  ZHCustomWebVC.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/23.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

class ZHCustomWebVC: UIViewController {
    
    let webView = UIWebView()
    
    var urlString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = webView
        loadPage()
    }
    
    private func loadPage() {
        
        guard let urlStr = urlString else {
            
            return
        }
        
        let url = URL(string: urlStr)
        
        let request = URLRequest(url: url!)
        
        webView.loadRequest(request)
    }
}
