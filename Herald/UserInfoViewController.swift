//
//  UserInfoViewController.swift
//  先声
//
//  Created by lizhuoli on 15/3/31.
//  Copyright (c) 2015年 WangShuo,Li Zhuoli. All rights reserved.
//

import UIKit

class UserInfoViewController: XHLoginViewController4,HttpProtocol {
    
    
    
    var httpController:HttpController = HttpController()
    
    var delegate:LoginProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.httpController.delegate = self
        
        self.navigationItem.title = "用户信息"
        
        var color = UIColor(red: 28/255, green: 150/255, blue: 111/255, alpha: 1)
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
        httpController.cancelAllRequest()
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
        else if self.cardPasswordField!.text.isEmpty || self.pePasswordField!.text.isEmpty || self.libraryPasswordFiled!.text.isEmpty || self.libraryUserField!.text.isEmpty
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
        if let studentID = Config.studentID{
            let parameter:NSDictionary = ["cardnum":Config.cardID!,"password":Config.cardPassword!,"number":Config.studentID!,"pe_password":pePasswordField.text,"lib_username":libraryUserField.text,"lib_password":libraryPasswordFiled.text,"card_query_password":cardPasswordField.text]
            self.httpController.postToURL("http://herald.seu.edu.cn/uc/update", parameter: parameter, tag: "userUpdate")
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
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        
        self.cardPasswordField.resignFirstResponder()
        self.pePasswordField.resignFirstResponder()
        self.libraryPasswordFiled.resignFirstResponder()
        self.libraryUserField.resignFirstResponder()
    }
    
    func getStudentNumFromJWC(){
        let tag = "getStudentNum"
        var parameter:NSDictionary = ["queryStudentId":Config.cardID ?? ""]
        let url = "http://xk.urp.seu.edu.cn/jw_service/service/stuCurriculum.action"
        httpController.postToURL(url, parameter: parameter, tag: tag)
    }
    
    
    func didReceiveStringResults(results: NSString, tag: String) {
        switch tag{
        case "userUpdate":
            if results == "OK"{
                Tool.showSuccessHUD("用户信息更新成功")
                back()
            }
            else{
                Tool.showErrorHUD("用户信息更新失败")
            }
        case "getStudentNum":
            let jwcRex:NSRegularExpression = NSRegularExpression(pattern: "学号:(\\w+)", options: NSRegularExpressionOptions.allZeros, error: nil)!
            let matchStudentNumber = jwcRex.firstMatchInString(results, options: NSMatchingOptions.allZeros, range: NSMakeRange(0, results.length))
            if (matchStudentNumber != nil){
                let matchResult = results.substringWithRange(matchStudentNumber!.range)
                let index = advance(matchResult.startIndex, 3)
                let finalStudentID = matchResult.substringFromIndex(index)
                Config.saveStudentID(finalStudentID)
            }
        default:break
        }
    }

}