//
//  ZHHomeVC.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/22.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit
import SnapKit
import SDCycleScrollView
import MJRefresh
import SVProgressHUD

private let cellViewID = "Cell"
private let cellViewID2 = "Cell2"
private let headerViewID = "headerView"
private let headerViewID2 = "headerView2"
private let footerViewID = "footerView"


class ZHHomeVC: ZHBaseVC{

    lazy var shoppingCarViewModel = ZHShoppingCar()
    //懒加载主页的ViewModel
    lazy var viewModel = ZHHomeViewModel()
    //遍历出来的轮播器图片数组
    var photosArray = [String]()
    //遍历出来的轮播器文字数组
    var titleArray = [String]()
    //懒加载轮播器
    lazy var cycleScrollView : SDCycleScrollView = {
        let cycleScrollView2 = SDCycleScrollView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: cycleScrollViewHeigth), delegate: self, placeholderImage: UIImage(named:"v2_placeholder_full_size"))
        cycleScrollView2?.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        cycleScrollView2?.pageDotColor = #colorLiteral(red: 0.9606288075, green: 0.7522723079, blue: 0.1814273894, alpha: 1)
        cycleScrollView2?.imageURLStringsGroup = self.photosArray
        cycleScrollView2?.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated
        cycleScrollView2?.pageControlDotSize = CGSize(width: 8, height: 8)
        return cycleScrollView2!
    }()
    
    //懒加载列表View
    lazy var iconView: ZHIconsView = {
        
        let iconView = ZHIconsView(frame: CGRect(x: 0, y: 160, width: ScreenWidth, height: iconViewHeigth))
        iconView.backgroundColor = UIColor.white
        
        return iconView
    }()
    
    //懒加载 collectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = HomeCollectionViewCellMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: HomeCollectionViewCellMargin, bottom: 0, right: HomeCollectionViewCellMargin)
        
        
        //设置collectionView头视图的大小
        layout.headerReferenceSize = CGSize(width: ScreenWidth, height: cycleScrollViewHeigth + iconViewHeigth)
        
        let collectionView = UICollectionView(frame:  CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64), collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = #colorLiteral(red: 0.9371759295, green: 0.937307179, blue: 0.9371344447, alpha: 1)
        //注册cell
        collectionView.register(ZHActivitiesCell.self, forCellWithReuseIdentifier: cellViewID)
        //注册cell2
        let nib = UINib(nibName: "ZHSellFastCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellViewID2)
        //注册头部视图1
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerViewID)
        //注册头部视图2
        collectionView.register(HomeCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerViewID2)
        //注册尾部视图
        collectionView.register(HomeCollectionFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerViewID)
        return collectionView
    }()
    
    /***********************************华丽的分割线**************************************/

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //加载头部数据
        loadHeadData()
        //加载底部数据
        loadFootData()
    
        //下拉刷新
        let refreshHeadView = RefreshHeader(refreshingTarget:self,refreshingAction:#selector(headRefresh))
        refreshHeadView?.gifView?.frame = CGRect(x: 0, y: 30, width: 100, height: 100)
        collectionView.mj_header = refreshHeadView
        view.addSubview(collectionView)
        //上拉刷新
        collectionView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { () -> Void in
            print("MJ:(上拉加载)")
           self.collectionView.mj_footer.endRefreshing()
        })
        
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
        if ZHShoppingCar.shared.shopCarModelArray.contains(model) == false {
            
            ZHShoppingCar.shared.shopCarModelArray.append(model)
        }
    }
    
    
    @objc private func reduce(noti:Notification) {
        let model = noti.object as! ZHSellFastModel
        //如果模型中count为0,表示减少直到产品删除了
        if (model.count)! == 0  && ZHShoppingCar.shared.shopCarModelArray.contains(model) == true {
            let index = ZHShoppingCar.shared.shopCarModelArray.index(of: model)
            ZHShoppingCar.shared.shopCarModelArray.remove(at: index!)
        }
    }
    
    @objc private func changed(noti:Notification) {
        self.collectionView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: 上拉刷新
    func headRefresh() {
        if viewModel.arrayActivities.count != 0 || viewModel.arrayFocus.count != 0 || viewModel.arrayicons.count != 0  {
            collectionView.mj_header.endRefreshing()
            return
        }
        //加载头部数据
        loadHeadData()
        //加载底部数据
        loadFootData()
        
        collectionView.mj_header.endRefreshing()
    }
    
    
    //跳转控制器
    
    func goWebViewVC(urlString: String) {
        let vc = ZHCustomWebVC()
        vc.urlString = urlString
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ZHHomeVC {
    // MARK:- 加载列表网络数据
    func loadHeadData() {
        viewModel.loadCarouselDate { result in
            
            if result == false {
                return
            }
            
            for item in self.viewModel.arrayFocus{
                self.photosArray.append(item.img!)
            }
            for item2 in self.viewModel.arrayFocus{
                self.titleArray.append(item2.name!)
            }
            self.cycleScrollView.imageURLStringsGroup = self.photosArray
            self.cycleScrollView.titlesGroup = self.titleArray
            self.iconView.iconsViewModel =  self.viewModel.arrayicons
            self.collectionView.reloadData()
        }
    }
    
    // MARK:- 加载热销模块数据
    func loadFootData() {
        viewModel.loadSellFastDate { result in
            if result == false {
                return
            }
            self.collectionView.reloadData()
        }
    }
}

extension ZHHomeVC : UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    
    //几组
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    //每组几行
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return viewModel.arrayActivities.count
        }else{
            return viewModel.arraySellFast.count
        }
    }
    
    //自定义cell
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewID, for: indexPath) as! ZHActivitiesCell
            cell.activitiesCellModel = viewModel.arrayActivities[indexPath.row]
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewID2, for: indexPath) as! ZHSellFastCell
            cell.sellFastCellModel = viewModel.arraySellFast[indexPath.row]
            
            for item in ZHShoppingCar.shared.shopCarModelArray {
                
                if item.product_id == viewModel.arraySellFast[indexPath.row].product_id {
                    cell.sellFastCellModel = item
                }
            }
            
            return cell
        }
    }
    
    //返回每组cell的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemSize = CGSize.zero
        if indexPath.section == 0 {
             itemSize = CGSize(width: ScreenWidth - HomeCollectionViewCellMargin * 2, height: 140)
        }else if indexPath.section == 1 {
            
            itemSize = CGSize(width: (ScreenWidth - HomeCollectionViewCellMargin * 3) * 0.5 , height: 250)
        }
        return itemSize
    }
    
    //返回每组头部视图大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: ScreenWidth, height: cycleScrollViewHeigth + iconViewHeigth)
        } else if section == 1 {
            return CGSize(width: ScreenWidth, height: CollectionHeaderViewHeigth + HomeCollectionViewCellMargin)
        }
        return CGSize.zero
    }
    //返回每组尾部部视图大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: ScreenWidth, height: HomeCollectionViewCellMargin)
        } else if section == 1 {
            return CGSize(width: ScreenWidth, height: CollectionFooterViewHeigth + HomeCollectionViewCellMargin)
        }
        return CGSize.zero
    }
    
    //动画
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let indexs = collectionView.indexPathsForVisibleItems
        //如果可见的第一个cell >= 当前屏幕上将要显示的cell 则 return
        //也即只有底部将要出现的cell才允许动画
        guard let indexfirstitem =  indexs.first?.item else {
            return
        }
        
        guard let indexfirstsection =  indexs.first?.section else {
            return
        }

        
        if indexPath.section == 0 && (indexPath.item == 0 || indexPath.item == 1 )  {
            return
        }
        
        if  indexfirstitem > indexPath.item  {
            return
        }
        if  indexfirstsection > indexPath.section  {
            return
        }
        
        cell.transform = CGAffineTransform(translationX: 0, y: 60)
        UIView.animate(withDuration: 0.7) {
            cell.transform = CGAffineTransform.identity
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if indexPath.section == 1  {
            view.transform = CGAffineTransform(translationX: 0, y: 60)
            UIView.animate(withDuration: 0.7) {
                view.transform = CGAffineTransform.identity
            }
        }
    }
    
    
    //给collectionView添加头部视图或尾部视图
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         //如果是第0组头部视图 -----> 这里是加载轮播器和列表视图
        if indexPath.section == 0 && kind == UICollectionElementKindSectionHeader {
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewID, for: indexPath)
            self.iconView.customclosure = { index in
                let urlString = self.viewModel.arrayicons[index].customURL
                self.goWebViewVC(urlString: urlString!)
            }
            headView.addSubview(iconView)
            headView.addSubview(cycleScrollView)
            return headView
        }
        
        //如果是第1组头部视图
        if indexPath.section == 1 && kind == UICollectionElementKindSectionHeader {
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewID2, for: indexPath) as! HomeCollectionHeaderView
            return headView
        }
        
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerViewID, for: indexPath) as! HomeCollectionFooterView
        
        if indexPath.section == 1 && kind == UICollectionElementKindSectionFooter {
            footerView.showLabel()
            footerView.tag = 100
            footerView.taplabel = {

                self.tabBarController?.selectedIndex = 1
            }
        } else {
            footerView.hideLabel()
            footerView.tag = 1
        }
        return footerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let urlString = viewModel.arrayActivities[indexPath.item].customURL
            self.goWebViewVC(urlString: urlString!)
        }else{
            
            let vc = ZHDetailVC()
            
            vc.detailModel = viewModel.arraySellFast[indexPath.row]
            for item in ZHShoppingCar.shared.shopCarModelArray {
                if item.product_id == viewModel.arraySellFast[indexPath.row].product_id {
                    vc.detailModel = item
                }
            }
            
           
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//轮播器回调
extension ZHHomeVC:SDCycleScrollViewDelegate {
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        let urlString =  viewModel.arrayFocus[index].toURL
        self.goWebViewVC(urlString: urlString!)
    }
}
