//
//  Loading.swift
//  shof3qar
//
//  Created by karim saad on 4/20/18.
//  Copyright © 2018 karim saad. All rights reserved.
//

import UIKit
import Lottie
class LoadingMini: UIViewController {

    let animationView = AnimationView(name: "Mini")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        animationView.frame = CGRect(x: 0, y: 20, width:UIScreen.main.bounds.width - 40, height: 5)
        self.view.addSubview(animationView)
        animationView.loopMode = .loop
        animationView.play{ (finished) in
            
        }
        
        animationView.center = self.view.center
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
       animationView.center = self.view.center
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
