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
        return 2
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section
        {
        case 0:
            return 2
        case 1:
            return 1
        default:
            print("error")
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
            switch indexPath.row
            {
            case 0:
                cell.textLabel?.text = "关于我们"
                cell.imageView?.image = UIImage(named: "AboutUs.png")
            case 1:
                cell.textLabel?.text = "联系我们"
                cell.imageView?.image = UIImage(named: "ContactMe.png")
            default:
                print("cell for row error")
            }
            
        case 1:
            switch indexPath.row
            {
            case 0:
                cell.textLabel?.text = "去Appstore评分"
                cell.imageView?.image = UIImage(named: "RateUs.png")

            default:
                print("cell for row error")
            }
        default:
            print("cell for row error")
            
        }
        
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        switch indexPath.section
            {
        case 0:
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
            default:
                print("cell for row error")
            }
            
        case 1:
            switch indexPath.row
                {
            case 0:
                self.rateUS()
                
            default:
                print("cell for row error")
            }
        default:
            print("cell for row error")
            
        }

    }
    
    
    func sendEmail()
    {
        if mailController != nil{
            self.mailController!.mailComposeDelegate = self
            self.mailController!.setToRecipients([NSString(string: "364987469@qq.com") as String])
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
        alert.message = "请在您的iPhone设置中设置您的邮箱"
        alert.addButtonWithTitle("好")
        alert.show()
    }
    
    func rateUS()
    {
        let storeProductVC = SKStoreProductViewController()
        storeProductVC.delegate = self
        
        Tool.showProgressHUD("正在打开Appstore")
        storeProductVC.loadProductWithParameters([SKStoreProductParameterITunesItemIdentifier:"871801426"], completionBlock: { (result:Bool, error :NSError?) -> Void in
            
            Tool.dismissHUD()
            self.presentViewController(storeProductVC, animated: true, completion: nil)
        })
    }
    
    func productViewControllerDidFinish(viewController: SKStoreProductViewController) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
