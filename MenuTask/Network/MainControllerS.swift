//
//  MainControllerS.swift
//  suqiakum
//
//  Created by karim saad on 1/19/18.
//  Copyright © 2018 karim saad. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG
var shouldComplete = false


class MainControllerS : NSObject {
    
    var container:UIView!
    
    func Get(controller:MainViewControllerS,url:String,parameters1:Parameters,headers1:HTTPHeaders,showLoading:Bool = true,inAppDelegate:Bool = false,showMini:Bool = false,showMiniUp:Bool = false){
        // check internet Connection
        if Utilities.noNetwork() {
            Utilities.showAlert(inVC: controller, message:NSLocalizedString("noInternet", comment: ""))
            return
        }
        print(headers1 , "<< sended header")
        print(parameters1, "<< sended parameters")
        // show loading if needed
        if showLoading {
            
            if inAppDelegate {
                
                OpenLoadingWindow()
            }
            else if showMini {
                
                OpenMiniLoading(view1: controller)
            }
            else if showMiniUp {
                
                OpenMiniLoading(view1: controller)
            }
            else {
                
                OpenLoading(view1: controller)
                
            }
        }
        
        clearTeninContent()
        
        // get static headers
        let head = Header().getHeader(old: headers1)
        // start request
        Alamofire.request(url,method:.get,parameters:parameters1,headers:head).responseJSON { (response ) in
            // validate response
          
            guard response.result.value != nil else  { return }
            let responseValue = JSON(response.result.value!)
            if let responseStatus = responseValue["code"].int {

                print("GET REQUEST STATUSCODE --> ",response.response?.statusCode ?? 0 ,response.error ?? "" , "REQUEST URL :  ",url, " STATUSCODE : ",responseStatus )
                
            }
            // hide loading if needed
            if showLoading {

                if inAppDelegate {
                    self.CloseLoadingWindow()
                }else{
                    self.CloseLoading()
                }
                
            }
            // handle response
            switch response.response?.statusCode {
            case 200 :
                if response.result.value != nil{
                    print("success")
                    print(response.result.value!)
                    self.showTutorial(JSON(response.result.value!))
                    self.success(data: JSON(response.result.value!))
                }
                break
            case 400 :
                if response.result.value != nil{
                    print("fail in logic")
                    print(response.result.value!)
                    self.fail(data: JSON(response.result.value!))
                }
                break
            case 404 :
                if response.result.value != nil{
                    print("fail in logic")
                    print(response.result.value!)
                    self.fail(data: JSON(response.result.value!))
                }
                break
            case 401 :
                if response.result.value != nil{
                    let dd = JSON(response.result.value!)
                    if let code = dd["code"].int , code == 2001 {
                        // complete data
                        self.redirect(data: JSON(response.result.value!))
                    }else {
                        self.goToLogin()
                    }
                }
                break
            case 302 :
                self.reToken(method: .get , controller:controller,url:url,parameters1:parameters1,headers1:headers1,showLoading:showLoading,inAppDelegate:inAppDelegate,showMini:showMini,showMiniUp: false,images:nil,video:nil)
                break
            case 500 :
                self.showGeneral(data:response.response!.statusCode)
                break
            default: break
            }
        }
    }
    
    func showTutorial(_ data:JSON) {
        
        guard tutState == .none else { return }
        
        if let item = data["video_event"].dictionary , let pos = item["position"]?.int , let url = item["full_url"]?.string {
            
            let wind = (UIApplication.shared.delegate as! AppDelegate).window!
            
            wind.addTransVideo2(pos, remoteUrl:url)
             
       }
        
    }
     
    func Post(controller:MainViewControllerS,url:String,parameters1:Parameters,headers1:HTTPHeaders,showLoading:Bool = true,inAppDelegate:Bool = false,showMini:Bool = false){
        // check internet Connection
        if Utilities.noNetwork() {
            Utilities.showAlert(inVC: controller, message:NSLocalizedString("noInternet", comment: ""))
            return
        }
        print(headers1, "<< sended header")
        print(parameters1, "<< sended parameters")
        // show loading if needed
        if showLoading {
            
            if inAppDelegate {
                
                OpenLoadingWindow()
            }
            else if showMini {
                
                OpenMiniLoading(view1: controller)
            }
            else {
                
                OpenLoading(view1: controller)
                
            }
        }
        // get static headers
        
        
        clearTeninContent()
        
        
        let head = Header().getHeader(old: headers1)
        print(head, "<< sended static header")
       // start request
        Alamofire.request(url,method:.post,parameters:parameters1,encoding:JSONEncoding.default,headers:head).responseJSON { (response:DataResponse<Any>) in
            // validate response
            guard response.result.value != nil else  { return }
            let responseValue = JSON(response.result.value!)
            if let responseStatus = responseValue["code"].int {
                
                print("POST REQUEST STATUSCODE --> ",response.response?.statusCode ?? 0 ,response.error ?? "" , "REQUEST URL :  ",url, " STATUSCODE : ",responseStatus )
                
            }
            // hide loading if needed
            if showLoading {
                self.CloseLoading()
            }
              
            // handle response
            switch response.response?.statusCode {
            case 200 :
                if response.result.value != nil{
                    print("success")
                    print(response.result.value!)
                    self.showTutorial(JSON(response.result.value!))
                    self.success(data: JSON(response.result.value!))
                }
                break
            case 400 :
                if response.result.value != nil{
                    print("fail in logic")
                    print(response.result.value!)
                    self.fail(data: JSON(response.result.value!))
                }
                break
            case 401 :
                if response.result.value != nil{
                    let dd = JSON(response.result.value!)
                    if let code = dd["code"].int , code == 2001 {
                        // complete data
                        self.redirect(data: JSON(response.result.value!))
                    }else{
                        self.goToLogin()
                    }
                }
                break
            case 302 :
                if response.result.value != nil{
                    let dd = JSON(response.result.value!)
                    if let code = dd["code"].int , code == 2005 {
                        // complete data
                        self.redirect(data: JSON(response.result.value!))
                    }else{
                        self.reToken(method: .post , controller:controller,url:url,parameters1:parameters1,headers1:headers1,showLoading:showLoading,inAppDelegate:inAppDelegate,showMini:showMini,showMiniUp: false,images:nil,video:nil)
                    }
                }
                break
            case 500 :
                self.showGeneral(data:response.response!.statusCode)
                break
            default: break
            }
        }
    }
    
    func PostArray(controller:MainViewControllerS,url:String,parameters1:[Parameters],headers1:HTTPHeaders,showLoading:Bool = true){
        // check internet Connection
        if Utilities.noNetwork() {
            Utilities.showAlert(inVC: controller, message:NSLocalizedString("noInternet", comment: ""))
            return
        }
        print(headers1, "<< sended header")
        print(parameters1, "<< sended parameters")
        // show loading if needed
        if showLoading {
            OpenLoading(view1: controller)
        }
        // get static headers
        let head = Header().getHeader(old: headers1)
        // setup request
        var request = URLRequest(url:URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = head
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters1)
        // start request
        Alamofire.request(request).responseJSON { (response:DataResponse<Any>) in
            // validate response
            guard response.result.value != nil else  { return }
            let responseValue = JSON(response.result.value!)
            if let responseStatus = responseValue["code"].int {
                
                print("POST REQUEST STATUSCODE --> ",response.response?.statusCode ?? 0 ,response.error ?? "" , "REQUEST URL :  ",url, " STATUSCODE : ",responseStatus )
                
            }
            // hide loading if needed
            if showLoading {
                self.CloseLoading()
            }
            // handle response
            switch response.response?.statusCode {
            case 200 :
                if response.result.value != nil{
                    print("success")
                    print(response.result.value!)
                    self.success(data: JSON(response.result.value!))
                }
                break
            case 400 :
                if response.result.value != nil{
                    print("fail in logic")
                    print(response.result.value!)
                    self.fail(data: JSON(response.result.value!))
                }
                break
            case 401 :
                if response.result.value != nil{
                    let dd = JSON(response.result.value!)
                    if let code = dd["code"].int , code == 2001 {
                        // complete data
                        self.redirect(data: JSON(response.result.value!))
                    }else {
                        self.goToLogin()
                    }
                }
                break
            case 302 :
                break
            case 500 :
                self.showGeneral(data:response.response!.statusCode)
                break
            default: break
            }
            
        }
    }
    
    
    func Put(controller:MainViewControllerS,url:String,parameters1:Parameters,headers1:HTTPHeaders,showLoading:Bool = true){
        // check internet Connection
        if Utilities.noNetwork() {
            Utilities.showAlert(inVC: controller, message:NSLocalizedString("noInternet", comment: ""))
            return
        }
        print(headers1, "<< sended header")
        print(parameters1, "<< sended parameters")
        // show loading if needed
        if showLoading {
            OpenLoading(view1: controller)
        }
        // get static headers
        let head = Header().getHeader(old: headers1)
        // start request
        Alamofire.request(url,method:.put,parameters:parameters1,encoding:JSONEncoding.default,headers:head).responseJSON { (response:DataResponse<Any>) in
            // validate response
            guard response.result.value != nil else  { return }
            let responseValue = JSON(response.result.value!)
            if let responseStatus = responseValue["code"].int {
                
                print("PUT REQUEST STATUSCODE --> ",response.response?.statusCode ?? 0 ,response.error ?? "" , "REQUEST URL :  ",url, " STATUSCODE : ",responseStatus )
                
            }
            // hide loading if needed
            if showLoading {
                self.CloseLoading()
            }
            // handle response
            switch response.response?.statusCode {
            case 200 :
                if response.result.value != nil{
                    print("success")
                    print(response.result.value!)
                    self.success(data: JSON(response.result.value!))
                }
                break
            case 400 :
                if response.result.value != nil{
                    print("fail in logic")
                    print(response.result.value!)
                    self.fail(data: JSON(response.result.value!))
                }
                break
            case 401 :
                if response.result.value != nil{
                    let dd = JSON(response.result.value!)
                    if let code = dd["code"].int , code == 2001 {
                        // complete data
                        self.redirect(data: JSON(response.result.value!))
                    }else {
                        self.goToLogin()
                    }
                }
                break
            case 302 :
                self.reToken(method: .put , controller:controller,url:url,parameters1:parameters1,headers1:headers1,showLoading:showLoading,inAppDelegate:false,showMini:false,showMiniUp: false,images:nil,video:nil)
                break
            case 500 :
                self.showGeneral(data:response.response!.statusCode)
                break
            default: break
            }
            
        }
    }
    func Patch(controller:MainViewControllerS,url:String,parameters1:Parameters,headers1:HTTPHeaders,showLoading:Bool = true){
        // check internet Connection
        if Utilities.noNetwork() {
            Utilities.showAlert(inVC: controller, message:NSLocalizedString("noInternet", comment: ""))
            return
        }
        print(headers1, "<< sended header")
        print(parameters1, "<< sended parameters")
        // show loading if needed
        if showLoading {
            OpenLoading(view1: controller)
        }
        // get static headers
        let head = Header().getHeader(old: headers1)
        // start request
        Alamofire.request(url,method:.patch,parameters:parameters1,headers:head).responseJSON { (response:DataResponse<Any>) in
            // validate response
            guard response.result.value != nil else  { return }
            let responseValue = JSON(response.result.value!)
            if let responseStatus = responseValue["code"].int {
                
                print("PATCH REQUEST STATUSCODE --> ",response.response?.statusCode ?? 0 ,response.error ?? "" , "REQUEST URL :  ",url, " STATUSCODE : ",responseStatus )
                
            }
            // hide loading if needed
            if showLoading {
                self.CloseLoading()
            }
            // handle response
            switch response.response?.statusCode {
            case 200 :
                if response.result.value != nil{
                    print("success")
                    print(response.result.value!)
                    self.success(data: JSON(response.result.value!))
                }
                break
            case 400 :
                if response.result.value != nil{
                    print("fail in logic")
                    print(response.result.value!)
                    self.fail(data: JSON(response.result.value!))
                }
                break
            case 401 :
                if response.result.value != nil{
                    let dd = JSON(response.result.value!)
                    if let code = dd["code"].int , code == 2001 {
                        // complete data
                        self.redirect(data: JSON(response.result.value!))
                    }else {
                        self.goToLogin()
                    }
                }
                break
            case 302 :
                //  self.redirect(data: JSON(response.result.value!))
                self.reToken(method: .patch, controller: controller, url: url, parameters1: parameters1, headers1: headers1, images: nil, video: nil)
                break
            case 500 :
                self.showGeneral(data:response.response!.statusCode)
                break
            default: break
            }

        }
    }
    
    func uploadImageAndData(controller:MainViewControllerS,url:String,parameters1:Parameters,headers1:HTTPHeaders,images:[UIImage],showLoading:Bool = true){
        // check internet Connection
        if Utilities.noNetwork() {
            Utilities.showAlert(inVC: controller, message:NSLocalizedString("noInternet", comment: ""))
            return
        }
        print(headers1, "<< sended header")
        print(parameters1, "<< sended parameters")
        // show loading if needed
        if showLoading {
            OpenLoading(view1: controller)
        }
        // get static headers
        let head = Header().getHeader(old: headers1)
        // start request
        Alamofire.upload(multipartFormData: { multipartFormData in
            // import image to request
            var i=0
            for imageData in images {
                //  multipartFormData.append(self.resizeImage(image: imageData, targetSize: CGSize(width: 400, height:
                multipartFormData.append(imageData.pngData()!, withName: "image", fileName: "image"+".jpeg", mimeType: "image/jpeg")
                i += 1
            }
            for (key, value) in parameters1 {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        } ,to: url,method:.post,
           headers:head,
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                upload.responseJSON { response in
                    print(JSON(response.result.value!))
                    // hide loading if needed
                    if showLoading {
                        self.CloseLoading()
                    }
                    // handle response
                    switch response.response?.statusCode {
                    case 200 :
                        if response.result.value != nil{
                            print("success")
                            print(response.result.value!)
                            self.success(data: JSON(response.result.value!))
                        }
                        break
                    case 400 :
                        if response.result.value != nil{
                            print("fail in logic")
                            print(response.result.value!)
                            self.fail(data: JSON(response.result.value!))
                        }
                        break
                    case 401 :
                        if response.result.value != nil{
                            let dd = JSON(response.result.value!)
                            if let code = dd["code"].int , code == 2001 {
                                // complete data
                                self.redirect(data: JSON(response.result.value!))
                            }else {
                                self.goToLogin()
                            }
                        }
                        break
                    case 302 :
                        self.reToken(method: .delete, controller: controller, url: url, parameters1: parameters1, headers1: headers1, showLoading: showLoading,images: images, video: nil)
                        break
                    case 500 :
                        self.showGeneral(data:response.response!.statusCode)
                        break
                    default: break
                    }
                }
                return
            case .failure(let encodingError):
                print("failed while upload \(encodingError)")
                // hide loading if needed
                if showLoading {
                    self.CloseLoading()
                }
            }
            
        })
    }
    
    func completeData() {
        
        if let nav =   (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController {
            
            print(nav)
            
        }
        
        
    }
    
    func uploadVideoAndImage(controller:MainViewControllerS,url:String,parameters1:Parameters,headers1:HTTPHeaders,images:[UIImage],video:URL,showLoading:Bool = true){
        // check internet Connection
        if Utilities.noNetwork() {
            Utilities.showAlert(inVC: controller, message:NSLocalizedString("noInternet", comment: ""))
            return
        }
        print(headers1, "<< sended header")
        print(parameters1, "<< sended parameters")
        // show loading if needed
        if showLoading {
            OpenLoading(view1: controller)
        }
        // get static headers
        let head = Header().getHeader(old: headers1)
        // start request
        Alamofire.upload(multipartFormData: { multipartFormData in
            // import image to request
         //   var i=0
          //  for imageData in images {
                //  multipartFormData.append(self.resizeImage(image: imageData, targetSize: CGSize(width: 400, height:
             //   multipartFormData.append(imageData.jpegData(compressionQuality: 0.5)!, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
                
                multipartFormData.append(video, withName: "url", fileName: "video.mp4", mimeType: "video/mp4")
                
               // i += 1
           // }
            for (key, value) in parameters1 {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        } ,to: url,method:.post,
           headers:head,
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                    self.sendProgress(CGFloat(Progress.fractionCompleted))
                })
                upload.responseJSON { response in
                    guard let fg = response.result.value else { return }
                //    print(JSON(fg))
                    // hide loading if needed
                    if showLoading {
                        self.CloseLoading()
                    }
                    // handle response
                    switch response.response?.statusCode {
                    case 200 :
                        if response.result.value != nil{
                            print("success")
                            print(response.result.value!)
                            //self.success(data: JSON(response.result.value!))
                        }
                        break
                    case 400 :
                        if response.result.value != nil{
                            print("fail in logic")
                            print(response.result.value!)
                            self.fail(data: JSON(response.result.value!))
                        }
                        break
                    case 401 :
                        if response.result.value != nil{
                            let dd = JSON(response.result.value!)
                            if let code = dd["code"].int , code == 2001 {
                                // complete data
                            }else {
                                self.goToLogin()
                            }
                        }
                        break
                    case 302 :
                        self.redirect(data: JSON(response.result.value!))
                        break
                    case 500 :
                        self.showGeneral(data:response.response!.statusCode)
                        break
                    default: break
                    }
                    
                    
                }
                return
            case .failure(let encodingError):
                print("failed while upload \(encodingError)")
                // hide loading if needed
                if showLoading {
                    self.CloseLoading()
                }
            }
            
        })
    }
    
    
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.width * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    func goToLogin() {
        
        UIViewController().logoutSuccess()
        
    }
    func success(data:JSON){
        print("hello \(data)")
        
    }
    func fail(data:JSON){
        
    }
    func redirect(data:JSON){
        guard !shouldComplete else {return}
        shouldComplete = true
        if (UIViewController().getUser()?.isSocial)! {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GenderSocialVC") as! GenderSocialVC
            
            let nav = UINavigationController(rootViewController:vc)
            
            nav.isNavigationBarHidden = true
            
            BGUtilities().getCurrentViewController()?.present(nav, animated: true, completion: nil)
            
        }else{
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GenderVC") as! GenderVC
            
            let nav = UINavigationController(rootViewController:vc)
            
            nav.isNavigationBarHidden = true
            
            BGUtilities().getCurrentViewController()?.present(nav, animated: true, completion: nil)
        }
        
    }
    
    func uploadSuccess(number:Int){
        print("controller \(number)")
    }
    
    func sendProgress(_ pro:CGFloat) {
        
    }
    
    func OpenLoading(view1:MainViewControllerS){
        
        container = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        let Controller=Loading(nibName: "Loading", bundle: nil)
        Controller.view.frame.size=CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
     //   container.backgroundColor=UIColor(white: 0, alpha: 0.5)
        view1.addChild(Controller)
        
        container.addSubview((Controller.view)!)
        
        Controller.didMove(toParent: view1)
        view1.view.addSubview(container)
    }
    
    func CloseLoading(){
        container.removeFromSuperview()
        // SwiftLoader.hide()
        //container.removeFromSuperview()
        //  SwiftSpinner.hide()
        
    }
    
    func showGeneral(data:Int) {
        
        #if DEBUG
        Utilities.showAlertHome(message: "500 Error")
        #endif
    }
    
    func OpenLoadingWindow(){
        
        let container = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        
        let Controller=Loading(nibName: "Loading", bundle: nil)
        Controller.view.frame.size=CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        container.backgroundColor=UIColor(white: 0, alpha: 0.5)
        
        container.tag = 324
        
        container.addSubview((Controller.view)!)
        
        let appWin = (UIApplication.shared.delegate as! AppDelegate).window!
        
        appWin.addSubview(container)
        
        
    }
    
    func CloseLoadingWindow(){
        
        let appWin = (UIApplication.shared.delegate as! AppDelegate).window!
        
        for v in appWin.subviews {
            
            if v.tag == 324 {
                
                v.removeFromSuperview()
                
                break
            }
            
        }
        
    }
    
    func clearTeninContent() {
        
        let wind = ( UIApplication.shared.delegate as! AppDelegate).window!
        
        wind.clearCurrent2()
        
    }
    
    
    func OpenMiniLoading(view1:MainViewControllerS) {
        
        container = UIView(frame: CGRect(x: 0, y:  0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        let Controller=LoadingMini(nibName: "Loading", bundle: nil)
        container.translatesAutoresizingMaskIntoConstraints = false
        Controller.view.translatesAutoresizingMaskIntoConstraints = false
        Controller.view.frame.size=CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        container.backgroundColor=UIColor(white: 0, alpha: 0.5)
        view1.addChild(Controller)
        container.tag = 304
        container.addSubview((Controller.view)!)
        
        Controller.didMove(toParent: view1)
        
        view1.view.addSubview(container)
        
        NSLayoutConstraint.activate([
            
            container.heightAnchor.constraint(equalToConstant: 2),
            
            container.leadingAnchor.constraint(equalTo: view1.view.leadingAnchor),
            
            container.trailingAnchor.constraint(equalTo: view1.view.trailingAnchor),
            
            container.bottomAnchor.constraint(equalTo: view1.view.safeAreaLayoutGuide.bottomAnchor),
            
            Controller.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            
            Controller.view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            Controller.view.bottomAnchor.constraint(equalTo:container.bottomAnchor),
            
            Controller.view.topAnchor.constraint(equalTo:container.topAnchor),
            ])
        
    }
    
    func CloseMiniLoading(){
        
        container.removeFromSuperview()
        
    }
    
    func reToken(method: HTTPMethod , controller:MainViewControllerS,url:String,parameters1:Parameters,headers1:HTTPHeaders,showLoading:Bool = true,inAppDelegate:Bool = false,showMini:Bool = false,showMiniUp:Bool = false,images:[UIImage]?,video:URL?){
        
        let appID  =  "57077286353"
        let secret = "yYFIxlFq4sbdb9HJVrZTMTTWH5XIcBFO1gGD6m7a"
        var head = ["Accept":"application/json"]
        head["From"]=UUID.init().uuidString
        head["Accept-Language"] = NSLocalizedString("lang", comment: "")
        head["User-Agent"]="iphone"
        head["Authorization"] = "Basic " + "\(appID):\(secret)".toBase64()
        Alamofire.request(Links.token,method:.post,parameters:nil,encoding:JSONEncoding.default,headers:head).responseJSON { (response:DataResponse<Any>) in
            guard response.result.value != nil else  { return }
            switch response.response?.statusCode {
            case 200 :
                if response.result.value != nil{
                    print("success")
                    print(response.result.value! , "reToken Data Value" )
                    self.success(data: JSON(response.result.value!))
                    if let newToken = JSON(response.result.value!).dictionary{
                        UserDefaults.standard.set(newToken["token"]?.stringValue, forKey: "token")
                        switch method {
                        case .get:
                            self.Get(controller: controller, url: url, parameters1: parameters1, headers1: headers1, showLoading: showLoading, inAppDelegate: inAppDelegate, showMini: showMini, showMiniUp: showMiniUp)
                        case .post:
                            self.Post(controller: controller, url: url, parameters1: parameters1, headers1: headers1)
                        case .put:
                            self.Put(controller: controller, url: url, parameters1: parameters1, headers1: headers1, showLoading: showLoading)
                        case .patch:
                            self.Patch(controller: controller, url: url, parameters1: parameters1, headers1: headers1, showLoading: showLoading)
                        default:
                            
                            if let videoUrl = video {
                                self.uploadVideoAndImage(controller:controller,url:url,parameters1:parameters1,headers1:headers1,images:images!,video:videoUrl,showLoading:showLoading)
                            }else{
                                self.uploadImageAndData(controller:controller,url:url,parameters1:parameters1,headers1:headers1,images:images!,showLoading:showLoading)
                            }
                            
                        }
                    }
                }
                break
            default: break
                
            }
            
        }
    }
    
}




extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

class Header
{
    func getHeader(old: HTTPHeaders) -> HTTPHeaders {
        var header = old
        header["Accept"] = "application/json"
        
        if let saved = UserDefaults.standard.string(forKey: "uidSaved") {
             header["From"] = saved
        }
        else {
            
            let str = UUID.init().uuidString
            
            let md = md5(string: str)
            
            print("mdmdmdmdmdmdmdmdmdmdmdmdmdmdmd9898 ",md)
            
            UserDefaults.standard.set(md, forKey: "uidSaved")
            
            header["From"] = md
            
        }
       
        header["Accept-Language"] = NSLocalizedString("lang", comment: "")
        header["User-Agent"] = "iphone"
        header["Authorization"] = "Bearer \(UserDefaults.standard.string(forKey: "token") ?? "" )"
      //  header["IOSToken"] = UserDefaults.standard.string(forKey: "IOSToken") ?? ""
        
      //  print("tkrtkjrtjkktjrkjtrkjtrkjtjktrkjtr ",header["IOSToken"])
        
        return header
    }
    
    func md5(string: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData.map { String(format: "%02hhx", $0) }.joined()
    }
}

