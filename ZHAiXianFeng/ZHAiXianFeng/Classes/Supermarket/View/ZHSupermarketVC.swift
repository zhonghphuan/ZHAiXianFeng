//
//  ZHSupermarketVC.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/22.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit
import SVProgressHUD
import MJRefresh
private  let categoryCellID = "CategoryCell"
private  let productCellID = "ProductCell"

class ZHSupermarketVC: ZHBaseVC {


    
     lazy var supermarketViewModel = ZHSupermarketViewModel()
    //懒加载左边TableView
     lazy var leftTableView:UITableView = {
        
        let leftTableView = UITableView(frame: CGRect.zero, style: .plain)
        leftTableView.separatorStyle = .none
        leftTableView.dataSource = self
        leftTableView.delegate = self
        leftTableView.rowHeight = 44
        leftTableView.showsVerticalScrollIndicator = false
        leftTableView.showsHorizontalScrollIndicator = false
        let cellNib = UINib(nibName: "ZHCategoriesCell", bundle: nil)
        leftTableView.register(cellNib, forCellReuseIdentifier: categoryCellID)
        return leftTableView
        
    }()
    
    //懒加载右边TableView
     lazy var rightTableView:UITableView = {
        
        let rightTableView = UITableView(frame: CGRect.zero, style: .plain)
        rightTableView.dataSource = self
        rightTableView.delegate = self
//        rightTableView.separatorStyle = .none
        rightTableView.rowHeight = 96
        rightTableView.showsVerticalScrollIndicator = false
        rightTableView.showsHorizontalScrollIndicator = false
        rightTableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        let cellNib = UINib(nibName: "ZHProductsCell", bundle: nil)
        rightTableView.register(cellNib, forCellReuseIdentifier: productCellID)
        return rightTableView
        
    }()
    
    var isClickLeftCell:Bool?
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.rightTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载数据
        loadData()
        //加载视图
        setupUI()
        
        //通知->监听购物车数据增加
        NotificationCenter.default.addObserver(self, selector: #selector(increase(noti:)), name: NSNotification.Name(rawValue: kSellFastIncreaseActionNotification), object: nil)
        //通知->监听购物车数据减少
        NotificationCenter.default.addObserver(self, selector: #selector(reduce(noti:)), name: NSNotification.Name(rawValue: kSellFastReduceActionNotification), object: nil)
        //通知->购物车数据变化需要刷新
        NotificationCenter.default.addObserver(self, selector: #selector(changed(noti:)), name: NSNotification.Name(rawValue: kShoppingCarChangedNotification), object: nil)
        //通知->动画
        NotificationCenter.default.addObserver(self, selector: #selector(animationImgView(noti:)), name: NSNotification.Name(rawValue: kAnimationNotification), object: nil)
    }
    
    @objc private func animationImgView(noti:Notification) {
        //获取图片
        let imgView = noti.userInfo?["img"] as! UIImageView
        //对图片动画
        addProductsAnimation(imgView)
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
    
    @objc private func changed(noti:Notification) {
      
        self.leftTableView.reloadData()
        self.rightTableView.reloadData()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    // MARK:- 加载UI
    func setupUI() {
        
        view.addSubview(leftTableView)
        view.addSubview(rightTableView)
        //添加约束
        leftTableView.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalTo(view)
            make.width.equalTo(ScreenWidth * 0.25)
        }
        
        rightTableView.snp.makeConstraints { (make) in
            make.trailing.top.bottom.equalTo(view)
            make.width.equalTo(ScreenWidth * 0.75)
        }
        //下拉刷新
        let refreshHeadView = RefreshHeader(refreshingTarget:self,refreshingAction:#selector(headRefresh))
        refreshHeadView?.gifView?.frame = CGRect(x: 0, y: 30, width: 100, height: 100)
        rightTableView.mj_header = refreshHeadView
        //上拉刷新
        rightTableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { () -> Void in
            print("MJ:(上拉加载)")
            self.rightTableView.mj_footer.endRefreshing()
        })
    }
    
    // MARK: 上拉刷新
    func headRefresh() {
        loadData()
        rightTableView.mj_header.endRefreshing()
    }
    // MARK:- 加载数据
    func loadData() {
        SVProgressHUD.show(withStatus: "正在刷新数据请稍等....")
        supermarketViewModel.loadSupermarketDate { (result) in
            if result == false {
                return
            }
            //请求成功刷新模型数据
            self.leftTableView.reloadData()
            self.rightTableView.reloadData()
        }
    }
}

extension ZHSupermarketVC:UITableViewDataSource,UITableViewDelegate {
    //多少组
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == leftTableView {
            return 1
        }else{
            return supermarketViewModel.arrayCategories.count
        }
    }
    //每组多少行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == leftTableView {
            return supermarketViewModel.arrayCategories.count
        }else{
            return supermarketViewModel.arrayCategories[section].productArray!.count
        }
    }
    //自定义cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == leftTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellID, for: indexPath) as! ZHCategoriesCell
            cell.categoriesModel = supermarketViewModel.arrayCategories[indexPath.row]
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: productCellID, for: indexPath) as!  ZHProductsCell
            
            cell.productsModel = supermarketViewModel.arrayCategories[indexPath.section].productArray![indexPath.row]
            for item in ZHShoppingCar.shared.shopCarModelArray {
                
                if item.product_id == supermarketViewModel.arrayCategories[indexPath.section].productArray! [indexPath.row].product_id {
                    cell.productsModel = item
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == leftTableView {
            isClickLeftCell = true
            let index  = IndexPath(row: 0, section: indexPath.row)
            rightTableView.scrollToRow(at: index, at: .top, animated: true)
        }else{
            isClickLeftCell = false
            let index  = IndexPath(row: indexPath.section, section: 0)
            leftTableView.selectRow(at: index, animated: true, scrollPosition: .top)
      
            
            let vc = ZHDetailVC()
            vc.detailModel = supermarketViewModel.arrayCategories[indexPath.section].productArray![indexPath.row]
            for item in ZHShoppingCar.shared.shopCarModelArray {
                if item.product_id == supermarketViewModel.arrayCategories[indexPath.section].productArray![indexPath.row].product_id {
                    vc.detailModel = item
                }
            }
            self.navigationController?.pushViewController(vc, animated: true)

        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if tableView == rightTableView {
            if isClickLeftCell == true {
                return
            }
            let indexArray = tableView.indexPathsForVisibleRows
            let cellPath = indexArray?.first
            let newIndexpath = IndexPath(row: (cellPath?.section)!, section: 0)
            leftTableView.selectRow(at: newIndexpath, animated: true, scrollPosition: .top)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == rightTableView {
            isClickLeftCell = false
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == rightTableView {
            return supermarketViewModel.arrayCategories[section].name
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView == rightTableView {
            let label = UILabel()
            label.text = "  " + "\(supermarketViewModel.arrayCategories[section].name!)"
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: 14)
            label.backgroundColor = UIColor(white: 0.92, alpha: 0.5)
            return label
        }else{
            return nil
        }
    }

    
}
