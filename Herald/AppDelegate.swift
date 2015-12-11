//
//  AppDelegate.swift
//  先声
//
//  Created by Wangshuo on 14-8-1.
//  Copyright (c) 2015 WangShuo,Li Zhuoli. All rights reserved.
//

import UIKit
import QuartzCore


let kMaximumLeftDrawerWidth:CGFloat = 260.0

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
        
        self.drawerController = MMDrawerController(centerViewController: navigationController, leftDrawerViewController: leftSideDrawerViewController)
        self.drawerController.setMaximumLeftDrawerWidth(kMaximumLeftDrawerWidth, animated:false, completion: nil)
        self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.All
        self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.rootViewController = self.drawerController
        self.window?.makeKeyAndVisible()
        
        
        //注册APN
        if Config.token == nil {
            if #available(iOS 8.0, *) {
                let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
                UIApplication.sharedApplication().registerUserNotificationSettings(settings)
                UIApplication.sharedApplication().registerForRemoteNotifications()
            } else {
                UIApplication.sharedApplication().registerForRemoteNotificationTypes([.Alert, .Badge, .Sound])
            }
        }
        
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let token = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>")).stringByReplacingOccurrencesOfString(" ", withString: "")
        let api = HeraldAPI.sharedInstance
        guard let url = api.getValue("APNURL") else {
            return
        }
        api.postRequest(url, parameter: ["token": token], tag: "token")
        Config.saveToken(token)
        print("远程推送注册成功!\(deviceToken)")
        //服务端应将token存储在数据库中改，以备以后重复使用
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("远程推送注册失败!\(error)")
    }
    
    //  收到远程推送通知后，这个是普通的推送（不额外发出请求）
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        let runningVC = RunningViewController(nibName: "RunningViewController", bundle: nil)
        
        self.window?.rootViewController?.navigationController?.pushViewController(runningVC, animated: true)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

