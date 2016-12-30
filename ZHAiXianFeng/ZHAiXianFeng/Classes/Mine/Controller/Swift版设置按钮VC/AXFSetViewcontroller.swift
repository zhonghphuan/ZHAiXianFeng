//
//  AXFSetViewcontroller.swift
//  SpuerYangAngWang
//
//  Created by 王嘉涛 on 2016/12/26.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit
import SDWebImage
let setCellID = "setCell"
class AXFSetViewcontroller: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.title = "设置"
        setupUI()
    }

    private func setupUI() {
        
        let tableView = UITableView(frame: CGRect(x:0,y:0,width:ScreenWidth,height:ScreenHeight), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: setCellID)
        tableView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        self.view.addSubview(tableView)
        tableView.contentInset = UIEdgeInsetsMake(-38, 0, 0, 0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default: break
        }
        return section
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: setCellID, for: indexPath)
            cell.textLabel?.text = "关于小熊"
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.section == 0 && indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: setCellID, for: indexPath)
            cell.textLabel?.text = "清理缓存"
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: setCellID, for: indexPath)
        cell.textLabel?.text = "退出当前账号"
        cell.textLabel?.textAlignment = .center
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            self.navigationController?.pushViewController(AXFAboutVC(), animated: true)
        }
        if indexPath.section == 0 && indexPath.row == 1{
            let alertContrl = UIAlertController.init(title: "", message: "是否清理缓存?", preferredStyle: .alert)
            let cancleAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let cleanAction = UIAlertAction(title: "清除", style: .default, handler: { (action) in
                print("清理缓存")
            })
            alertContrl.addAction(cancleAction)
            alertContrl.addAction(cleanAction)
            self.present(alertContrl, animated: true, completion: nil)
        }
        if indexPath.section == 1 && indexPath.row == 0{
            print("退出")
        }
    }
    
}
