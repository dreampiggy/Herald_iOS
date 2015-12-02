//
//  UserInfoViewController.swift
//  先声
//
//  Created by lizhuoli on 15/3/31.
//  Copyright (c) 2015年 WangShuo,Li Zhuoli. All rights reserved.
//

import UIKit

class UserInfoViewController: XHLoginViewController4,APIGetter {
    
    var delegate:LoginProtocol?
    
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.API.delegate = self
        self.navigationItem.title = "用户信息"
        
        let color = UIColor(red: 28/255, green: 150/255, blue: 111/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = color
        
        let backButton:UIBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("back"))
        self.navigationItem.leftBarButtonItem = backButton
        let navSubmitButton:UIBarButtonItem = UIBarButtonItem(title: "提交", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("submit"))
        self.navigationItem.rightBarButtonItem = navSubmitButton
        
        self.submitButton.addTarget(self, action: Selector("submit"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.cardPasswordField.secureTextEntry = true
        self.pePasswordField.secureTextEntry = true
        self.libraryPasswordFiled.secureTextEntry = true
        
        if (Config.UUID == nil || Config.UUID == "") {
            Tool.showErrorHUD("你还没有登录哦")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            getStudentNumFromJWC()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        API.cancelAllRequest()
    }
    
    func submit()
    {
        self.cardPasswordField.resignFirstResponder()
        self.pePasswordField.resignFirstResponder()
        self.libraryPasswordFiled.resignFirstResponder()
        self.libraryUserField.resignFirstResponder()
        
        
        Config.shareInstance().isNetworkRunning = CheckNetwork.doesExistenceNetwork()
        
        if !Config.shareInstance().isNetworkRunning
        {
            Tool.showErrorHUD("请检查网络连接")
        }
        else if self.cardPasswordField!.text == nil || self.pePasswordField!.text == nil || self.libraryPasswordFiled!.text == nil || self.libraryUserField!.text == nil
        {
            Tool.showErrorHUD("要输入完整的信息哦")
        }
        else
        {
            Tool.showProgressHUD("正在提交用户信息")
            sendAPI()
        }
    }
    
    func sendAPI(){
        if Config.studentID != nil {
            let pePassword = pePasswordField.text ?? ""
            let libraryUser = libraryUserField.text ?? ""
            let libraryPassword = libraryPasswordFiled.text ?? ""
            let cardPassword = cardPasswordField.text ?? ""
            API.sendAPI("userUpdate", APIParameter: Config.cardID ?? "",Config.cardPassword ?? "",Config.studentID ?? "",pePassword,libraryUser,libraryPassword,cardPassword)
        }
        else{
            Tool.showErrorHUD("服务器忙碌中……请稍候重试")
        }
    }
    
    func back()
    {
        self.cardPasswordField.resignFirstResponder()
        self.pePasswordField.resignFirstResponder()
        self.libraryPasswordFiled.resignFirstResponder()
        self.libraryUserField.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        
        self.cardPasswordField.resignFirstResponder()
        self.pePasswordField.resignFirstResponder()
        self.libraryPasswordFiled.resignFirstResponder()
        self.libraryUserField.resignFirstResponder()
    }
    
    func getStudentNumFromJWC(){
        API.sendAPI("getStudentNum", APIParameter: Config.cardID ?? "")
    }
    
    func getResult(APIName: String, results: JSON) {
        let results = results.stringValue as NSString
        switch APIName{
        case "userUpdate":
            if results == "OK"{
                Tool.showSuccessHUD("用户信息更新成功")
                back()
            }
            else{
                Tool.showErrorHUD("用户信息更新失败")
            }
        case "getStudentNum":
            let jwcRex:NSRegularExpression = try! NSRegularExpression(pattern: "学号:(\\w+)", options: NSRegularExpressionOptions())
            let matchStudentNumber = jwcRex.firstMatchInString(results as String, options: NSMatchingOptions(), range: NSMakeRange(0, results.length))
            if (matchStudentNumber != nil){
                let matchResult = results.substringWithRange(matchStudentNumber!.range)
                let index = matchResult.startIndex.advancedBy(3)
                let finalStudentID = matchResult.substringFromIndex(index)
                Config.saveStudentID(finalStudentID)
            }
        default:break
        }
    }
    
    func getError(APIName: String, statusCode: Int) {
        Tool.showErrorHUD("用户信息更新失败")
    }

}