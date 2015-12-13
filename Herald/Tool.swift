//
//  Tool.swift
//  先声
//
//  Created by Wangshuo on 14-8-5.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import Foundation

class Tool:NSObject
{
    static let sharedInstance = Tool()
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
    class func initNavigationAPI(VC:UIViewController) -> Bool{
        Config.sharedInstance.isNetworkRunning = CheckNetwork.doesExistenceNetwork()
        
        if Config.UUID == nil || Config.UUID!.isEmpty{
            Tool.showSuccessHUD("请在边栏的个人资料中补全您的信息")
        }
        else if !Config.sharedInstance.isNetworkRunning{
            Tool.showErrorHUD("貌似你没有联网哦")
        }
        else{
            return true
        }
        return false
    }
    
    // 判断推送是否开启
    static func notificationState() -> Bool {
        if #available(iOS 8.0, *) {
            if let type = UIApplication.sharedApplication().currentUserNotificationSettings()?.types {
                if type != UIUserNotificationType.None {
                    return true
                }
            }
        } else {
            let type = UIApplication.sharedApplication().enabledRemoteNotificationTypes()
            if type != UIRemoteNotificationType.None {
                return true
            }
        }
        
        return false
    }
    
    // 注册推送
    static func registerNotification() {
        if #available(iOS 8.0, *) {
            let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(settings)
            UIApplication.sharedApplication().registerForRemoteNotifications()
        } else {
            UIApplication.sharedApplication().registerForRemoteNotificationTypes([.Alert, .Badge, .Sound])
        }
    }
    
    // 注销推送
    static func unregisterNotifications() {
        guard let token = Config.token else {
            return
        }
        let API = HeraldAPI()
        API.sendAPI("removeToken", APIParameter: token)
        Config.removeToken()
        UIApplication.sharedApplication().unregisterForRemoteNotifications()
        Tool.showSuccessHUD("跑操注册已取消")
    }
    
    // 判断初次启动
    static func judgeFirstLaunch() -> Bool {
        if !NSUserDefaults.standardUserDefaults().boolForKey("firstLaunch") {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstLaunch")
            return true
        } else {
            return false
        }
    }
    
    // 3D Touch 传入的字符串来判断返回某个ViewController
    static func shortcutToViewController(type:String) -> UIViewController.Type {
        switch type {
        case "pe":
            return RunningViewController.self
        case "curriculum":
            return CurriculumViewController.self
        case "card":
            return SeuCardViewController.self
        case "nic":
            return NicViewController.self
        default: return UIViewController.self
        }
    }
    
    static let documentPath = NSSearchPathForDirectoriesInDomains(.DocumentationDirectory, .UserDomainMask, true)[0] + "/"
    static let libraryPath = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, .UserDomainMask, true)[0] + "/"
}