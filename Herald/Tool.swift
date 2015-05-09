//
//  Tool.swift
//  先声
//
//  Created by Wangshuo on 14-8-5.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import Foundation

@objc protocol APIGetter{
    func getResult(APIName:String, results:AnyObject)
    func getError(APIName:String, statusCode:Int)
}

class HeraldAPI:HttpProtocol{
    
    var httpController:HttpController
    var delegate:APIGetter?
    
    init(){
        httpController = HttpController()
    }
    
    func sendAPI(APIName:String, APIParameter:String?...){
        self.httpController.delegate = self
        
        let baseURL = "http://herald.seu.edu.cn/api/"
        let uuid = Config.UUID!
        let baseParameter:NSDictionary = ["uuid":uuid]
        
        switch APIName{
        case "pe":
            let url = baseURL + "pe"
            let parameter = baseParameter
            httpController.postToURLAF(url, parameter: parameter, tag: "pe")
        case "curriculum":
            let url = baseURL + "curriculum"
            let parameter = baseParameter
            httpController.postToURLAF(url, parameter: parameter, tag: "curriculum")
        case "jwc":
            let url = baseURL + "jwc"
            let parameter = baseParameter
            httpController.postToURLAF(url, parameter: parameter, tag: "jwc")
        case "srtp":
            let url = baseURL + "srtp"
            let parameter = baseParameter
            httpController.postToURLAF(url, parameter: parameter, tag: "srtp")
        case "nic":
            let url = baseURL + "nic"
            let parameter = baseParameter
            httpController.postToURLAF(url, parameter: parameter, tag: "nic")
        case "card":
            let url = baseURL + "card"
            let parameter = baseParameter
            httpController.postToURLAF(url, parameter: parameter, tag: "card")
        case "cardDetail":
            let url = baseURL + "card"
            let parameter:NSDictionary = ["uuid":uuid,"timedelta":"30"]
            httpController.postToURLAF(url, parameter: parameter, tag: "cardDetail")
        case "phylab":
            let url = baseURL + "phylab"
            let parameter = baseParameter
            httpController.postToURLAF(url, parameter: parameter, tag: "phylab")
        case "lecture":
            let url = baseURL + "lecture"
            let parameter = baseParameter
            httpController.postToURLAF(url, parameter: parameter, tag: "lecture")
        case "lectureNotice":
            let url = baseURL + "lecturenotice"
            let parameter = baseParameter
            httpController.postToURLAF(url, parameter: parameter, tag: "lectureNotice")
        case "searchBook":
            let url = baseURL + "search"
            let parameter:NSDictionary = ["uuid":uuid,"book":APIParameter[0] ?? ""]
            httpController.postToURLAF(url, parameter: parameter, tag: "searchBook")
        case "library":
            let url = baseURL + "library"
            let parameter = baseParameter
            httpController.postToURLAF(url, parameter: parameter, tag: "library")
        case "libraryRenew":
            let url = baseURL + "renew"
            let parameter:NSDictionary = ["uuid":uuid,"barcode":APIParameter[0] ?? ""]
            httpController.postToURLAF(url, parameter: parameter, tag: "libraryRenew")
        case "schoolbus":
            let url = baseURL + "schoolbus"
            let parameter = baseParameter
            httpController.postToURLAF(url, parameter: parameter, tag: "schoolbus")
        case "gpa":
            let url = baseURL + "gpa"
            let parameter = baseParameter
            httpController.postToURLAF(url, parameter: parameter, tag: "gpa")
        default:
            break
        }
    }
    
    func didReceiveDicResults(results: NSDictionary, tag: String) {
        var statusCode:Int? = results["code"] as? Int
        if(statusCode != 200){
            self.delegate?.getError(tag, statusCode: 500)
            return
        }
        //有些API返回的状态码不一定代表真实情况，根据JSON的code来判断……
        
        switch tag{
        case "pe":
            self.delegate?.getResult(tag, results: results["content"] as NSString)
        case "curriculum":
            self.delegate?.getResult(tag, results: results["content"] as NSDictionary)
        case "jwc":
            self.delegate?.getResult(tag, results: results["content"] as NSDictionary)
        case "srtp":
            self.delegate?.getResult(tag, results: results["content"] as NSArray)
        case "nic":
            self.delegate?.getResult(tag, results: results["content"] as NSDictionary)
        case "card":
            self.delegate?.getResult(tag, results: results["content"] as NSDictionary)
        case "cardDetail":
            self.delegate?.getResult(tag, results: results["content"] as NSDictionary)
        case "lecture":
            self.delegate?.getResult(tag, results: results["content"] as NSDictionary)
        case "phylab":
            self.delegate?.getResult(tag, results: results["content"] as NSDictionary)
        case "lectureNotice":
            self.delegate?.getResult(tag, results: results["content"] as [NSDictionary])
        case "searchBook":
            self.delegate?.getResult(tag, results: results["content"] as NSArray)
        case "library":
            self.delegate?.getResult(tag, results: results["content"] as NSArray)
        case "libraryRenew":
            self.delegate?.getResult(tag, results: results["content"] as String)
        case "schoolbus":
            self.delegate?.getResult(tag, results: results["content"] as NSDictionary)
        case "gpa":
            self.delegate?.getResult(tag, results: results["content"] as NSArray)
        default:
            break
        }
    }
    
    func didReceiveErrorResult(code: Int, tag: String) {
        self.delegate?.getError(tag, statusCode: code)
    }
    
    func cancelAllRequest(){
        httpController.cancelAllRequest()
    }
}

class Tool:NSObject
{
    //网络请求的动画控制
    class func dismissHUD()
    {
        ProgressHUD.dismiss()
    }
    
    class func showProgressHUD(text:String)
    {
        ProgressHUD.show(text)
    }
    
    class func showSuccessHUD(text:String)
    {
        ProgressHUD.showSuccess(text)
    }
    
    class func showErrorHUD(text:String)
    {
        ProgressHUD.showError(text)
    }
    
    //初始化在导航栏里面的所有VC
    class func initNavigationAPI(VC:UIViewController,navBarColor:UIColor) -> Bool{
        VC.navigationController?.navigationBar.barTintColor = navBarColor
        
        Config.shareInstance().isNetworkRunning = CheckNetwork.doesExistenceNetwork()
        
        if Config.UUID == nil || Config.UUID!.isEmpty{
            Tool.showSuccessHUD("请在边栏的个人资料中补全您的信息")
        }
        else if !Config.shareInstance().isNetworkRunning{
            Tool.showErrorHUD("貌似你没有联网哦")
        }
        else{
            return true
        }
        return false
    }
}