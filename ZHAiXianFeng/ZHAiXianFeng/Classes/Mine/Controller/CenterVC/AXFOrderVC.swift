//
//  AXFOuderVC.swift
//  SpuerYangAngWang
//
//  Created by 王嘉涛 on 2016/12/26.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit
import YYModel
import SVProgressHUD
let orderCellId = "orderCellId"
class AXFOrderVC: ZHBaseVC,UITableViewDataSource,UITableViewDelegate{
    
 
    
   lazy var orderTableview:UITableView = {
        let tableview = UITableView.init(frame: self.view.bounds, style: .grouped)
        return tableview
    }()
    
    lazy var ViewModel = AXFMineViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的订单"
       
        self.setUI()
    }
    func setUI(){
        SVProgressHUD.show()
        ViewModel.loadData { (isSucess) in
            if isSucess{
                SVProgressHUD.dismiss()
                // print("数据加载完成")
                //  print(self.ViewModel.MineOrderModelArray.count)
                self.orderTableview.reloadData()
            }
        }
        self.view.addSubview(orderTableview)
        orderTableview.dataSource = self
        orderTableview.delegate = self
        orderTableview.rowHeight = 173
        let nibName = UINib.init(nibName: "AXFOrderCell", bundle: nil)
        self.orderTableview.register(nibName, forCellReuseIdentifier: orderCellId)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.ViewModel.MineOrderModelArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: orderCellId, for: indexPath) as! AXFOrderCell
        cell.selectionStyle = .none
        cell.model = ViewModel.MineOrderModelArray[indexPath.section]
        return cell
    }
    
    //MARK: 代理方法
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.1
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = AXFOrderDetailVc()
        vc.detailModel = ViewModel.MineOrderModelArray[indexPath.section]
        self.navigationController?.pushViewController(vc, animated: true)
    }
 
}
