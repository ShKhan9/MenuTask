//
//  PhoneDataVC.swift
//  AlacamDem
//
//  Created by Mac on 11/17/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginPhoneCon: MainControllerS {
 
    weak var con: MainViewControllerS!
   
    func regPhone(_ controller:MainViewControllerS,params:[String:Any]) {
        
        con = controller
        
        super.Post(controller:controller, url:Links.loginPhone, parameters1: params, headers1: [:])
        
        
    }
    
    
    override func success(data: JSON) {
        
        guard let vc = con as? LoginPhoneVC else { return }
      
        if let token = data["token"].string {
    
            do {
                
                let itemData = try data["item"].rawData()
                
                let user = try JSONDecoder().decode(User.self, from: itemData)
                
                print(user)
                
                UserDefaults.standard.set(token, forKey: "token")
                UserDefaults.standard.set(itemData, forKey: "user") 
                
                vc.success()
                
            }
            catch {
                
                print("EEEEEEE in decoding",error)
            }
        }
   
    }
    
    override func fail(data: JSON) {
        
          print("Error dfjkjdfjkfdjkfdkj", data)
        
          guard let vc = con as? LoginPhoneVC else { return }
        
        
        if  let message = data["errors"]["mobile"].array?.first?.string  {
            
            vc.phoneE(message)
            
        }
        
        if  let message = data["errors"]["password"].array?.first?.string  {
            
            vc.phoneE(message)
            
        }
        
        if  let message = data["message"].string  {
            
            vc.phoneE(message)
            
        }
     
    }
    
}
    

 

 
class LoginEmailCon: MainControllerS {
    
    weak var con: MainViewControllerS!
    
    func regEmail(_ controller:MainViewControllerS,params:[String:Any]) {
        
        con = controller
        
        super.Post(controller:controller, url:Links.loginPhone, parameters1: params, headers1: [:])
        
        
    }
    
    
    override func success(data: JSON) {
        
        guard let vc = con as? LoginMailVC else { return }
       
        if let token = data["token"].string {
            
            
            do {
                
                let itemData = try data["item"].rawData()
                
                let user = try JSONDecoder().decode(User.self, from: itemData)
                
                print(user)
                
                UserDefaults.standard.set(token, forKey: "token")
                UserDefaults.standard.set(itemData, forKey: "user")
                
                vc.success()
                

                
            }
            catch {
                
                print("EEEEEEE in decoding",error)
            }
        }
    }
    
   
    
    override func fail(data: JSON) {
        
        print("Error dfjkjdfjkfdjkfdkj", data)
        
        guard let vc = con as? LoginMailVC else { return }
      
        if  let message = data["errors"]["mobile"].array?.first?.string  {
            
            vc.phoneE(message)
            
        }
        
        if  let message = data["message"].string  {
            
            vc.phoneE(message)
            
        }
    }
}





