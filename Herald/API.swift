//
//  API.swift
//  Herald
//
//  Created by lizhuoli on 15/5/9.
//  Copyright (c) 2015年 WangShuo. All rights reserved.
//

import Foundation

protocol APIGetter{
    func getResult(APIName:String, results:JSON)
    func getError(APIName:String, statusCode:Int)
}

class HeraldAPI{
    //先声公开API的appid
    let appid = "9f9ce5c3605178daadc2d85ce9f8e064"
    
    //代理模式，在VC使用的时候实例化一个代理，即let API = HeraldAPI(); API.delegate = self
    var delegate:APIGetter?
    
    //manager是AFNetworking的一个管理者，需要首先初始化一个
    var manager = AFHTTPRequestOperationManager()
    
    //plist是APIList.plist的根字典
    var plist:NSDictionary?
    
    //apiList是从APIList.plist中API List的字典，存储API的URL，Query等记录
    var apiList:NSDictionary?
    
    init(){
        let file = NSFileManager.defaultManager()
        
        var plistPath = Tool.libraryPath + "APIList.plist"
        if !file.fileExistsAtPath(plistPath) {
            let bundle = NSBundle.mainBundle()
            plistPath = bundle.pathForResource("APIList", ofType: "plist") ?? ""
        }
        
        if let plistContent = NSDictionary(contentsOfFile: plistPath){
            plist = plistContent
            apiList = plistContent["API List"] as? NSDictionary
        }
    }
    
    //单独获取属性表的根路径下的Key对应的值
    func getValue(key:String) -> String? {
        return plist?[key] as? String ?? nil
    }
    
    func sendAPI(APIName:String, APIParameter:String...){
        //发送API，要确保APIParameter数组按照API Info.plist表中规定的先后顺序
        if apiList == nil{
            return;
        }
        let uuid = Config.UUID ?? ""
        if let apiName = apiList?[APIName] as? NSDictionary{
            let apiURL = apiName["URL"] as? String ?? ""
            let apiParamArray = apiName["Param"] as? [String] ?? ["uuid"]//从API列表中读到的参数列表
            var apiParameter = APIParameter//方法调用的传入参数列表
            
            for param in apiParamArray{
                if param == "uuid"{
                    apiParameter.append(uuid)
                    break
                }
                if param == "appid"{
                    apiParameter.append(appid)
                    break
                }
            }
            
            let apiParamDic = NSDictionary(objects: apiParameter, forKeys: apiParamArray)//将从plist属性表中的读取到的参数数的值作为key，将方法传入的参数作为value，传入要发送的参数字典
            self.postRequest(apiURL, parameter: apiParamDic, tag: APIName)
        }
    }
    
    //对请求结果进行代理
    func didReceiveResults(results: AnyObject, tag: String){
        let json = JSON(results)//一个非常好的东西，能方便操作JSON，甚至对不是JSON格式（比如字符串，数组），保留了这个类型本身
        self.delegate?.getResult(tag, results: json)
    }
    
    //对错误进行代理
    func didReceiveError(code: Int, tag: String) {
        self.delegate?.getError(tag, statusCode: code)
    }
    
    //POST请求，接收MIME类型为text/html，只处理非JSON返回格式的数据
    func postRequest(url:String,parameter:NSDictionary,tag:String)
    {
        print("\nRequest:\n\(parameter)\n***********\n")
        
        manager.responseSerializer = AFHTTPResponseSerializer()//使用自定义的Serializer，手动对返回数据进行判断
        manager.POST(url, parameters: parameter,
            success: {(operation :AFHTTPRequestOperation!,responseObject :AnyObject!) ->Void in
                if let receiveData = responseObject as? NSData{
                    //按照NSDictionary -> NSArray -> NSString的顺序进行过滤
                    if let receiveDic = (try? NSJSONSerialization.JSONObjectWithData(receiveData, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary{
                        print("\nResponse(Dictionary):\n\(receiveDic)\n***********\n")
                        if let statusCode = receiveDic["code"] as? Int {//部分API状态码虽然为200，但是返回content为空，code为500
                            if statusCode == 200{
                                self.didReceiveResults(receiveDic, tag: tag)
                            }
                            else{
                                self.didReceiveError(500, tag: tag)
                            }
                        }
                        else{
                            self.didReceiveResults(receiveDic, tag: tag)
                        }
                    }
                    else if let receiveArray = (try? NSJSONSerialization.JSONObjectWithData(receiveData, options: NSJSONReadingOptions.MutableContainers)) as? NSArray{
                        print("\nResponse(Array):\n\(receiveArray)\n***********\n")
                        self.didReceiveResults(receiveArray, tag: tag)
                    }
                    else if let receiveString = NSString(data: receiveData,encoding: NSUTF8StringEncoding){
                        print("\nResponse(String):\n\(receiveString)\n***********\n")
                        self.didReceiveResults(receiveString, tag: tag)
                    }//默认使用UTF-8编码
                    else{
                        self.didReceiveError(500, tag: tag)
                    }
                }
            },
            failure: {(operation :AFHTTPRequestOperation?, error :NSError) ->Void in
                var codeStatue = 500//默认错误HTTP状态码为500
                if let code = operation?.response?.statusCode {
                    codeStatue = code
                }
                self.didReceiveError(codeStatue, tag: tag)
                print(error)
            }
        )
    }
    
    //取消所有请求
    func cancelAllRequest(){
        manager.operationQueue.cancelAllOperations()
    }
}