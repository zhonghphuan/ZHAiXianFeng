//
//  ZHSupermarketViewModel.swift
//  ZHAiXianFeng
//
//  Created by ZH on 2016/12/25.
//  Copyright © 2016年 ZH. All rights reserved.
//

import UIKit
import SVProgressHUD
class ZHSupermarketViewModel: NSObject {

    
    lazy var arrayCategories = [ZHCategoriesModel]()
    
    func loadSupermarketDate(finished:@escaping ((Bool) -> ())) {
        
        
        let parameters = ["call":5]
        NetworkingTools.shared.request(method: .POST, urlString: urlSupermarket, parameters: parameters) { (responseObject, error) in
            
            if error != nil {
                finished(false)
                return
            }
            guard let dict = responseObject as? [String : Any] else {finished(false);return}
            guard let dictData = dict["data"] as? [String : Any] else {finished(false);return}
            guard let arrayCategories = dictData["categories"] as? [[String : Any]]else {finished(false);return}
            guard let dictProducts = dictData["products"] as? [String : Any] else {finished(false);return}
            
     
            for item in arrayCategories{
                let arrayCategoriesModel = ZHCategoriesModel(dict: item)
                let key:String = item["id"] as! String
             
                
                guard let arrayP = dictProducts[key] as? [[String : Any]] else {return}
                var arrayProducts = [ZHSellFastModel]()
                for itemProducts in  arrayP {
                  
                    let arrayProductsModel = ZHSellFastModel(dict: itemProducts)
                    arrayProducts.append(arrayProductsModel)
                }
                arrayCategoriesModel.productArray = arrayProducts
                self.arrayCategories.append(arrayCategoriesModel)
            }
            
            
            SVProgressHUD.dismiss()
            finished(true)
        }
    }

}
