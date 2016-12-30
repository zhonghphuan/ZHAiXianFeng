//
//  ZHStatusDAL.swift
//  MySinaWeiBo
//
//  Created by ZH on 2016/11/27.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit

//设置多少秒之后过期
private let expires_date_timeIntravel: Double = -7 * 24 * 60 * 60

class ZHStatusDAL: NSObject {

    //检查本地是否有缓存数据
    
    class func checkoutStatus(sinceId: Int64,maxId: Int64) -> [[String : Any]]? {
//        
//        guard let userId = ZHUserAccountViewModel.shared.userAccount?.uid else {
//            
//            return nil
//        }
        
        //会将数据库中所有的缓存数据都查找到
//        var sql = "SELECT status FROM T_Status WHERE userId = \(userId) "
//
//        //如果sinceId > 0 标识需要查找新数据
//        if sinceId > 0 {
//            //向上查找
//            sql += "AND statusId > \(sinceId) "
//        }
//        
//        if maxId > 0 {
//            //向下查找
//            sql += "AND statusId < \(maxId) "
//        }
//        
//        //排序 降序
//        sql += "ORDER BY statusId DESC "
//        
//        //限制条数
//        sql += "LIMIT 20"
        
        //实例化数据
        var array = [[String : Any]]()
        
//        SQLiteTools.shared.queue.inDatabase { (db) in
//            guard let res = db!.executeQuery(sql, withArgumentsIn: nil) else {
//                //在闭包中不能够return
//                return
//            }
//            //逐条获取数据
//            while res.next() {
//                //获取status 二进制数据
//                let jsonData = res.data(forColumn: "status")
//                //转换为json 字典
//                let dict = try! JSONSerialization.jsonObject(with:jsonData!, options: [])
//                array.append(dict as! [String : Any])
//            }
//        }
        
        return array

    }


    //首页加载的数据的迁移
    class func loadHomeData(sinceId: Int64,maxId: Int64,finished: @escaping ([[String : Any]]?) -> ())  {
        
        let res = checkoutStatus(sinceId: sinceId, maxId: maxId)
        
        if let result = res, result.count > 0 {
            //有缓存数据  返回缓存数据
            //TODO: 待返回
            finished(result)
            return
        }
        //没有缓存数据, 请求网络数据
//        
//        let parameters = ["access_token" : ZHUserAccountViewModel.shared.access_token,
//                          "max_id":"\(maxId)",
//            "since_id":"\(sinceId)"]
        
//        NetworkingTools.shared.request(method: .GET, urlString: "https://api.weibo.com/2/statuses/home_timeline.json", parameters: parameters) { (responseObject, error) in
//            
//            if error != nil {
//                finished(nil)
//                return
//            }
//            
//            //成功
//            let dict = responseObject as! [String : Any]
//            
//            //尝试转换为字典类型的数组
//            guard let array = dict["statuses"] as? [[String : Any]] else {
//                finished(nil)
//                return
//            }
//
//            //回调的网络 请求的结果
//            finished(array)
//            
//            //存储到本地
//            cacheStauts(array: array)
//        }
    
    }
    
    
    //存储到本地
    class func cacheStauts(array: [[String : Any]]) {
        
        //获取userId
//        guard let userId = ZHUserAccountViewModel.shared.userAccount?.uid else {
//            print("用户没有登录呢")
//            return
//        }
        
         //如果在对应的主键下已经存在数据 就执行替换的操作
        let sql = "INSERT OR REPLACE INTO T_Status (statusId,status,userId) VALUES (?,?,?)"
        
        SQLiteTools.shared.queue.inTransaction { (db, rollback) in
            
//            for item in array {
//                let statusId = item["id"]!
//                //数据库中能够存储的数据不能够是Foundation 需要将字典数据转换二进制数据存储到数据库中
//                //如果是字典数据 在读取的时候会有问题
//                let jsonData = try! JSONSerialization.data(withJSONObject: item, options: [])
//                let res =  db!.executeUpdate(sql, withArgumentsIn: [statusId,jsonData,userId])
//                if !res {
//                    //不成功就执行回滚
//                    rollback?.pointee = true
//                    return
//                }
//            }
        }
    }
    
    //在什么时候清除 7天之前的微博
    class func clearCacheStatus() {
        //根据设置的过期描述 和当期日期 计算需要删除的微博记录
        let expires_date = Date(timeIntervalSinceNow: expires_date_timeIntravel)
        //yyyy-MM-dd HH:mm:ss
        let formater = DateFormatter()
        //设置本地化信息
        formater.locale = Locale(identifier: "en")
        //设置格式化符
        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //获取日期的字符串
        let dateStr = formater.string(from: expires_date)
        
        let sql = "DELETE FROM T_Status WHERE create_date < ?"
        //执行sql
        SQLiteTools.shared.queue.inTransaction { (db, rollback) in
            let res = db!.executeUpdate(sql, withArgumentsIn: [dateStr])
            if !res {
                //执行回滚
                rollback?.pointee = true
            }
        }
    }
}
