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
    
    //先声公开API的appid
    var appid = "9f9ce5c3605178daadc2d85ce9f8e064"
    var delegate:APIGetter?
    var manager:AFHTTPRequestOperationManager

    init(){
        manager = AFHTTPRequestOperationManager()
    }
    
    func sendAPI(APIName:String, APIParameter:String?...){
        
        let userURL = "http://herald.seu.edu.cn/uc/"
        let baseURL = "http://herald.seu.edu.cn/api/"
        let uuid = Config.UUID!
        let baseParameter:NSDictionary = ["uuid":uuid]
        
        switch APIName{
        case "userLogin":
            let url = userURL + "auth"
            let parameter:NSDictionary = ["user":APIParameter[0] ?? "","password":APIParameter[1] ?? "","appid":appid]
            self.postToURL(url, parameter: parameter, tag: "userLogin")
        case "userUpdate":
            let url = userURL + "update"
            let parameter:NSDictionary = ["cardnum":Config.cardID ?? "","password":Config.cardPassword ?? "","number":Config.studentID ?? "","pe_password":APIParameter[0] ?? "","lib_username":APIParameter[1] ?? "","lib_password":APIParameter[2] ?? "","card_query_password":APIParameter[3] ?? ""]
            //"cardnum","password","number","pe_password","lib_username","lib_password","card_query_password"
            self.postToURL(url, parameter: parameter, tag: "userUpdate")
        case "getStudentNum":
            let url = "http://xk.urp.seu.edu.cn/jw_service/service/stuCurriculum.action"
            let parameter:NSDictionary = ["queryStudentId":Config.cardID ?? ""]
            self.postToURL(url, parameter: parameter, tag: "getStudentNum")
        case "simsimi":
            let url = baseURL + "simsimi"
            let parameter:NSDictionary = ["uuid":uuid, "msg":APIParameter[0] ?? ""]
            self.postToURL(url, parameter: parameter, tag: "simsimi")
        case "emptyRoom":
            let url = baseURL + "emptyroom"
            let parameter: NSDictionary = ["uuid":uuid,"arg1":APIParameter[0] ?? "","arg2":APIParameter[1] ?? "","arg3":APIParameter[2] ?? "","arg4":APIParameter[3] ?? "","arg5":APIParameter[4] ?? ""]
            self.postToURLAF(url, parameter: parameter, tag: "emptyRoom")
        case "pe":
            let url = baseURL + "pe"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: "pe")
        case "curriculum":
            let url = baseURL + "curriculum"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: "curriculum")
        case "jwc":
            let url = baseURL + "jwc"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: "jwc")
        case "srtp":
            let url = baseURL + "srtp"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: "srtp")
        case "nic":
            let url = baseURL + "nic"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: "nic")
        case "card":
            let url = baseURL + "card"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: "card")
        case "cardDetail":
            let url = baseURL + "card"
            let parameter:NSDictionary = ["uuid":uuid,"timedelta":"30"]
            self.postToURLAF(url, parameter: parameter, tag: "cardDetail")
        case "phylab":
            let url = baseURL + "phylab"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: "phylab")
        case "lecture":
            let url = baseURL + "lecture"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: "lecture")
        case "lectureNotice":
            let url = baseURL + "lecturenotice"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: "lectureNotice")
        case "searchBook":
            let url = baseURL + "search"
            let parameter:NSDictionary = ["uuid":uuid,"book":APIParameter[0] ?? ""]
            self.postToURLAF(url, parameter: parameter, tag: "searchBook")
        case "library":
            let url = baseURL + "library"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: "library")
        case "libraryRenew":
            let url = baseURL + "renew"
            let parameter:NSDictionary = ["uuid":uuid,"barcode":APIParameter[0] ?? ""]
            self.postToURLAF(url, parameter: parameter, tag: "libraryRenew")
        case "schoolbus":
            let url = baseURL + "schoolbus"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: "schoolbus")
        case "gpa":
            let url = baseURL + "gpa"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: "gpa")
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
            self.delegate?.getResult(tag, results: results["content"] as! NSString)
        case "curriculum":
            self.delegate?.getResult(tag, results: results["content"] as! NSDictionary)
        case "jwc":
            self.delegate?.getResult(tag, results: results["content"] as! NSDictionary)
        case "srtp":
            self.delegate?.getResult(tag, results: results["content"] as! NSArray)
        case "nic":
            self.delegate?.getResult(tag, results: results["content"] as! NSDictionary)
        case "card":
            self.delegate?.getResult(tag, results: results["content"] as! NSDictionary)
        case "cardDetail":
            self.delegate?.getResult(tag, results: results["content"] as! NSDictionary)
        case "lecture":
            self.delegate?.getResult(tag, results: results["content"] as! NSDictionary)
        case "phylab":
            self.delegate?.getResult(tag, results: results["content"] as! NSDictionary)
        case "lectureNotice":
            self.delegate?.getResult(tag, results: results["content"] as! [NSDictionary])
        case "searchBook":
            self.delegate?.getResult(tag, results: results["content"] as! NSArray)
        case "library":
            self.delegate?.getResult(tag, results: results["content"] as! NSArray)
        case "libraryRenew":
            self.delegate?.getResult(tag, results: results["content"] as! String)
        case "schoolbus":
            self.delegate?.getResult(tag, results: results["content"] as! NSDictionary)
        case "gpa":
            self.delegate?.getResult(tag, results: results["content"] as! NSArray)
        default:
            break
        }
    }
    
    func didReceiveArrayResults(results: NSArray, tag: String) {
        switch tag{
        case "emptyRoom":
            self.delegate?.getResult(tag, results: results)
        default:
            break
        }
    }
    
    
    func didReceiveDataResults(results: NSData, tag: String) {
        switch tag{
        case "userLogin":
            self.delegate?.getResult(tag, results: results)
        default:
            break
        }
    }
    
    
    func didReceiveStringResults(results: NSString, tag: String) {
        switch tag{
        case "userUpdate":
            self.delegate?.getResult(tag, results: results)
        case "simsimi":
            self.delegate?.getResult(tag, results: results)
        default:
            break
        }
    }
    
    
    func didReceiveErrorResult(code: Int, tag: String) {
        self.delegate?.getError(tag, statusCode: code)
    }

    
    
    func requestFromURLAF(url:String,tag:String)
    {
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        
        manager.GET(url, parameters: nil, success:
            {(operation :AFHTTPRequestOperation!, responseObject :AnyObject!) -> Void in
                
                self.didReceiveArrayResults(responseObject as? NSArray ?? NSArray(),tag:tag)
                self.didReceiveDicResults(responseObject as? NSDictionary ?? NSDictionary(),tag:tag)
                self.didReceiveDataResults(responseObject as? NSData ?? NSData(),tag:tag)
                self.didReceiveStringResults(responseObject as? NSString ?? NSString(),tag:tag)
            }
            , failure:
            {(operation :AFHTTPRequestOperation!, error :NSError!) -> Void in
                
            }
        )
    }
    
    
    
    func requestFromURLAFjson(url:String,tag:String)
    {
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        
        manager.GET(url, parameters: nil, success:
            {(operation :AFHTTPRequestOperation!, responseObject :AnyObject!) -> Void in
                
                self.didReceiveArrayResults(responseObject as? NSArray ?? NSArray(),tag:tag)
                self.didReceiveDicResults(responseObject as? NSDictionary ?? NSDictionary(),tag:tag)
                self.didReceiveDataResults(responseObject as? NSData ?? NSData(),tag:tag)
                self.didReceiveStringResults(responseObject as? NSString ?? NSString(),tag:tag)
            }
            , failure:
            {(operation :AFHTTPRequestOperation!, error :NSError!) -> Void in
                
            }
        )
    }
    
    func requestFromURL(url:String,tag:String)
    {
        let nsurl:NSURL = NSURL(string: url)!
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: nsurl)
        request.timeoutInterval = 5.0
        
        request.HTTPMethod = "GET"
        
        var data:NSData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)!
        
        var results:NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        
        self.didReceiveStringResults(results,tag:tag)
        
    }
    
    //accept text/html with text contentType
    func postToURL(url:String,parameter:NSDictionary,tag:String)
    {
        println("a post come!")
        println(parameter)
        println("ok")
        let nsurl:NSURL = NSURL(string: url)!
        
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        manager.POST(url, parameters: parameter,
            success: {(operation :AFHTTPRequestOperation!,responseObject :AnyObject!) ->Void in
                println("\n<Raw>***********\n")
                println(responseObject)
                println("\n</Raw>***********\n")
                var receiveData = responseObject as! NSData
                var receiveString = NSString(data: receiveData,encoding: NSUTF8StringEncoding)//use utf-8 to decode nsdata
                
                self.didReceiveArrayResults(responseObject as? NSArray ?? NSArray(),tag:tag)
                self.didReceiveDicResults(responseObject as? NSDictionary ?? NSDictionary(),tag:tag)
                self.didReceiveDataResults(responseObject as? NSData ?? NSData(),tag:tag)
                self.didReceiveStringResults(receiveString ?? "",tag:tag)
            },
            failure: {(operation :AFHTTPRequestOperation!, error :NSError!) ->Void in
                var codeStatue = 500
                if(operation.response != nil){
                    var codeStatue:Int = operation.response.statusCode
                }
                self.didReceiveErrorResult(codeStatue, tag: tag)
                println(error)
            }
        )
    }
    
    //accept text/html with json contentType
    func postToURLAF(url:String , parameter:NSDictionary,tag:String)
    {
        println("a post to json come!")
        println(parameter)
        println("ok")
        let nsurl:NSURL = NSURL(string: url)!
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html") as Set<NSObject>
        manager.POST(url, parameters: parameter,
            success: {(operation :AFHTTPRequestOperation!,responseObject :AnyObject!) ->Void in
                println("\n<Raw>***********\n")
                println(responseObject)
                println("\n</Raw>***********\n")
                self.didReceiveArrayResults(responseObject as? NSArray ?? NSArray(),tag:tag)
                self.didReceiveDicResults(responseObject as? NSDictionary ?? NSDictionary(),tag:tag)
                self.didReceiveDataResults(responseObject as? NSData ?? NSData(),tag:tag)
                self.didReceiveStringResults(responseObject as? NSString ?? NSString(),tag:tag)
            },
            failure: {(operation :AFHTTPRequestOperation!, error :NSError!) ->Void in
                var codeStatue = 500
                if(operation.response != nil){
                    var codeStatue:Int = operation.response.statusCode
                }
                self.didReceiveErrorResult(codeStatue, tag: tag)
                println(error)
            }
        )
    }
    
    //accept application/json with json contentType
    func postToURLAFjson(url:String , parameter:NSDictionary,tag:String)
    {
        let nsurl:NSURL = NSURL(string: url)!
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json") as Set<NSObject>
        manager.POST(url, parameters: parameter, success: {(operation :AFHTTPRequestOperation!, responseObject :AnyObject!) -> Void in
            
            self.didReceiveArrayResults(responseObject as? NSArray ?? NSArray(),tag:tag)
            self.didReceiveDicResults(responseObject as? NSDictionary ?? NSDictionary(),tag:tag)
            self.didReceiveDataResults(responseObject as? NSData ?? NSData(),tag:tag)
            self.didReceiveStringResults(responseObject as? NSString ?? NSString(),tag:tag)
            
            
            }, failure: {(operation :AFHTTPRequestOperation!, error :NSError!) -> Void in
                
            }
        )
    }
    
    
    //cancel all the request
    func cancelAllRequest(){
        manager.operationQueue.cancelAllOperations()
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