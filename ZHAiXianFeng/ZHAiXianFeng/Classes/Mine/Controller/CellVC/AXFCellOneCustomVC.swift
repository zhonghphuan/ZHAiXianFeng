//
//  AXFCellCustomVC.swift
//  SpuerYangAngWang
//
//  Created by 王嘉涛 on 2016/12/26.
//  Copyright © 2016年 杨茂盛. All rights reserved.
//

import UIKit
let addressCellID = "addressID"
class AXFCellOneCustomVC: AXFBaseCellVC {
    
    // 存放数据的数组
    var dataArr : [AXFAddressModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        creatAddressBtn()
        
        loadData()
        
        //监听通知
        NotificationCenter.default.addObserver(self, selector: #selector(remove(noti:)), name: NSNotification.Name("remove"), object: nil)
    }
    
    @objc private func remove(noti:Notification){
        
        let model = noti.object as! AXFAddressModel
        let index = dataArr?.index(of: model)
         dataArr?.remove(at: index!)
        tableView.reloadData()
    }
    

    private func loadData(){
        let url = "http://iosapi.itcast.cn/loveBeen/MyAdress.json.php"
        let call = ["call":12]
        
        NetworkingTools.shared.request(method:.POST, urlString: url, parameters: call) { (responds, error) in
            if error != nil{
                print("请求失败")
                return
            }
            
            let dict = responds as! [String : Any]?
            let data : [Any] = (dict!["data"] as! [Any]?)!
            var muArr = [AXFAddressModel]()
            for item in data
            {
                let model = AXFAddressModel()
                model.yy_modelSet(withJSON: item)
                muArr.append(model)
            }
            self.dataArr = muArr
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupUI() {
        self.tableView.rowHeight = 100
        self.tableView.register(UINib.init(nibName: "AXFAddressCell", bundle: nil), forCellReuseIdentifier: addressCellID)
    }
    
    private func creatAddressBtn() {
        
        let bottomView = UIView.init(frame: CGRect.init(x: 0, y: self.view.bounds.height-94, width: ScreenWidth, height: 50))
        bottomView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(bottomView)
        
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "v2_coupon_verify_normal"), for: .normal)
        btn.setImage(UIImage.init(named: "v2_coupon_verify_selected"), for: .highlighted)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
        bottomView.addSubview(btn)
        
        btn.snp.makeConstraints { (make) in
            make.center.equalTo(bottomView)
        }
        
        let lbl = UILabel(title: "+", textColor: .black, fontSize: 40)
        btn.addSubview(lbl)
        
        lbl.snp.makeConstraints { (make) in
            make.center.equalTo(btn)
        }
        
    }
    
    @objc private func clickBtn(){
        self.navigationController?.pushViewController(AXFEditVC(), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: addressCellID, for: indexPath) as! AXFAddressCell
        
        let model = self.dataArr![indexPath.row]
        cell.jumpClose = {
            
            let vc = AXFEditVC()
            self.navigationController?.pushViewController(vc, animated: true)
            vc.addressModel = model
            
        }
        
        cell.nameLbl.text = model.accept_name
        cell.phoneNumLbl.text = model.telphone
        cell.ressLbl.text = model.address
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
