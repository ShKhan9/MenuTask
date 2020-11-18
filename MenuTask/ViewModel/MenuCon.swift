//
//  MenuViewModel.swift
//  MenuTask
//
//  Created by MacBook Pro on 11/18/20.
//  Copyright © 2020 Foodics. All rights reserved.
//
 
import SwiftyJSON
import RealmSwift
class MenuViewModel: MainControllerS {
 
    weak var con: MainViewControllerS!
   
    func start(_ controller:MainViewControllerS,params:[String:Any]) {
        
        con = controller
        
        super.Get(controller:controller, url:Links.categories, parameters1: params, headers1: [:])
        
        
    }
    
    
    override func success(data: JSON) {
        
        guard let vc = con as? MenuVC else { return }
      
            do {
                
                let itemData = try data.rawData()

                let res = try JSONDecoder().decode(RootCategory.self, from: itemData)

                let realm = try! Realm()
                
                try! realm.write {
                    
                    realm.add(res)
                    
                }
                
                vc.success(res)
 
            }
            catch {
                
                print("EEEEEEE in decoding",error)
            }
    }
    
    override func fail(data: JSON) {
         
          guard let vc = con as? MenuVC else { return }
         
          vc.fail()
    }
    
}
    

 
