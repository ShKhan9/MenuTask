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

class MainControllerS : NSObject {
    
    var container:UIView!
    
    func Get(controller:MainViewControllerS,url:String,parameters1:Parameters,headers1:HTTPHeaders,showLoading:Bool = true){
 
        print(headers1 , "<< sended header")
        print(parameters1, "<< sended parameters")
        // show loading if needed
        if showLoading {
            controller.addLoading()
        }
   
        let head = Header().getHeader(old: headers1)
        
        Alamofire.request(url,method:.get,parameters:parameters1,headers:head).responseJSON { (response ) in
            // validate response
          
            guard response.result.value != nil else  { return }
            let responseValue = JSON(response.result.value!)
            if let responseStatus = responseValue["code"].int {

                print("GET REQUEST STATUSCODE --> ",response.response?.statusCode ?? 0 ,response.error ?? "" , "REQUEST URL :  ",url, " STATUSCODE : ",responseStatus )
                
            }
            // hide loading if needed
            if showLoading {
                controller.removeLoading()
                
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
            case 404 :
                if response.result.value != nil{
                    print("fail in logic")
                    print(response.result.value!)
                    self.fail(data: JSON(response.result.value!))
                }
                break 
            default: break
            }
        }
    }
    func completeData() {
        if let nav =   (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController {
            print(nav)
        }
    }
    func success(data:JSON){
        print("hello \(data)")
        
    }
    func fail(data:JSON){
        
    }
 
}

class Header {
    
    func getHeader(old: HTTPHeaders) -> HTTPHeaders {
        
        var header = old
        
        header["Accept"] = "application/json"
       
        header["Authorization"] = "Bearer \(appToken)"
      
        return header
    }
     
}

let appToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6Ijc2MWRjYTE1MDQ0MTc4NTdkMzVjMWYxMzcwNDU4YzRhMWMyYzAyZjMyNzA2YzgwNGEzNDgyZjk5NDRiNDJiZmVkNjgyMzlmYWY3N2JiYTc3In0.eyJhdWQiOiI4Zjc4NjY2NC0wNTg5LTQ3MTgtODBkMS1lMTY4M2FmYmM3MjQiLCJqdGkiOiI3NjFkY2ExNTA0NDE3ODU3ZDM1YzFmMTM3MDQ1OGM0YTFjMmMwMmYzMjcwNmM4MDRhMzQ4MmY5OTQ0YjQyYmZlZDY4MjM5ZmFmNzdiYmE3NyIsImlhdCI6MTYwNTQzMzIxNywibmJmIjoxNjA1NDMzMjE3LCJleHAiOjE2MzY5NjkyMTcsInN1YiI6IjhmN2I2NmYwLWE1MjctNGNkNC05MjNkLTYyODM3MDQ1Yjk5NSIsInNjb3BlcyI6WyJnZW5lcmFsLnJlYWQiXSwiYnVzaW5lc3MiOiI4ZjdiNjZmMC1hNTUxLTRlNmYtODU5Mi0wMmRhZjBjNTUzODYiLCJyZWZlcmVuY2UiOiIxMDAwMDAifQ.OIwEjclD0VGn2zzgEQT1aPZLmBAXuO0IpF_IC_tlRZYS1Bz9z_GE-J7xNEcCDUT9zJVpvOShuAn_4IuxKyZvfA0ZlguOjjUy0dv9De2ssUmoQfmv8pU8Ft0s7g-IM0bn-hSFIAWZmDt2rlDhVe-8wDrj7p9AvvKflUZ7At3Y-vRDR5mp1CMpdLXIlWmf3j8XsDRcdyqTAoLRdS0s_3kaWLXgGB8CdfebUpFEvugqtJajEi95-f-jP5aciGkHjKRNTAMHj04DdEAWrD9hZdqkz9CON4yAbJTcvf4jRJP61joHmxbJxXA9bxAYfxmq6ChFoPmJ1xSmjecIKVXXfc5MRGRd_h4YnKbM9J4whz_jfWKTYgHfuJWJyuTJUFOndG-lN5sjGGTCmXA9oSouajqtTI9DEVpnQ3eITtS61ceTvD8jujUB0OtlBLMYAmMmut9X3FYlQWOR6uAWIpJOOmF7BNBdtSvg1U1sQNK9q1kyVsw_7RJpKCUfg2cflwvS-e-zjKzVRvqAnovY3AAt22W1JD9N2J-BhtMKLbvs6bbfT9ih2jYsqT7GXFMSPi9RvkHTzVYgJ8k9Hj3Dh8iI0ZZf2uPRonaRfvYnbD01c7uf7V5HD12htRAH9jMqG0lRxDiFIvBGx6rdLRke7AHHeDxtjskmKyg44gQPSxMyZnQ4EuU"
