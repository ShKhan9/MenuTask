//
//  ProductViewModel.swift
//  MenuTask
//
//  Created by MacBook Pro on 11/18/20.
//  Copyright © 2020 Foodics. All rights reserved.
//
 
import SwiftyJSON

class ProductViewModel: MainControllerS {
 
    weak var con: MainViewControllerS!
   
    func start(_ controller:MainViewControllerS,name:String,params:[String:Any]) {
        
        con = controller 
        
        let sent = "\(Links.products)\(name)"
        
        print(sent)
        
        super.Get(controller:controller, url:sent, parameters1: params, headers1: [:])
         
    }
     
    override func success(data: JSON) {
        
        guard let vc = con as? ProductVC else { return }
      
            do {
                
                let itemData = try data.rawData()

                let res = try JSONDecoder().decode(RootProduct.self, from: itemData)

                vc.success(res)
 
            }
            catch {
                
                print("EEEEEEE in decoding",error)
            }
    }
    
    override func fail(data: JSON) {
        
          print("Error dfjkjdfjkfdjkfdkj", data)
        
          guard let vc = con as? MenuVC else { return }
         
    }
    
}
    

 
