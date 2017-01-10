//
//  RefreshHeader.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/23.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit
import MJRefresh

class RefreshHeader: MJRefreshGifHeader {

    override func prepare() {
        super.prepare()
        stateLabel?.isHidden = false
        lastUpdatedTimeLabel?.isHidden = true
        
        setImages([UIImage(named: "v2_pullRefresh1")!], for: MJRefreshState.idle)
        setImages([UIImage(named: "v2_pullRefresh2")!], for: MJRefreshState.pulling)
        setImages([UIImage(named: "v2_pullRefresh1")!, UIImage(named: "v2_pullRefresh2")!], for: MJRefreshState.refreshing)
        
        setTitle("下拉刷新", for: .idle)
        setTitle("松手开始刷新", for: .pulling)
        setTitle("正在刷新······", for: .refreshing)
    }

}
