//
//  AXFMineController.swift
//  SpuerYangAngWang
//
//  Created by 杨茂盛 on 2016/12/22.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit
let cellID = "cell"
class AXFMineController: ZHBaseVC,UITableViewDataSource,UITableViewDelegate {
    
    var topView : UIView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // topView
        creatTopView()
        
        // tableview
        creatTableView()
    }

    // 创建顶部视图
    private func creatTopView() {
        let topView = AXFMineTopVIew()
        topView.closeBag = { [weak self] in
            self?.navigationController?.pushViewController(AXFOCSetVC(), animated: true)
        }
        self.view.addSubview(topView)
        self.topView = topView
    }

    // 创建tableView
    private func creatTableView() {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "AXFMineCell", bundle: nil), forCellReuseIdentifier: cellID)
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topView!.snp.bottom)
            make.leading.trailing.equalTo(self.view)
            make.height.equalTo(600)
        }
        
        // 设置headerView
        let centerView = AXFMineCenterView.CenterView()
        tableView.tableHeaderView = centerView
        // 执行闭包
        centerView.closeOrderBag = {
            self.navigationController?.pushViewController(AXFOrderVC(), animated: true)
        }
        centerView.closeCouponBag = {
            self.navigationController?.pushViewController(HJMyDiscountController(), animated: true)
        }
        centerView.closeMessageBag = {
            self.navigationController?.pushViewController(HJMessageController(), animated: true)
        }
    }
}

extension AXFMineController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
            return 2
        default: break
        }
        return section
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier:cellID, for: indexPath) as! AXFMineCell
            cell.iconImageView.image = UIImage.init(named: "v2_my_address_icon")
            cell.cellLbl.text = "我的收货地址"
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.section == 0 && indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier:cellID, for: indexPath) as! AXFMineCell
            cell.iconImageView.image = UIImage.init(named: "icon_mystore")
            cell.cellLbl.text = "我的店铺"
            cell.selectionStyle = .none
            return cell
        }

        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier:cellID, for: indexPath) as! AXFMineCell
            cell.iconImageView.image = UIImage.init(named: "v2_my_share_icon")
            cell.cellLbl.text = "把爱鲜蜂分享给朋友"
            cell.selectionStyle = .none

            return cell
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier:cellID, for: indexPath) as! AXFMineCell
            cell.iconImageView.image = UIImage.init(named: "v2_my_serviceonline_icon")
            cell.cellLbl.text = "客服帮助"
            cell.selectionStyle = .none

            return cell
        }

        if indexPath.section == 2 && indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier:cellID, for: indexPath) as! AXFMineCell
            cell.iconImageView.image = UIImage.init(named: "v2_my_feedback_icon")
            cell.cellLbl.text = "意见反馈"
            cell.selectionStyle = .none

            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier:cellID, for: indexPath) as! AXFMineCell
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    
    // 点击cell跳转
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AXFMineCell
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let vc = AXFCellOneCustomVC()
            vc.title = cell.cellLbl.text
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.section == 0 && indexPath.row == 1 {
            let vc = AXFCellTwoCustomVC()
            vc.title = cell.cellLbl.text
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.section == 1 {
            creatActionSheetView()
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            let vc = AXFCellThreeCustomVC()
            vc.title = cell.cellLbl.text
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.section == 2 && indexPath.row == 1 {
            let vc = HJSuggestController()
            vc.title = cell.cellLbl.text
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Mark:分享弹框
    private func creatActionSheetView() {
        let titleArr = ["微信朋友圈","微信好友","新浪微博","QQ空间"]
        let actionsheet = ActionSheetView.init(shareHeadOprationWith: titleArr, andImageArry: [], andProTitle: "", and: ShowTypeIsActionSheetStyle)

        actionsheet?.btnClick =  { (tag:Int) ->() in
            
            switch tag {
            case 0:
                print("新浪微博")
            case 1:
                print("微信朋友圈")
            case 2:
                print("QQ 好友")
            default:
                print("")
            }
        }
        UIApplication.shared.keyWindow?.addSubview(actionsheet!)
    }

}

