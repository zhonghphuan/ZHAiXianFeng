//
//  AXFCellThreeCustomVC.swift
//  SpuerYangAngWang
//
//  Created by 王嘉涛 on 2016/12/26.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit

class AXFCellThreeCustomVC: AXFBaseCellVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID_one, for: indexPath)
            cell.textLabel?.text = "客服电话:400-8484-842"
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID_one, for: indexPath)
        cell.textLabel?.text = "常见问题"
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // 弹窗
            let windowAlert = UIAlertController(title: "", message: "400-8484-842", preferredStyle:.alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler:nil)
            let callAction = UIAlertAction(title: "拨打", style: .default, handler: { (action) in
                print("拨打")
            })
            windowAlert.addAction(cancelAction)
            windowAlert.addAction(callAction)
            self.present(windowAlert, animated: true, completion: nil)
        }
        if indexPath.row == 1 {
            self.navigationController?.pushViewController(AXFQuestionVC(), animated: true)
        }
        
    }
}
