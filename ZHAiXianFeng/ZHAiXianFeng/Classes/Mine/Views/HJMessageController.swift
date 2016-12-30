//
//  HJMessageController.swift
//  AiXianFeng
//
//  Created by zhouxuanhe on 2016/12/28.
//  Copyright © 2016年 zhouxuanhe. All rights reserved.
//

import UIKit

class HJMessageController: UITableViewController {
    
    lazy var imageView: UIImageView = {
        let imgV = UIImageView()
        imgV.image = UIImage(named: "zhou")
        return imgV
    }()

    var arrName = ["订单状态","用户消息"]
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        self.view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height:ScreenHeight)
        
        
        let segM = UISegmentedControl(items: arrName)
        segM.frame = CGRect(x: 0, y: 0, width: 160, height: 40)
        self.navigationController?.navigationItem.titleView = segM
        segM.selectedSegmentIndex = 0
        segM.setBackgroundImage(UIImage(named: "v2_coupon_verify_normal"), for: UIControlState.highlighted, barMetrics: UIBarMetrics.default)

        
        segM.addTarget(self, action: #selector(segmentValueDidChanged(sender:)), for: UIControlEvents.valueChanged)
    }
    
    func segmentValueDidChanged(sender:UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.imageView.image = UIImage(named: "zhou")
        }else {
            self.imageView.image = UIImage(named: "zhou1")

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
