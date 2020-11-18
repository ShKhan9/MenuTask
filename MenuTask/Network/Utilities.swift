//
//  Utilities.swift
//  Yachts
//
//  Created by AMIT IOS Developer on 3/11/18.
//  Copyright © 2018 com.AmitSoftware. All rights reserved.
//

import UIKit 
import SystemConfiguration
import AVKit
import AssetsLibrary
class Utilities {
    class func noNetwork() -> Bool  {
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
    class func showAlert(inVC:UIViewController? , message:String) {
        
        let alert = UIAlertController(title: nil , message: message , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title:NSLocalizedString("ok", comment: ""), style: .default, handler: nil))
        
        inVC?.present(alert, animated: true)
    }
}
