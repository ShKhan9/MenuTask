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
import SWRevealViewController

class MainViewControllerS: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
      
    
        setNeedsStatusBarAppearanceUpdate()
        if (self.revealViewController()) != nil
        {
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    
    func success(data:JSON){
        print("hello \(data)")
        
    }
    func fail(error:JSON){
        
    }
    
    func redirect(data:JSON){
        
    }
    
    func sendCurrentProgree(_ val:CGFloat){
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return UIStatusBarStyle.default
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func AddTopIcons(){
        
    }
    
}
