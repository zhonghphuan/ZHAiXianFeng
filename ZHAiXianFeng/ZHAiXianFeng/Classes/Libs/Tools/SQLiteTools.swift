//
//  SQLiteTools.swift
//  MySinaWeiBo
//
//  Created by ZH on 2016/11/27.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit
import FMDB

class SQLiteTools: NSObject {
    
    //使用单例
    static let shared: SQLiteTools = SQLiteTools()

    let queue: FMDatabaseQueue
    
    let bundleName = Bundle.main.infoDictionary!["CFBundleName"] as! NSString
    
    override init() {
        
        //数据库文件存储在沙盒路径中
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("\(bundleName).db")
        queue = FMDatabaseQueue(path: path)
        super.init()
        createTable()
    }
    
    private func createTable() {
        
        let filePath = Bundle.main.path(forResource: "ZHAiXianFeng.sql", ofType: nil)
        
        let sql = try! String.init(contentsOfFile: filePath!, encoding: .utf8)
        
        queue.inTransaction { (db, rollback) in
            
            let res = db!.executeStatements(sql)
            
            if res {
                print("建表成功")
            } else {
                print("失败")
                //执行回滚
                rollback?.pointee = true
            }
            
        }
    }
    
    func queryRecords(sql: String) -> [[String : Any]] {
        
        var arrayM = [[String : Any]]()
        
        queue.inDatabase { (db) in
            
            guard let res = db!.executeQuery(sql, withArgumentsIn: nil) else {
                return
            }
            
            while res.next() {
                
                var dictM = [String : Any]()
                
                //获取status 二进制数据
                
                var i: Int32 = 0
               
                while i < res.columnCount() {
                    
                    let keyName = res.columnName(for: i)
                    
                    let jsonData = res.data(forColumnIndex: i)
                 
                    dictM[keyName!] = jsonData
                    
                    i += 1
                }
                arrayM.append(dictM)
            }
        }
        return arrayM
    }
  
}
