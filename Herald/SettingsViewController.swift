//
//  SettingsViewController.swift
//  Herald
//
//  Created by Wangshuo on 14-9-11.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit

class SettingsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate,SKStoreProductViewControllerDelegate{

    
    var mailController:MFMailComposeViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "设置"
        self.setupLeftMenuButton()
        if MFMailComposeViewController.canSendMail(){
            mailController = MFMailComposeViewController()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupLeftMenuButton()
    {
        let image = UIImage(named: "leftButton.png")
        let leftDrawerButton = UIButton(frame: CGRectMake(0, 0, 28, 28))
        leftDrawerButton.setBackgroundImage(image, forState: UIControlState.Normal)
        
        leftDrawerButton.addTarget(self, action: Selector("leftDrawerButtonPress:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        let leftButton:UIBarButtonItem = UIBarButtonItem(customView: leftDrawerButton)
        
        self.navigationItem.setLeftBarButtonItem(leftButton, animated: true)
    }
    
    func leftDrawerButtonPress(sender:AnyObject)
    {
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let a = UIScreen.mainScreen().bounds.size.width * 0.50
            print(a)
                        return a
        }
        else {
            return 44
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section
        {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 2
        case 3:
            return 1
        default:
            return 0
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier:String = "reuseIdentifier"
        
        var cell:UITableViewCell!  = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        
        // Configure the cell...
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        
        switch indexPath.section
        {
        case 0:
            switch indexPath.row {
            case 0:
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.imageView?.image = UIImage(named: "HeraldLogo.png")
            default: break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "更新API"
                cell.imageView?.image = UIImage(named: "AboutUs.png")
            case 1:
                cell.textLabel?.text = "跑操推送"
                cell.imageView?.image = UIImage(named: "AboutUs.png")
            default: break
            }
        case 2:
            switch indexPath.row
            {
            case 0:
                cell.textLabel?.text = "关于我们"
                cell.imageView?.image = UIImage(named: "AboutUs.png")
            case 1:
                cell.textLabel?.text = "联系我们"
                cell.imageView?.image = UIImage(named: "ContactMe.png")
            default: break
            }
            
        case 3:
            switch indexPath.row
            {
            case 0:
                cell.textLabel?.text = "去App Store评分"
                cell.imageView?.image = UIImage(named: "RateUs.png")

            default: break
                
            }
        default: break
            
            
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 0:
                updateAPI()
            case 1:
                enableAPN()
            default:
                return
            }
        case 2:
            switch indexPath.row
                {
            case 0:
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                let api = HeraldAPI()
                if let urlString = api.getValue("IndexURL"),url = NSURL(string: urlString) {
                    UIApplication.sharedApplication().openURL(url)
                }
            case 1:
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                self.sendEmail()
            default: break
            }
            
        case 3:
            switch indexPath.row
                {
            case 0:
                self.rateUS()
                
            default: break
            }
        default: break
        }
    }
    
    
    func sendEmail()
    {
        if mailController != nil{
            self.mailController!.mailComposeDelegate = self
            self.mailController!.setToRecipients([NSString(string: "244504762@qq.com") as String])
            self.mailController!.setSubject("给先声的建议")
            self.presentViewController(self.mailController!, animated: true, completion: nil)
        }
        else{
            showAlert()
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showAlert() {
        let alert = UIAlertView()
        alert.title = "提醒"
        alert.delegate = self
        alert.message = "请在\"设置->邮件\"中设置您的邮箱"
        alert.addButtonWithTitle("好")
        alert.show()
    }
    
    func updateAPI() {
        let api = HeraldAPI.sharedInstance
        let plistPath = NSBundle.mainBundle().pathForResource("APIList", ofType: "plist") ?? ""
        if let currentVersion = api.getValue("Version"), url = api.getValue("UpdateURL") {
            
            api.manager.GET(url, parameters: ["version": currentVersion], success: {(operation :AFHTTPRequestOperation!,responseObject :AnyObject!) ->Void in
                if let data = responseObject as? NSData, string = NSString(data: data,encoding: NSUTF8StringEncoding) {
                    do {
                        try string.writeToFile(plistPath, atomically: true, encoding: NSUTF8StringEncoding)
                        Tool.showSuccessHUD("更新成功")
                    } catch {
                        Tool.showErrorHUD("更新API列表失败T.T，请稍候再次重试")
                    }
                }
            }, failure: {(operation :AFHTTPRequestOperation?, error :NSError) ->Void in
                    
                    if let code = operation?.response?.statusCode {
                        if (code == 303) {
                            Tool.showSuccessHUD("已经是最新的列表")
                            return
                        }
                    }
                Tool.showErrorHUD("服务器可能正忙，请稍后再次重试")
            })
        }
    }
    
    func enableAPN() {
        guard let token = Config.token else {
            Tool.showErrorHUD("请在\"设置\"->\"通知\"->\"先声\"中打开推送通知")
            return
        }
        let api = HeraldAPI.sharedInstance
        guard let url = api.getValue("APNURL") else {
            Tool.showErrorHUD("获取API列表出错，可能是服务器正忙。请先尝试重新更新API")
            return
        }
        api.postRequest(url, parameter: ["token": token], tag: "token")
        Tool.showSuccessHUD("远程推送注册成功!")
        Config.saveToken(token)
    }
    
    func rateUS()
    {
        let storeProductVC = SKStoreProductViewController()
        storeProductVC.delegate = self
        
        Tool.showProgressHUD("正在打开App Store……")
        storeProductVC.loadProductWithParameters([SKStoreProductParameterITunesItemIdentifier:"871801426"], completionBlock: { (result:Bool, error :NSError?) -> Void in
            
            Tool.dismissHUD()
            self.presentViewController(storeProductVC, animated: true, completion: nil)
        })
    }
    
    func productViewControllerDidFinish(viewController: SKStoreProductViewController) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
