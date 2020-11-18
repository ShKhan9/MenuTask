//
//  MainViewControllerS.swift
//  shof3qar
//
//  Created by karim saad on 4/15/18.
//  Copyright © 2018 karim saad. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
 

class MainViewControllerS: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func success(data:JSON){
        print("hello \(data)")
        
    }
    func fail(error:JSON){
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } 
}
