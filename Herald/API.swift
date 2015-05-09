//
//  API.swift
//  Herald
//
//  Created by lizhuoli on 15/5/9.
//  Copyright (c) 2015年 WangShuo. All rights reserved.
//

import Foundation

@objc protocol APIGetter{
    func getResult(APIName:String, results:AnyObject)
    func getError(APIName:String, statusCode:Int)
}

enum APIType{
    
}

class HeraldAPI:HttpProtocol{
    
    //先声公开API的appid
    var appid = "9f9ce5c3605178daadc2d85ce9f8e064"
    
    var delegate:APIGetter?
    var manager:AFHTTPRequestOperationManager
    
    init(){
        manager = AFHTTPRequestOperationManager()
    }
    
    func sendAPI(APIName:String, APIParameter:String...){
        
        let userURL = "http://herald.seu.edu.cn/uc/"
        let baseURL = "http://herald.seu.edu.cn/api/"
        let uuid = Config.UUID ?? ""
        let baseParameter:NSMutableDictionary = ["uuid":uuid]
        
        switch APIName{
        case "userLogin":
            let url = userURL + "auth"
            let parameter = baseParameter
            parameter.addEntriesFromDictionary(["user":APIParameter[0] ?? ""])
            parameter.addEntriesFromDictionary(["password":APIParameter[1] ?? ""])
            parameter.addEntriesFromDictionary(["appid":appid])
            self.postToURL(url, parameter: parameter, tag: APIName)
        case "userUpdate":
            let url = userURL + "update"
            let parameter = baseParameter
            parameter.addEntriesFromDictionary(["cardnum":Config.cardID ?? ""])
            parameter.addEntriesFromDictionary(["password":Config.cardPassword ?? ""])
            parameter.addEntriesFromDictionary(["number":Config.studentID ?? ""])
            parameter.addEntriesFromDictionary(["pe_password":APIParameter[0] ?? ""])
            parameter.addEntriesFromDictionary(["lib_username":APIParameter[1] ?? ""])
            parameter.addEntriesFromDictionary(["lib_password":APIParameter[2] ?? ""])
            parameter.addEntriesFromDictionary(["card_query_password":APIParameter[3] ?? ""])
            self.postToURL(url, parameter: parameter, tag: APIName)
        case "getStudentNum":
            let url = "http://xk.urp.seu.edu.cn/jw_service/service/stuCurriculum.action"
            let parameter:NSMutableDictionary = ["queryStudentId":Config.cardID ?? ""]
            self.postToURL(url, parameter: parameter, tag: APIName)
        case "simsimi":
            let url = baseURL + "simsimi"
            let parameter = baseParameter
            parameter.addEntriesFromDictionary(["msg":APIParameter[0] ?? ""])
            self.postToURL(url, parameter: parameter, tag: APIName)
        case "emptyRoom":
            let url = baseURL + "emptyroom"
            let parameter = baseParameter
            parameter.addEntriesFromDictionary(["arg1":APIParameter[0] ?? ""])
            parameter.addEntriesFromDictionary(["arg2":APIParameter[1] ?? ""])
            parameter.addEntriesFromDictionary(["arg3":APIParameter[2] ?? ""])
            parameter.addEntriesFromDictionary(["arg4":APIParameter[3] ?? ""])
            parameter.addEntriesFromDictionary(["arg5":APIParameter[4] ?? ""])
            self.postToURLAF(url, parameter: parameter, tag: APIName)
        case "pe":
            let url = baseURL + "pe"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: APIName)
        case "curriculum":
            let url = baseURL + "curriculum"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: APIName)
        case "jwc":
            let url = baseURL + "jwc"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: APIName)
        case "srtp":
            let url = baseURL + "srtp"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: APIName)
        case "nic":
            let url = baseURL + "nic"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: APIName)
        case "card":
            let url = baseURL + "card"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: APIName)
        case "cardDetail":
            let url = baseURL + "card"
            let parameter = baseParameter
            parameter.addEntriesFromDictionary(["timedelta":"30"])
            self.postToURLAF(url, parameter: parameter, tag: APIName)
        case "phylab":
            let url = baseURL + "phylab"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: APIName)
        case "lecture":
            let url = baseURL + "lecture"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: APIName)
        case "lectureNotice":
            let url = baseURL + "lecturenotice"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: APIName)
        case "searchBook":
            let url = baseURL + "search"
            let parameter = baseParameter
            parameter.addEntriesFromDictionary(["book":APIParameter[0]])
            self.postToURLAF(url, parameter: parameter, tag: APIName)
        case "library":
            let url = baseURL + "library"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: APIName)
        case "libraryRenew":
            let url = baseURL + "renew"
            let parameter = baseParameter
            parameter.addEntriesFromDictionary(["barcode":APIParameter[0]])
            self.postToURLAF(url, parameter: parameter, tag: APIName)
        case "schoolbus":
            let url = baseURL + "schoolbus"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: APIName)
        case "gpa":
            let url = baseURL + "gpa"
            let parameter = baseParameter
            self.postToURLAF(url, parameter: parameter, tag: APIName)
        default:
            break
        }
    }
    
    func didReceiveDicResults(results: NSDictionary, tag: String) {
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
        case "getStudentNum":
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
    
    //accept text/html with text contentType
    func postToURL(url:String,parameter:NSMutableDictionary,tag:String)
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
    func postToURLAF(url:String , parameter:NSMutableDictionary,tag:String)
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
    
    //cancel all the request
    func cancelAllRequest(){
        manager.operationQueue.cancelAllOperations()
    }
    
}