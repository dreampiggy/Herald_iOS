//
//  AppDelegate.swift
//  先声
//
//  Created by Wangshuo on 14-8-1.
//  Copyright (c) 2015 WangShuo,Li Zhuoli. All rights reserved.
//

import UIKit
import QuartzCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?


    var drawerController:MMDrawerController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        AFNetworkActivityIndicatorManager.sharedManager().enabled = true
        IQKeyboardManager.sharedManager().enable = true
        
        let leftSideDrawerViewController:LeftDrawerTableViewController = LeftDrawerTableViewController(nibName: "LeftDrawerTableViewController", bundle: nil)
        
        let centerViewController:CenterViewController = CenterViewController()
        
        let navigationController:CommonNavViewController = CommonNavViewController(rootViewController: centerViewController)
        
        // 定义左滑抽屉最大宽度
        let kMaximumLeftDrawerWidth:CGFloat = 260.0
        
        self.drawerController = MMDrawerController(centerViewController: navigationController, leftDrawerViewController: leftSideDrawerViewController)
        self.drawerController.setMaximumLeftDrawerWidth(kMaximumLeftDrawerWidth, animated:false, completion: nil)
        self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.All
        self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.rootViewController = self.drawerController
        self.window?.makeKeyAndVisible()
        
        //  收到远程推送通知后
        if let _ = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] {
            processPushNotification()
        }
        
        if Tool.judgeFirstLaunch() {
            Tool.registerNotification()
        }
        
        return true
    }
    
    //推送注册成功
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let token = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>")).stringByReplacingOccurrencesOfString(" ", withString: "")
        let api = HeraldAPI()
        api.sendAPI("regToken", APIParameter: token)
        Config.saveToken(token)
        Tool.showSuccessHUD("跑操推送注册成功")
        //服务端应将token存储在数据库中改，以备以后重复使用
    }
    
    //推送注册失败
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        Tool.showErrorHUD("跑操推送注册失败")
    }
    
    //  收到远程推送通知后
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        processPushNotification()
    }
    
    func processPushNotification() {
        //清除角标
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
        let navigationController = self.drawerController.centerViewController as? CommonNavViewController
        //确保当前不是显示的跑操VC
        guard !(navigationController?.topViewController is RunningViewController) else {
            return
        }
        let runningVC = RunningViewController(nibName: "RunningViewController", bundle: nil)
        navigationController?.pushViewController(runningVC, animated: true)
    }

}

