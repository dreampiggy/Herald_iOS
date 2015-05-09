//
//  HttpController.swift
//  先声
//
//  Created by Wangshuo on 14-8-1.
//  Copyright (c) 2015年 WangShuo,Li Zhuoli. All rights reserved.
//

import Foundation
import UIKit

@objc protocol HttpProtocol
{
    optional func didReceiveDicResults(results:NSDictionary,tag:String)
    optional func didReceiveArrayResults(results:NSArray,tag:String)
    optional func didReceiveStringResults(results:NSString,tag:String)
    optional func didReceiveDataResults(results:NSData,tag:String)
    optional func didReceiveErrorResult(code:Int,tag:String)
}

class HttpController:NSObject
{
    var delegate:HttpProtocol?
    
    var manager:AFHTTPRequestOperationManager
    
    override init(){
        manager = AFHTTPRequestOperationManager()
    }
    
    func requestFromURLAF(url:String,tag:String)
    {
    
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html")
        
        manager.GET(url, parameters: nil, success:
            {(operation :AFHTTPRequestOperation!, responseObject :AnyObject!) -> Void in
                
            self.delegate?.didReceiveArrayResults?(responseObject as NSArray,tag:tag)
            self.delegate?.didReceiveDicResults?(responseObject as NSDictionary,tag:tag)
            self.delegate?.didReceiveDataResults?(responseObject as NSData,tag:tag)
            self.delegate?.didReceiveStringResults?(responseObject as NSString,tag:tag)
            }
            , failure:
            {(operation :AFHTTPRequestOperation!, error :NSError!) -> Void in
                
            }
        )
    }
    

    
    func requestFromURLAFjson(url:String,tag:String)
    {
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json")
        
        manager.GET(url, parameters: nil, success:
            {(operation :AFHTTPRequestOperation!, responseObject :AnyObject!) -> Void in
                
                self.delegate?.didReceiveArrayResults?(responseObject as NSArray,tag:tag)
                self.delegate?.didReceiveDicResults?(responseObject as NSDictionary,tag:tag)
                self.delegate?.didReceiveDataResults?(responseObject as NSData,tag:tag)
                self.delegate?.didReceiveStringResults?(responseObject as NSString,tag:tag)
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
        
        self.delegate?.didReceiveStringResults?(results,tag:tag)
        
    }
    
    //accept text/html with text contentType
    func postToURL(url:String,parameter:NSDictionary,tag:String)
    {
//        println("a post come!")
//        println(parameter)
//        println("ok")
        let nsurl:NSURL = NSURL(string: url)!
        
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html")
        manager.POST(url, parameters: parameter,
            success: {(operation :AFHTTPRequestOperation!,responseObject :AnyObject!) ->Void in
//                println("\n<Raw>***********\n")
//                println(responseObject)
//                println("\n</Raw>***********\n")
                var receiveData = responseObject as NSData
                var receiveString = NSString(data: receiveData,encoding: NSUTF8StringEncoding)//use utf-8 to decode nsdata
                
                self.delegate?.didReceiveDicResults?(responseObject as NSDictionary,tag:tag)
                self.delegate?.didReceiveArrayResults?(responseObject as NSArray, tag:tag)
                self.delegate?.didReceiveDataResults?(receiveData,tag:tag)
                self.delegate?.didReceiveStringResults?(receiveString ?? "", tag:tag)
            },
            failure: {(operation :AFHTTPRequestOperation!, error :NSError!) ->Void in
                var codeStatue = 500
                if(operation.response != nil){
                    var codeStatue:Int = operation.response.statusCode
                }
                self.delegate?.didReceiveErrorResult?(codeStatue, tag: tag)
//                println(error)
            }
        )
    }
    
    //accept text/html with json contentType
    func postToURLAF(url:String , parameter:NSDictionary,tag:String)
    {
//        println("a post to json come!")
//        println(parameter)
//        println("ok")
        let nsurl:NSURL = NSURL(string: url)!
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/html")
        manager.POST(url, parameters: parameter,
            success: {(operation :AFHTTPRequestOperation!,responseObject :AnyObject!) ->Void in
//                println("\n<Raw>***********\n")
//                println(responseObject)
//                println("\n</Raw>***********\n")
                self.delegate?.didReceiveDicResults?(responseObject as NSDictionary,tag:tag)
                self.delegate?.didReceiveArrayResults?(responseObject as NSArray, tag:tag)
                self.delegate?.didReceiveDataResults?(responseObject as NSData,tag:tag)
                self.delegate?.didReceiveStringResults?(responseObject as NSString,tag:tag)
            },
            failure: {(operation :AFHTTPRequestOperation!, error :NSError!) ->Void in
                var codeStatue = 500
                if(operation.response != nil){
                    var codeStatue:Int = operation.response.statusCode
                }
                self.delegate?.didReceiveErrorResult?(codeStatue, tag: tag)
//                println(error)
            }
        )
    }
    
    //accept application/json with json contentType
    func postToURLAFjson(url:String , parameter:NSDictionary,tag:String)
    {
        let nsurl:NSURL = NSURL(string: url)!
        
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "application/json")
        manager.POST(url, parameters: parameter, success: {(operation :AFHTTPRequestOperation!, responseObject :AnyObject!) -> Void in
            
            self.delegate?.didReceiveArrayResults?(responseObject as NSArray,tag:tag)
            self.delegate?.didReceiveDataResults?(responseObject as NSData,tag:tag)
            self.delegate?.didReceiveStringResults?(responseObject as NSString,tag:tag)
            
            
            }, failure: {(operation :AFHTTPRequestOperation!, error :NSError!) -> Void in
                
            }
        )
    }
    
    //cancel all the request
    func cancelAllRequest()
    {
        manager.operationQueue.cancelAllOperations()
    }
}
