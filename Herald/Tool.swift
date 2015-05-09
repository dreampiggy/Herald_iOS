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