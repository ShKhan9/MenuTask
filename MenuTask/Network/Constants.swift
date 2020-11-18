//
//  Constants.swift
//  AlacamDem
//
//  Created by Mac on 11/19/18.
//  Copyright © 2018 Mac. All rights reserved.
//
import Foundation

var modalShown = true

var alaCamDo = "https://3lacam.staging.poseidon-me.com/api/" // "http://3lacam.dev.poseidon-me.com/api/"  //"https://api.3lacam.com/api/" // "http://3lacam.staging.poseidon-me.com/api/"  //   "http://3lacam.testing.poseidon-me.com/api/"  // //http://3lacam.production.poseidon-me.com/api/"  // "http://testing.poseidon-me.com/api/" // "http://3lacam.testing.poseidon-me.com/api/" // "https://api.3lacam.com/api/" //


var webURLShare = "" //https://3lacamwebnew.staging.poseidon-me.com/market-item/"
var videoUrl = ""
let addRem = "members/me/update-subscription"
let AppStoreLink = "https://itunes.apple.com/eg/app/3lacam/id1450274953?mt=8"
let AppStoreLinkReview = "itms-apps:itunes.apple.com/us/app/apple-store/id1450274953?mt=8&action=write-review"
let AppFont = "Cairo"
let AppFontMedium = "Cairo-Medium"
let AppFontBold = "Cairo-Bold" 
let kIsSubscriber = "kIsSubscriber" 
let registerUrl1 = "register/step1"
let registerUrl2 = "register/step2"
let registerUrl3 = "register/step3"
let loginUrl1 = "login"        
let loginUrlFace = "login/facebook"
let loginUrlGoo = "login/google"
let resend = "register/resend"
let cate = "members/categories"
let completePro = "checkout/complete-profile"
let forPass = "forgetpassword/send_code"
let enterC = "forgetpassword/enter_code"
let passChange = "forgetpassword/change_password"
let resendForget = "forgetpassword/resend"
let assw = "video-assets"
let categ = "v2/members/feed/category"
let recommended = "members/feed/recommend"
let nearBBB = "v2/members/feed/near-by"
let nearBy = "v2/members/feed/recommend"
let faqqqqq = "members/faqs"
let feedB = "members/feedback"
let getCatego = "members/me/interests"
let updateInter = "members/update-interests"
let commm = "members/feed/video/" 
let likkk = "members/videos/like/"
let addCom = "members/videos/comment/"
let deleteCom = "members/videos/comment/delete"
let repor = "members/reports"
let reporStat = "report-status-items/"
let searVid = "v2/members/feed/category"
let subsc = "members/feed/subscribers"
let subPack = "packages"
let sendSub = "members/me/subscriptions/add"
let notifi = "members/notifications"
let passChan = "members/me/change-password"
let follow = "members/me/followers"
let followin = "members/me/following"
let rrate = "members/me/rate"
let bar = "members"
let ffo = "members/relations/follow"
let unffo = "members/relations/un-follow"
let bloc = "members/relations/block"
let unbloc = "members/relations/un-block"
let blockLis = "members/me/block-list"
let changaaa = "members/me/change-number-email"
let verifyChan = "members/me/change-number-email/verify"
let image = "members/me/update-profile"
let logou = "members/me/logout"
let opts = "members/me/update-profile/store-opts"
let myCurrentSubsbs = "members/current-subscriptions"
let mySubsbs = "members/subscriptions"
let promoC = "members/me/subscriptions/check-promo"
let updateV = "members/videos/update"
let checkV = "module/options" // "check-version"
let tourr = "members/page/tour"
let trms = "members/page/terms"
let help = "members/page/help"
let privacy =  "members/page/privacy-policy"
let UploadVid = "v2/members/videos/store"
let fill = "members/new/filters"
let resendPhoneEmail = "members/me/change-number-email/resend"
let myNeighborhood =  "members/feed/region"
let searCatego =  "v2/members/feed/categories"
let getVidSubs = "v2/members/videos-subscriptions"
let getVidSubs2 = "members/subscriptions"
let isMMMM = "members/videos/is-main"
let repComm = "members/comment-indicator"
let geha = "members/elgihaz-sign?indicator=commnet&id="
let agreement = "members/page/agreement"
let viewVideo = "members/videos/action/view"
let newToken = "token"
let card3laCam = "members/me/subscriptions/check-card"
let cardRequest = "members/card/request"
let news = "members/feed/news"
let sensSess = "members/me/subscriptions/check-3d-step1"
let sendSecu = "members/me/subscriptions/check-3d-step2"
let conne = "members/qrcode-connect"
let offers = "members/offers"
let c1 = "members/videos/action/call"
let c2 = "members/videos/action/navigate"
let c3 = "members/videos/action/chat"
let c4  = "members/videos/action/share"
let c5 = "members/videos/action/ordernow"
let sendNoti = "members/send/notification"
let ren = "members/me/subscriptions/renew"
let uppp = "members/me/subscriptions/update"

//let uppp = "ecommerce/filters/"
let mark = "ecommerce/categories/leaf"  /// leafs
let produ = "ecommerce/products?category_id"
let det = "ecommerce/products/details/"
let ord = "ecommerce/orders/order"

let ordList = "ecommerce/orders/list"
let ordCancel = "ecommerce/orders/cancel/"


let ProdPack1 = "ecommerce/products/package/"
let ProdPackDet1 = "ecommerce/products/package/details/"

let gov = "ecommerce/governments"

let con111 = "ecommerce/orders/confirm/"
 
let gAdss = "ecommerce/products/side-package/details/"

let rkmar = "members/subscriber/request/market"


let inacccc =  "members/feed/all-videos"

let searAll = "v2/members/feed/allData"

let deleteV = "members/videos/delete/"
 
struct Links  { 
 
    static var DeleteVideo:String {
        return "\(alaCamDo)\(deleteV)"
    }
    
    static var SearchAll:String {
        return "\(alaCamDo)\(searAll)"
    }
    
    static var getInActive:String {
        return "\(alaCamDo)\(inacccc)"
    }
    
    static var NearBBB:String {
        return "\(alaCamDo)\(nearBBB)"
    }
    
    
    static var AddMar:String {
        return "\(alaCamDo)\(rkmar)"
    }
    static var NewHelp:String {
        return "\(alaCamDo)\(help)"
    } 
    static var Adverts:String {
        return "\(alaCamDo)\(gAdss)"
    }
    
    static var OrderAppDelConf:String {
        return "\(alaCamDo)\(con111)"
    }
  
    static var Goves:String {
        return "\(alaCamDo)\(gov)"
    }
    static var ProdPack:String {
        return "\(alaCamDo)\(ProdPack1)"
    }
    static var ProdPackDet:String {
        return "\(alaCamDo)\(ProdPackDet1)"
    }
    
    
    static var OrderCancel:String {
        return "\(alaCamDo)\(ordCancel)"
    }
    static var OrderList:String {
        return "\(alaCamDo)\(ordList)"
    }
    static var ProdOrder:String {
        return "\(alaCamDo)\(ord)"
    }
    static var ProductDet:String {
        return "\(alaCamDo)\(det)"
    }
    static var Products:String {
        return "\(alaCamDo)\(produ)"
    }
    static var EComCateg:String {
        return "\(alaCamDo)\(mark)"
    }
    static var AddRem2:String {
        return "\(alaCamDo)\(addRem)"
    }
    static var GetVidSubs2:String {
        return "\(alaCamDo)\(getVidSubs2)"
    }
    static var RenewAll:String {
        return "\(alaCamDo)\(ren)"
    }
    static var Renew:String {
        return "\(alaCamDo)\(uppp)"
    }
    static var register1:String {
      return "\(alaCamDo)\(registerUrl1)"
    }
    static var register2 :String {
       return "\(alaCamDo)\(registerUrl2)"
    }
    static var register3 :String {
        return "\(alaCamDo)\(registerUrl3)"
    }
    static var loginPhone :String {
        return "\(alaCamDo)\(loginUrl1)"
    }
    static var loginSocialFacebook :String {
        return "\(alaCamDo)\(loginUrlFace)"
    }
    static var loginSocialGoogle :String {
        return "\(alaCamDo)\(loginUrlGoo)"
    }
    static var registerResend :String {
        return "\(alaCamDo)\(resend)"
    }
    static var categories:String {
        return "\(alaCamDo)\(cate)"
    }
    static var completeProfile :String {
        return "\(alaCamDo)\(completePro)"
    }
    static var forgetPassword :String {
        return "\(alaCamDo)\(forPass)"
    }
    static var ForgetPassEnterCode :String {
        return "\(alaCamDo)\(enterC)"
    }
    static var ForgetPassChange :String {
        return "\(alaCamDo)\(passChange)"
    }
    static var ForgetResendRetry :String {
        return "\(alaCamDo)\(resendForget)"
    }
    static var assests :String {
        return "\(alaCamDo)\(assw)"
    }
    static var categoryVideos :String {
        return "\(alaCamDo)\(categ)"
    }
    static var recommendedVideos :String {
        return "\(alaCamDo)\(recommended)"
    }
    static var nearByVideos :String {
        return "\(alaCamDo)\(nearBy)"
    }
    static var FAQ :String {
        return "\(alaCamDo)\(faqqqqq)"
    }
    static var FeedBack :String {
        return "\(alaCamDo)\(feedB)"
    }
    static var getUserInterests :String {
        return "\(alaCamDo)\(getCatego)"
    }
    static var updateInterests :String {
        return "\(alaCamDo)\(updateInter)"
    }
    static var comments :String {
        return "\(alaCamDo)\(commm)"
    }
    static var delComments :String {
        return "\(alaCamDo)\(deleteCom)"
    }
    static var likes :String {
        return "\(alaCamDo)\(likkk)"
    }
    static var addComment :String {
        return "\(alaCamDo)\(addCom)"
    }
    static var report :String {
        return "\(alaCamDo)\(repor)"
    }
    static var reportStatus :String {
        return "\(alaCamDo)\(reporStat)"
    }
    static var searVideos :String {
        return "\(alaCamDo)\(searVid)"
    }
    static var searSubscribers :String { return "\(alaCamDo)\(subsc)" }
    static var packages :String { return "\(alaCamDo)\(subPack)"}
    static var addSubs :String { return "\(alaCamDo)\(sendSub)"}
    static var notifications :String { return "\(alaCamDo)\(notifi)"}
    static var passwordChange :String { return "\(alaCamDo)\(passChan)"}
    static var followers :String { return "\(alaCamDo)\(follow)"}
    static var following :String { return "\(alaCamDo)\(followin)"}
    static var rate :String { return "\(alaCamDo)\(rrate)"}
    static var barcode :String { return "\(alaCamDo)\(bar)"}
    static var follow :String { return "\(alaCamDo)\(ffo)"}
    static var unFollow :String { return "\(alaCamDo)\(unffo)"}
    static var block :String { return "\(alaCamDo)\(bloc)"}
    static var unBlock :String { return "\(alaCamDo)\(unbloc)"}
    static var blockList :String { return "\(alaCamDo)\(blockLis)"}
    static var ChangeAddEmailPhone :String { return "\(alaCamDo)\(changaaa)"}
    static var VerifyAddEmailPhone :String { return "\(alaCamDo)\(verifyChan)"}
    static var SendImage :String { return "\(alaCamDo)\(image)"}
    static var logout :String { return "\(alaCamDo)\(logou)"}
    static var updateOpts :String { return "\(alaCamDo)\(opts)"}
    static var MySubscribtion :String { return "\(alaCamDo)\(mySubsbs)"}
    static var MyCurrentSubscribtion :String { return "\(alaCamDo)\(myCurrentSubsbs)"}
    static var updateVideo :String { return "\(alaCamDo)\(updateV)"}
    static var CheckVersion  :String { return "\(alaCamDo)\(checkV)"}
    static var Terms :String { return "\(alaCamDo)\(trms)"}
    static var Tour  :String { return "\(alaCamDo)\(tourr)"}
    static var Privacy  :String { return "\(alaCamDo)\(privacy)"}
    static var Agreement  :String { return "\(alaCamDo)\(agreement)"}
    static var UploadVideo  :String { return "\(alaCamDo)\(UploadVid)"}
    static var NewFilter  :String { return "\(alaCamDo)\(fill)"}
    static var ResendEmailPhone  :String { return "\(alaCamDo)\(resendPhoneEmail)"}
    static var MyNeighborhood  :String { return "\(alaCamDo)\(myNeighborhood)"}
    static var promoCode  :String { return "\(alaCamDo)\(promoC)"}
    static var searCategories :String { return "\(alaCamDo)\(searCatego)"}
    static var videoSubscriptions :String { return "\(alaCamDo)\(getVidSubs)"}
    static var isMain :String { return "\(alaCamDo)\(isMMMM)"}
    static var reportComment :String { return "\(alaCamDo)\(repComm)"}
    static var elgihazComment :String { return "\(alaCamDo)\(geha)"}
    static var ViewVideo :String { return "\(alaCamDo)\(viewVideo)"}
    static var token :String { return "\(alaCamDo)\(newToken)"}
    static var card3lacam :String { return "\(alaCamDo)\(card3laCam)"}
    static var cardsRequest :String { return "\(alaCamDo)\(cardRequest)"}
    static var sendSession :String { return "\(alaCamDo)\(sensSess)"}
    static var sendSecure :String { return "\(alaCamDo)\(sendSecu)"}
    static var connect :String { return "\(alaCamDo)\(conne)"}
    static var newsFeeds :String { return "\(alaCamDo)\(news)"}
    static var getOffers :String { return "\(alaCamDo)\(offers)"} 
    static var CallLLL :String { return "\(alaCamDo)\(c1)"}
    static var NavigateLLL :String { return "\(alaCamDo)\(c2)"}
    static var ChatLLL :String { return "\(alaCamDo)\(c3)"}
    static var Share :String { return "\(alaCamDo)\(c4)"}
    static var Order :String { return "\(alaCamDo)\(c5)"}
    static var sendNotification :String { return "\(alaCamDo)\(sendNoti)"}

}


 
