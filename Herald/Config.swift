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
    static let sharedInstance = Config()
    static let settings : NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var isNetworkRunning : Bool = false
    
    static var UUID:String? {
        let temp = settings.objectForKey("UUID") as? String
        return AESCrypt.decrypt(temp, password: "UUID")
    }
    
    static var studentID:String? {
        return settings.objectForKey("studentID") as? String
    }
    
    static var cardID:String? {
        return settings.objectForKey("cardID") as? String
    }
    
    static var cardPassword:String? {
        let temp = settings.objectForKey("cardPassword") as? String
        return AESCrypt.decrypt(temp, password: "cardPassword")
    }
    
    static var curriculum:NSDictionary? {
        return settings.objectForKey("curriculum") as? NSDictionary
    }
    
    static var GPA:NSArray? {
        return settings.objectForKey("GPA") as? NSArray
    }
    
    static var token:String? {
        return settings.objectForKey("token") as? String
    }
    
    static func saveUUID(var UUID:NSString) {
        settings.removeObjectForKey("UUID")
        UUID = AESCrypt.encrypt(UUID as String, password: "UUID")
        settings.setObject(UUID, forKey: "UUID")
        settings.synchronize()
    }
    
    
    static func saveStudentID(studentID:NSString) {
        settings.removeObjectForKey("studentID")
        settings.setObject(studentID, forKey: "studentID")
        settings.synchronize()
    }
    
    static func saveCardID(cardID:NSString) {
        settings.removeObjectForKey("cardID")
        settings.setObject(cardID, forKey: "cardID")
        settings.synchronize()
    }
    
    static func saveCardPassword(cardPassword:NSString) {
        settings.removeObjectForKey("cardPassword")
        let encodePassword = AESCrypt.encrypt(cardPassword as String, password: "cardPassword")
        settings.setObject(encodePassword, forKey: "cardPassword")
        settings.synchronize()
    }
    
    static func saveCurriculum(Curriculum:NSDictionary) {
        settings.removeObjectForKey("curriculum")
        settings.setObject(Curriculum, forKey: "curriculum")
        settings.synchronize()
    }
    
    static func saveGPA(GPA:NSArray) {
        settings.removeObjectForKey("GPA")
        settings.setObject(GPA, forKey: "GPA")
        settings.synchronize()
    }
    
    static func saveToken(token:String) {
        settings.removeObjectForKey("token")
        settings.setObject(token, forKey: "token")
        settings.synchronize()
    }
    
    
    static func removeUUID() {
        settings.removeObjectForKey("UUID")
        settings.synchronize()
    }
    
    static func removeStudentID() {
        settings.removeObjectForKey("studentID")
        settings.synchronize()
    }
    
    static func removeCardID() {
        settings.removeObjectForKey("cardID")
        settings.synchronize()
    }
    
    static func removeCardPassword() {
        settings.removeObjectForKey("cardPassword")
        settings.synchronize()
    }
    
    static func removeCurriculum() {
        settings.removeObjectForKey("curriculum")
        settings.synchronize()
    }
    
    static func removeGPA() {
        settings.removeObjectForKey("GPA")
        settings.synchronize()
    }
    
    static func removeToken() {
        settings.removeObjectForKey("token")
        settings.synchronize()
    }
}