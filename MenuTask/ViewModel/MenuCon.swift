//
//  MenuViewModel.swift
//  MenuTask
//
//  Created by MacBook Pro on 11/18/20.
//  Copyright © 2020 Foodics. All rights reserved.
//
 
import SwiftyJSON
import RealmSwift
class MenuViewModel {
 
    weak var con: MainViewControllerS!
   
    let dispatchG = DispatchGroup()
    
    var dataCateg:Data?
    
    var dataProduct:Data?
     
    func start(_ controller:MainViewControllerS,params:[String:Any]) {
        
        con = controller
       
        let realm = try! Realm()
    
        let value = realm.objects(RootCategory.self)
         
        if value.isEmpty {
             
            self.dispatchG.enter()
            
            MainControllerS.Get(controller:controller, url:Links.categories, parameters1: params, headers1: [:]) { data in
                
                self.dataCateg = data
                
                self.dispatchG.leave()
                
                
            }
            
            self.dispatchG.enter()
            
            MainControllerS.Get(controller:controller, url:Links.products, parameters1: params, headers1: [:]) { data in
                
                self.dataProduct = data
                
                self.dispatchG.leave()
                
            }
             
            self.dispatchG.notify(queue: .main) {
                
                if let cate = self.dataCateg , let prod = self.dataProduct {
                   
                    do {
                        
                        let resCate = try JSONDecoder().decode(RootCategory.self, from: cate)

                        let resProd = try JSONDecoder().decode(RootProduct.self, from: prod)
                        
                      //  print(resCate)
                        
                      //  print(resProd)
                        
                        resCate.data.forEach { (item:Category) in
                            
                            let res = resProd.data.filter { $0.id == item.id }
                            
                            let myList = List<ProductModel>()
                            
                            res.forEach { it in
                             
                                myList.append(it)
                            }
                            
                            print("hjdshhdhdshsdhjdhs ",myList.count)
                            
                            item.content = myList
                            
                        }
//
//                        let realm = try! Realm()
//
//                        try! realm.write {
//
//                            realm.add(resCate)
//
//                        }
                        
                        (self.con as! MenuVC).sendData(resCate)
                         
                    }
                    catch {
                        
                        
                        print(error)
                    }
                    
                }
                else {
                    
                    
                    
                }
                
            }
            
        }
        else {
            
            (con as! MenuVC).sendData(value.first!)
        }
              
    }
 
}
    

 
