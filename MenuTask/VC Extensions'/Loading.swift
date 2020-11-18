//
//  Loading.swift
//  MenuTask
//
//  Created by MacBook Pro on 11/18/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import Foundation
import Lottie

// etension for showing / hiding the loading while making asynchronous requests
extension UIViewController {
    func addLoading() {
        let animationView = AnimationView(name: "Loading")
        animationView.tag = 333
        animationView.frame = CGRect(x: 0, y: 20, width: 200, height: 200)
        self.view.addSubview(animationView)
        animationView.loopMode = .loop
        animationView.play()
        animationView.center = self.view.center
        
    }
    func removeLoading() {
        self.view.subviews.forEach {
            if $0.tag == 333 {
                $0.removeFromSuperview()
            }
        }
    }
}
