//
//  ZHShoppingCarVC.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/22.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit
private  let shoppingCarCellID = "ShoppingCarCell"
class ZHShoppingCarVC: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ZHShoppingCar.shared.shopCarModelArray.count)
        //加载导航栏
        setNav()
        //设置背景色
        self.view.backgroundColor = UIColor.white
        
        if ZHShoppingCar.shared.shopCarModelArray.count == 0 {
            let norMalView = AXFShopNormalView.init(frame: UIScreen.main.bounds)
            norMalView.backgroundColor = #colorLiteral(red: 0.9119085727, green: 0.9119085727, blue: 0.9119085727, alpha: 1)
            self.view.addSubview(norMalView)
            norMalView.shopNormalViewcoluse = {
                self.dismiss(animated: true, completion: nil)
            }
        }else{
            //添加tableView
            view.addSubview(tableView)
            tableView.tableHeaderView = ZHShopUserInfoView.userInfoView()
        }
  
       
    }
    
    /***********************************华丽的分割线**************************************/
    
    //懒加载TableView
    lazy var tableView:UITableView = {
        
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 44
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        
        let cellNib = UINib(nibName: "ZHShoppingCarCellIDCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: shoppingCarCellID)
        return tableView
        
    }()
    
    
    /***********************************华丽的分割线**************************************/
    
    //MARK: 设置导航栏
    func setNav(){
        
        self.title = "购物车"
        //设置左右导航栏的按钮
        let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spaceItem.width = -15
        //设置返回按钮
        let itemLeft = UIBarButtonItem(title: "", imageName: "v2_goback", fontSize: 14, spacing: 0, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItems = [spaceItem,itemLeft]
    
        //设置导航栏颜色
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.3881635274)
    }
    //点击返回的方法
    func back(){
        self.navigationController?.dismiss(animated: true, completion: nil)
        //发出通知,通知购物车数据变化,需要刷新界面数据
        NotificationCenter.default.post(name: NSNotification.Name(kShoppingCarChangedNotification), object: nil, userInfo: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension ZHShoppingCarVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ZHShoppingCar.shared.shopCarModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: shoppingCarCellID, for: indexPath) as! ZHShoppingCarCellIDCell
        cell.shoppingCarModel = ZHShoppingCar.shared.shopCarModelArray[indexPath.row]
        cell.closue = {
            self.tableView.reloadData()
            if ZHShoppingCar.shared.shopCarModelArray.count == 0 {
                tableView.removeFromSuperview()
                let norMalView = AXFShopNormalView.init(frame: UIScreen.main.bounds)
                norMalView.backgroundColor = #colorLiteral(red: 0.9119085727, green: 0.9119085727, blue: 0.9119085727, alpha: 1)
                self.view.addSubview(norMalView)
                norMalView.shopNormalViewcoluse = {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        return cell
    }
}
