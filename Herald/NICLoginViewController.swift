//
//  NICLoginViewController.swift
//  先声
//
//  Created by Wangshuo on 14-8-5.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit


protocol LoginProtocol
{
    func loginSuccess(tag:NSString)
    func logoutSuccess(tag:NSString)
}




class NICLoginViewController: XHLoginViewController3 ,HttpProtocol{

    //先声公开API的appid
    var appid = "9f9ce5c3605178daadc2d85ce9f8e064"

    var delegate:LoginProtocol?
    
    var httpController:HttpController = HttpController()
    
    var screenSize:CGSize = UIScreen.mainScreen().bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.httpController.delegate = self
        
        self.navigationItem.title = "信息门户验证"
        
        let backButton:UIBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("back"))
        self.navigationItem.leftBarButtonItem = backButton
        
        if Config.UUID!.isEmpty{
            let navLoginButton:UIBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("login"))
            self.navigationItem.rightBarButtonItem = navLoginButton
        }
        else{
            let navLogoutButton:UIBarButtonItem = UIBarButtonItem(title: "注销", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("logout"))
            self.navigationItem.rightBarButtonItem = navLogoutButton
        }
        
        var color = UIColor(red: 28/255, green: 150/255, blue: 111/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = color
        
        self.loginButton.addTarget(self, action: Selector("login"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.logoutButton.addTarget(self, action: Selector("logout"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.usernameField.placeholder = "一卡通号"
        self.passwordField.placeholder = "统一认证密码"

        self.passwordField.secureTextEntry = true

    }

    override func viewWillDisappear(animated: Bool) {
        httpController.cancelAllRequest()
    }
    
    
    func back()
    {
        self.usernameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func login()
    {
        self.usernameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        
        
        
        Config.shareInstance().isNetworkRunning = CheckNetwork.doesExistenceNetwork()
        
        if !Config.shareInstance().isNetworkRunning
        {
            Tool.showErrorHUD("请检查网络连接")
        }
        else if self.usernameField!.text.isEmpty || self.passwordField!.text.isEmpty
        {
            Tool.showErrorHUD("请输入一卡通和统一认证密码")
        }
        else
        {
            Tool.showProgressHUD("正在验证信息门户信息")
            let parameter:NSDictionary = ["user":self.usernameField!.text,"password":self.passwordField!.text,"appid":appid]
            self.httpController.postToURL("http://herald.seu.edu.cn/uc/auth", parameter: parameter, tag: "NICLogin")
        }
    }
    
    
    func logout()
    {
        if let checkCardID = Config.cardID{
            if checkCardID == usernameField.text{
                Config.removeUUID()
                Config.removeCardID()
                Config.removeCardPassword()
                Tool.showSuccessHUD("注销成功")
                self.delegate?.logoutSuccess("NICLogout")
                back()
            }
            else{
                Tool.showErrorHUD("一卡通错误,注销失败")
            }
        }
        else{
            Tool.showErrorHUD("一卡通错误,注销失败")
            Config.removeUUID()
            Config.removeCardID()
        }
    }
    
    // 触摸其他地方的时候  隐藏键盘
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        
        self.usernameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
    }
    func didReceiveErrorResult(code: Int, tag: String) {
        Tool.showErrorHUD("一卡通认证失败，请重新确认")
    }
    
    func didReceiveDataResults(results: NSData, tag: String)
    {
        Tool.showSuccessHUD("登录成功!\n新用户请点击\"个人资料\"")
        let returnUUID = NSString(data: results, encoding: NSUTF8StringEncoding)
        let returnCardID = usernameField.text
        let returnPassword = passwordField.text
        Config.saveUUID(returnUUID!)
        Config.saveCardID(returnCardID)
        Config.saveCardPassword(returnPassword)
        self.delegate?.loginSuccess("NICLogin")
        back()
    }

}
