//
//  AXFOrderDetailVc.swift
//  SpuerYangAngWang
//
//  Created by 杨茂盛 on 2016/12/28.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit
import SnapKit
let orderStatusCellId = "orderStatusCellId"
let orderRightCellId = "orderRightCellId"
let orderConsigneeCellId = "orderConsigneeCellId"
let orderCostCellId = "orderCostCellId"
class AXFOrderDetailVc: AXFOrderVC {
    var detailModel : AXFMineOrderModel?
    lazy var leftTableView = UITableView.init(frame: .zero, style: .plain)
    lazy var rightTableView = UITableView.init(frame: .zero, style: .grouped)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUI()
    }
    //导航栏右边按钮
    func complain(){
        print("投诉")
    }
    override func setUI() {
        
        //添加 左边tableview
        self.view.addSubview(leftTableView)
        //添加先隐藏右边的tableview
        self.view.addSubview(rightTableView)
        
        
        
        //设置导航栏右边按钮
        
        let rightItem = UIBarButtonItem(title: "投诉",fontSize: 14, spacing: 0, target: self, action: #selector(complain))
        
        self.navigationItem.rightBarButtonItem = rightItem
        //因为是分段控制器  要给一个默认显示的视图 默认显示订单状态 先隐藏右边的
        self.rightTableView.isHidden = true
        
        
        //添加分段控制器
        let segmentVc = UISegmentedControl.init(items: ["订单状态","订单详情"])
        segmentVc.backgroundColor = #colorLiteral(red: 0.9300309634, green: 0.9915728109, blue: 0.9842287174, alpha: 1)
        segmentVc.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        self.navigationItem.titleView = segmentVc
        segmentVc.setWidth(70, forSegmentAt: 0)
        segmentVc.setWidth(70, forSegmentAt: 1)
        segmentVc.selectedSegmentIndex = 0
        //修改文字默认和高亮的文字颜色
        segmentVc.setTitleTextAttributes([NSForegroundColorAttributeName:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)], for: .normal)
        segmentVc.setTitleTextAttributes([NSForegroundColorAttributeName:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)], for: .selected)
        //添加监听方法
        segmentVc.addTarget(self, action: #selector(clickSegment(n:)), for: .valueChanged)
        
        
        
        
        let leftNibName = UINib.init(nibName: "AXFMineOrderDetailCell", bundle: nil)
        self.leftTableView.register(leftNibName, forCellReuseIdentifier: orderStatusCellId)
        self.leftTableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        leftTableView.dataSource = self
        leftTableView.delegate = self
        
        let rightNibName = UINib.init(nibName: "AXFMineOrderRightCell", bundle: nil)
        self.rightTableView.register(rightNibName, forCellReuseIdentifier: orderRightCellId)
        
        let orderConsigneeNib = UINib.init(nibName: "AXFMineOrderConsigneeCell", bundle: nil)
        self.rightTableView.register(orderConsigneeNib, forCellReuseIdentifier: orderConsigneeCellId)
        //orderCostCellId
        let orderCostNib = UINib.init(nibName: "AXFMineOrderCostCell", bundle: nil)
        self.rightTableView.register(orderCostNib, forCellReuseIdentifier: orderCostCellId)
        
        rightTableView.dataSource = self
        rightTableView.delegate = self
        
        
        
        leftTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        rightTableView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)
            make.size.equalTo(self.view)
        }
    }
    //segment 的监听
    func clickSegment(n:UISegmentedControl){
        self.leftTableView.isHidden = n.selectedSegmentIndex == 1
        self.rightTableView.isHidden = n.selectedSegmentIndex == 0
    }
    
    
    //MARK: 数据源方法
    override func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.leftTableView {
            return (detailModel?.status_timeline?.count)!
        }
        return 4
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.leftTableView {
            return 1
        }else{
            if section == 2 {
                return (detailModel?.order_goods?.count)!
            }
        }
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //左边 tableView
        
        if tableView == leftTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: orderStatusCellId, for: indexPath)  as! AXFMineOrderDetailCell
            cell.selectionStyle = .none
            cell.model = detailModel?.status_timeline?[indexPath.section]
            cell.separatorInset = UIEdgeInsetsMake(0, 90, 0, 0)
            cell.selectionStyle = .none
            return cell
        }
        
        if indexPath.section == 0 {
            let orderCell = tableView.dequeueReusableCell(withIdentifier: orderRightCellId, for: indexPath) as! AXFMineOrderRightCell
            orderCell.selectionStyle = .none
            return orderCell
        }
        if indexPath.section == 1 {
            let orderConsigneeCell = tableView.dequeueReusableCell(withIdentifier: orderConsigneeCellId, for: indexPath) as! AXFMineOrderConsigneeCell
            orderConsigneeCell.selectionStyle = .none
            return orderConsigneeCell
        }
        let orderCostCell = tableView.dequeueReusableCell(withIdentifier: orderCostCellId, for: indexPath) as! AXFMineOrderCostCell
        let model = detailModel?.order_goods?[indexPath.section]
//        orderCostCell.model = model?[indexPath.row]
        return orderCostCell
        
        
    }
    //MARK: 代理方法
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.leftTableView {
            return 90
        }
        
        if indexPath.section == 0{
            return 210
        }
        if indexPath.section == 1 {
            return 110
        }
        
        return 50
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
