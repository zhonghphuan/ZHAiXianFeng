//
//  AXFEditVC.swift
//  SpuerYangAngWang
//
//  Created by 王嘉涛 on 2016/12/27.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit
let editCellID = "editID"
class AXFEditVC: AXFBaseCellVC {

    var addressModel : AXFAddressModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib.init(nibName: "AXFEditCell", bundle: nil), forCellReuseIdentifier: editCellID)
        self.tableView.rowHeight = 400
        
        creatRemoveBtn()
        
    }
    
    
    // 创建删除按钮
    private func creatRemoveBtn() {
        let btn = UIButton(frame: CGRect.init(x: 0, y: self.view.bounds.height-135, width: ScreenWidth, height: 50))
        btn.setTitle("删除当前地址", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        btn.addTarget(self, action: #selector(clickRemoveBtn), for: .touchUpInside)
        btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(btn)
        
    }
    @objc private func clickRemoveBtn(){
        self.navigationController!.popViewController(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name("remove"), object: addressModel)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: editCellID, for: indexPath) as! AXFEditCell
        cell.selectionStyle = .none
        cell.addressModel = addressModel
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

}
