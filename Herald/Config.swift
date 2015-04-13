//
//  Config.swift
//  先声
//
//  Created by Wangshuo on 14-8-4.
//  Copyright (c) 2015年 WangShuo,Li Zhuoli. All rights reserved.
//

import Foundation


class Config:NSObject
{
    var isNetworkRunning : Bool = false

    class var UUID:String?
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //decode
        var temp = settings.objectForKey("UUID") as? String
        return AESCrypt.decrypt(temp, password: "UUID")
    }
    
    class var studentID:String?
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        return settings.objectForKey("studentID") as? String
    }

    class var cardID:String?
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        return settings.objectForKey("cardID") as? String
    }
    
    class var cardPassword:String?
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var temp = settings.objectForKey("cardPassword") as? String
        return AESCrypt.decrypt(temp, password: "cardPassword")
    }
    
    class var curriculum:NSDictionary?
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        return settings.objectForKey("curriculum") as? NSDictionary
    }

    class var GPA:NSArray?
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        return settings.objectForKey("GPA") as? NSArray
    }
    
    class func shareInstance()->Config{
        struct YRSingleton{
            static var predicate:dispatch_once_t = 0
            static var instance:Config? = nil
            
        }
        dispatch_once(&YRSingleton.predicate,{
            YRSingleton.instance=Config()
            }
        )
        return YRSingleton.instance!
    }
    
    
    class func saveUUID(var UUID:NSString)
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        settings.removeObjectForKey("UUID")
        //encode
        UUID = AESCrypt.encrypt(UUID, password: "UUID")
        
        settings.setObject(UUID, forKey: "UUID")
        settings.synchronize()
    }
    
    
    class func saveStudentID(studentID:NSString)
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        settings.removeObjectForKey("studentID")
        
        settings.setObject(studentID, forKey: "studentID")
        settings.synchronize()
    }
    
    class func saveCardID(cardID:NSString)
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        settings.removeObjectForKey("cardID")
        
        settings.setObject(cardID, forKey: "cardID")
        settings.synchronize()
    }
    
    class func saveCardPassword(cardPassword:NSString)
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        settings.removeObjectForKey("cardPassword")
        var encodePassword = AESCrypt.encrypt(cardPassword, password: "cardPassword")        
        settings.setObject(encodePassword, forKey: "cardPassword")
        settings.synchronize()
    }
    
    class func saveCurriculum(Curriculum:NSDictionary)
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        settings.removeObjectForKey("curriculum")
        settings.setObject(Curriculum, forKey: "curriculum")
        settings.synchronize()
    }

    class func saveGPA(GPA:NSArray)
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        settings.removeObjectForKey("GPA")
        settings.setObject(GPA, forKey: "GPA")
        settings.synchronize()
    }
    
    class func removeUUID()
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        settings.removeObjectForKey("UUID")
        settings.synchronize()
    }
    
    class func removeStudentID()
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        settings.removeObjectForKey("studentID")
        settings.synchronize()
    }
    
    class func removeCardID()
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        settings.removeObjectForKey("cardID")
        settings.synchronize()
    }
    
    class func removeCardPassword()
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        settings.removeObjectForKey("cardPassword")
        settings.synchronize()
    }
    
    class func removeCurriculum()
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        settings.removeObjectForKey("curriculum")
        settings.synchronize()
    }
    
    class func removeGPA()
    {
        let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        settings.removeObjectForKey("GPA")
        settings.synchronize()
    }
}