//
//  HJMyDiscountController.swift
//  AiXianFeng
//
//  Created by zhouxuanhe on 2016/12/27.
//  Copyright © 2016年 zhouxuanhe. All rights reserved.
//

import UIKit

private let myDiscountCellID = "myDiscountCellID"
class HJMyDiscountController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var arrContent = [HJMyDiscountModel]()
    var mineViewModel = HJMineViewModel()
    lazy var tableView: UITableView = {
        let tableView2 = UITableView()
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView2.rowHeight = 180
        tableView2.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        let nib = UINib(nibName: "HJMyDiscountCell", bundle: nil)
        tableView2.register(nib, forCellReuseIdentifier: myDiscountCellID)
        return tableView2
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "优惠券"

        let item = UIBarButtonItem(title: "发送", fontSize: 14, spacing: 0, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = item
        
        self.view.addSubview(tableView)
        tableView.frame = UIScreen.main.bounds

        setupTableView()
    }

    func setupTableView() {
        
        mineViewModel.loadData { (arr) in
            self.arrContent = arr
            self.tableView.reloadData()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.arrContent.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: myDiscountCellID, for: indexPath) as! HJMyDiscountCell
        
        cell.myDiscountModel = self.arrContent[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    

}




