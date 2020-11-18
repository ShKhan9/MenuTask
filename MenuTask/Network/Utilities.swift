//
//  Utilities.swift
//  Yachts
//
//  Created by AMIT IOS Developer on 3/11/18.
//  Copyright © 2018 com.AmitSoftware. All rights reserved.
//

import UIKit
import SVProgressHUD
import SystemConfiguration
import AVKit
//import BAFluidView
//import Ophiuchus
import AssetsLibrary
class Utilities {
    
    
    class func showAlert(inVC:UIViewController? , message:String)
    {
        
        let alert = UIAlertController(title: nil , message: message , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title:NSLocalizedString("ok", comment: ""), style: .default, handler: nil))
        
        inVC?.present(alert, animated: true)
    }
    
    class func showAlertWithAc(inVC:UIViewController? , message:String,completion: @escaping ((UIAlertAction) -> ()))
    {
        
        let alert = UIAlertController(title: nil , message: message , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title:NSLocalizedString("ok", comment: ""), style: .default, handler: completion))
        
        inVC?.present(alert, animated: true)
    }
    class func showHud(vd:UIView)
    {
        let hover = UIView()
        
        hover.tag = 120
        
        hover.frame = vd.frame
        
        vd.addSubview(hover)
        
        SVProgressHUD.show()
        
    }
    class func hideHud(vd:UIView)
    {
        for v in vd.subviews
        {
            if(v.tag==120)
            {
                v.removeFromSuperview()
            }
        }
        
        SVProgressHUD.dismiss()
        
    }
    
    class func showAlertHome(message:String)
    {
        
        let alert = UIAlertController(title: nil , message: message , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title:NSLocalizedString("ok", comment: ""), style: .default, handler: nil))
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true)
    }
    /**
     ## adds hover view to main window when app requests data from server. ##
     
     - Parameter v: v is the parent view where hover view should be added.
     
     */
    
    class func addHoverView(v:UIView)
    {
        
        let hover = UIView()
        
        hover.tag = 120
        
        hover.frame = v.frame
        
        v.addSubview(hover)
        
        hover.center = v.center
        
        hover.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let act = UIActivityIndicatorView()
        
        act.center = hover.center
        
        hover.addSubview(act)
        
        act.startAnimating()
    }
    
    /**
     ## removes hover view from main window when app finishes getting the data. ##
     
     - Parameter v: v is the parent view where hover view should be removed.
     
     */
    
    class func removeHoverView(vd:UIView)
    {
        for v in vd.subviews
        {
            if(v.tag==120)
            {
                v.removeFromSuperview()
            }
        }
    }
    
  
  
//    class func showWater3(vd:UIView)
//    {
//
//        YALCustom.getMine(vd)
//
//    }
//
//
//    class func hideHud(vd:UIView)
//    {
//        for v in vd.subviews
//        {
//            if(v.tag==120)
//            {
//                v.removeFromSuperview()
//            }
//        }
//
//        SVProgressHUD.dismiss()
//
//    }
//
//    class func showHud(vd:UIView)
//    {
//
//        let all = UIView()
//
//        all.backgroundColor = UIColor.white.withAlphaComponent(0.0)
//
//        all.tag = 120
//
//        all.frame = vd.frame
//
//        vd.addSubview(all)
//
//
//        let lb = YALLabel.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 100))
//
//        lb.fillColor = UIColor.white
//
//        lb.backgroundFillColor = UIColor.init(red: 3.0/255.0, green: 173/255.0, blue: 240/255.0, alpha: 1)
//
//        lb.text = "Yachts"
//
//        lb.strokeWidth = 2
//
//        lb.strokeColor = UIColor.init(red: 3.0/255.0, green: 173/255.0, blue: 240/255.0, alpha: 1)
//
//
//        lb.fontName = "AlNile"
//
//        lb.fontSize = 50.0
//
//      //  lb.backgroundColor = UIColor.white.withAlphaComponent(0.0)
//
//        lb.sizeToFit()
//
//        all.addSubview(lb)
//
//        lb.center = all.center
//
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//
//            if lb != nil {
//                reunMore(lb:lb)
//            }
//
//        }
//
//
////        YALProgressAnimatingLayer *firstLetter = [self.yalLabel.fillLayer.sublayers firstObject];
////        CABasicAnimation *fillAnimation = [YALPathFillAnimation animationWithPath:fillLayer.mask.path andDirectionAngle:0];
////        fillAnimation.duration = 3.0;
////
////        [firstLetter.mask addAnimation:fillAnimation forKey:@"fillAnimation"];
//
//    }
//    class func reunMore(lb:YALLabel) {
//
//       let dispa = DispatchGroup()
//
//        if let sub = lb.fillLayer.sublayers {
//
//            for  ll in sub {
//
//                dispa.enter()
//
//                let firstLetter = ll
//
//                let anim1 = YALPathFillAnimation.init(path:lb.fillLayer.mask.path, andDirectionAngle: lb.tag == 0 ? 360 : 180)
//
//                anim1?.repeatCount = -1
//
//                anim1?.duration = 1.0
//
//                firstLetter.mask?.add(anim1!, forKey: "fillAnimation")
//
//                dispa.leave()
//            }
//        dispa.notify(queue: .main) {
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
//
//                if lb != nil {
//
//                     lb.tag = lb.tag == 0 ? 1 : 0
//                    reunMore(lb:lb)
//                }
//            }
//        }
//
//        }
//
//    }
//
//    class func showWater2(vd:UIView)
//    {
//
//        let all = UIView()
//
//        all.backgroundColor = UIColor.white.withAlphaComponent(0.0)
//
//        all.tag = 120
//
//        all.frame = vd.frame
//
//        vd.addSubview(all)
//
//        let hover = BAFluidView.init(frame:CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height/2 ))
//
//        hover.backgroundColor =  UIColor.white.withAlphaComponent(0.0)
//
//
//        hover.tag = 120
//
//        //  hover.frame = vd.frame
//
//        hover.keepStationary()
//
//        all.addSubview(hover)
//
//        //  hover.center = all.center
//
//        let lb = UILabel()
//
//        lb.text = "Yacht & Boat"
//
//        lb.font = UIFont.init(name:"AlNile", size: 35)
//
//        lb.backgroundColor = UIColor.white.withAlphaComponent(0.0)
//
//        lb.sizeToFit()
//
//        all.addSubview(lb)
//
//        lb.center = all.center
//
//        hover.frame = CGRect.init(x: ( vd.frame.size.width - lb.frame.size.width ) / 2 , y: 0, width: lb.frame.size.width , height: UIScreen.main.bounds.size.height/2 )
//
//        //hover.center = all.center
//
//
//    }
    
    class func validateEmail(_ enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    
    class func noNetwork() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)}
        } ) else {
            return false
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags)
        {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return !(isReachable && !needsConnection)
    }
    
    
    class func play( _ vc: UIViewController ,url : URL) {
        
        DispatchQueue.main.async {
            
            let vcd = AVPlayerViewController()
            
            vcd.videoGravity = .resizeAspect
            
            vcd.player = AVPlayer(url: url)
            
            vc.present(vcd, animated: true, completion: nil)
            
        }
        
    }
    
    class func saveToGallery(_ vc:UIViewController,url:URL){
        
        let library = ALAssetsLibrary()
        if library.videoAtPathIs(compatibleWithSavedPhotosAlbum: url) {
            library.writeVideoAtPath(toSavedPhotosAlbum: url,
              completionBlock: { (assetURL:URL!, error:Error!) -> Void in
                                        
                                        Utilities.showAlert(inVC: vc, message: "Saved")
                                        
            })
        }
        
        
        
    }
    
 

}

 
