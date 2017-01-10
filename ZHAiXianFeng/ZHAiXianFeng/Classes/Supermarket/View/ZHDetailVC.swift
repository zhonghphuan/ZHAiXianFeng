//
//  ZHDetailVC.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/27.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

private let detailCellID = "detailCellID"
class ZHDetailVC: UIViewController {
    
    var detailModel:ZHSellFastModel? 

    //懒加载tableView
    lazy var tableView:UITableView = {
        
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 360
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        let cellNib = UINib(nibName: "ZHDetailCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: detailCellID)
        
        return tableView
        
    }()
    
    //懒加载shoppingCarView
    lazy var shoppingCarView:ZHDetailShoppingCar = {
        
        let shoppingCarView = ZHDetailShoppingCar.detailShoppingCar()
        shoppingCarView.frame = CGRect(x: 0, y: ScreenHeight - 107, width: ScreenWidth, height: 107)
       
        return shoppingCarView
        
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        self.title = detailModel?.name
        let headimgView = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 360))
        guard let url = URL(string: (detailModel?.img)!) else {return}
        headimgView.sd_setImage(with: url, placeholderImage: UIImage(named: "v2_placeholder_square"))
        headimgView.sizeToFit()
        tableView.tableHeaderView = headimgView
        let footerimgView = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 1665))
        footerimgView.image = UIImage(named: "aaaa")
        headimgView.sizeToFit()
        tableView.tableFooterView = footerimgView
        
        view.addSubview(tableView)
        view.addSubview(shoppingCarView)
   
        shoppingCarView.detailModel = detailModel
        
        //通知->监听购物车数据增加
        NotificationCenter.default.addObserver(self, selector: #selector(increase(noti:)), name: NSNotification.Name(rawValue: kSellFastIncreaseActionNotification), object: nil)
        //通知->监听购物车数据减少
        NotificationCenter.default.addObserver(self, selector: #selector(reduce(noti:)), name: NSNotification.Name(rawValue: kSellFastReduceActionNotification), object: nil)
    }
    
    @objc private func increase(noti:Notification) {
        //获取出通知中要传入到购物车的模型
        let model = noti.object as! ZHSellFastModel
        //将模型数据添加到购物车中,如果不包含该模型,则加入购物车
        if ZHShoppingCar.shared.shopCarModelArray.contains(model) == false  {
            ZHShoppingCar.shared.shopCarModelArray.append(model)
        }

    }
    
    @objc private func reduce(noti:Notification) {
        let model = noti.object as! ZHSellFastModel
        //如果模型中count为0,表示减少直到产品删除了
        if (model.count)! == 0 && ZHShoppingCar.shared.shopCarModelArray.contains(model) == true{
            let index = ZHShoppingCar.shared.shopCarModelArray.index(of: model)
            ZHShoppingCar.shared.shopCarModelArray.remove(at: index!)
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    //MARK: 设置导航栏
    func setNav(){
        //设置左右导航栏的按钮
        let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        spaceItem.width = -15
        //设置返回按钮
        let itemLeft = UIBarButtonItem(title: "", imageName: "v2_goback", fontSize: 14, spacing: 0, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItems = [spaceItem,itemLeft]
        let itemRight  = UIBarButtonItem(title: "分享", fontSize: 14, spacing: 0, target: self, action: #selector(shared))
        self.navigationItem.rightBarButtonItem = itemRight
        //设置导航栏颜色
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.3881635274)
    }
    //点击返回的方法
    func back(){
        self.navigationController!.popViewController(animated: true)
    }
    //MARK: 点击分享的方法
    func shared(){
        
        let titlearr = ["新浪微博","微信朋友圈","QQ 好友"]
        let imageArr = ["sinaweibo","wechat","tcentQQ"]
        let actionsheet = ActionSheetView.init(shareHeadOprationWith: titlearr, andImageArry: imageArr, andProTitle: "测试", and:ShowTypeIsShareStyle)
        
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

extension ZHDetailVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: detailCellID, for: indexPath) as! ZHDetailCell
        cell.detailModel = detailModel
        for item in ZHShoppingCar.shared.shopCarModelArray {
            if item.product_id == detailModel?.product_id {
                cell.detailModel = item
            }
        }
        return cell
    }
    
}
