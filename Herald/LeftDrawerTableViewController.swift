//
//  LeftDrawerTableViewController.swift
//  先声
//
//  Created by Wangshuo on 14-8-2.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

//let NIC = 666



class LeftDrawerTableViewController: UITableViewController,LoginProtocol {
        
    @IBOutlet var headView: UIView?
    
    var navMainPageViewController : CommonNavViewController?
    var navSchoolLifeViewController: CommonNavViewController?
    var navLibraryViewController: CommonNavViewController?
    var navTakeAwayViewController : CommonNavViewController?
    var navTreeHoleViewController: CommonNavViewController?
    var navSimSimiViewController : CommonNavViewController?
    var navSettingsViewController: CommonNavViewController?
    
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableHeaderView = headView
        let color = UIColor(red: 156/255, green: 187/255, blue: 216/255, alpha: 1)
        self.tableView.backgroundColor = color
        if (Config.UUID != nil && Config.UUID != ""){
            self.welcomeLabel.text = "欢迎回来"
        }
        else{
            self.welcomeLabel.text = "请先登录"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginSuccess(tag: NSString) {
        switch tag
        {
        case "NICLogin":
            self.welcomeLabel.text = "欢迎回来"
        default:
            break
        }
    }
    
    func logoutSuccess(tag: NSString) {
        
        switch tag
        {
        case "NICLogout":
            self.welcomeLabel.text = "请先登录"
        default:
            break
        }
    }
    
    @IBAction func clickLoginButton(sender: UIButton)
    {
        let NICloginVC : NICLoginViewController = NICLoginViewController()
        NICloginVC.delegate = self
    
        let NICNavVC :CommonNavViewController = CommonNavViewController(rootViewController: NICloginVC)
       
        self.presentViewController(NICNavVC, animated: true, completion: nil)
        
    }
    
    @IBAction func clickInfoButton(sender: UIButton) {
        let UserInfoVC : UserInfoViewController = UserInfoViewController()
        UserInfoVC.delegate = self
        
        let UserNavVC :CommonNavViewController = CommonNavViewController(rootViewController: UserInfoVC)
        
        self.presentViewController(UserNavVC, animated: true, completion: nil)
    }
    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        // Return the number of rows in the section.
        return 6
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        
        let cellIdentifier:String = "reuseIdentifier"
   
        var cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier)

        
        // Configure the cell...
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        
        let color = UIColor(red: 156/255, green: 187/255, blue: 216/255, alpha: 1)
        cell!.backgroundColor = color
        
        switch indexPath.row
        {
        case 0:
            cell!.textLabel?.text = "主页"
            cell!.textLabel?.textColor = UIColor.whiteColor()
            cell!.imageView?.image = UIImage(named: "Side_MainPage.png")
            
        case 1:
            cell!.textLabel?.text = "校园生活"
            cell!.textLabel?.textColor = UIColor.whiteColor()
            cell!.imageView?.image = UIImage(named: "Side_SchoolLife.png")
            
        case 2:
            cell!.textLabel?.text = "图书馆"
            cell!.textLabel?.textColor = UIColor.whiteColor()
            cell!.imageView?.image = UIImage(named: "Side_Library.png")
            
        case 3:
            cell!.textLabel?.text = "外卖"
            cell!.textLabel?.textColor = UIColor.whiteColor()
            cell!.imageView?.image = UIImage(named: "Side_TakeOut.png")
            
        case 4:
            cell!.textLabel?.text = "东大小黄鸡"
            cell!.textLabel?.textColor = UIColor.whiteColor()
            cell!.imageView?.image = UIImage(named: "Side_Simsimi.png")
            
        case 5:
            cell!.textLabel?.text = "设置"
            cell!.textLabel?.textColor = UIColor.whiteColor()
            cell!.imageView?.image = UIImage(named: "Side_Settings.png")

            
        default:
            break
        }
        

        return cell!
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        switch indexPath.row
        {
            
        case 0:
        
            if self.navMainPageViewController == nil
            {
                let mainPageViewController:CenterViewController = CenterViewController()
                self.navMainPageViewController = CommonNavViewController(rootViewController: mainPageViewController)
            }
            
            self.mm_drawerController.setCenterViewController(self.navMainPageViewController, withCloseAnimation: true, completion: nil)
            
        
        case 1:
            
            if self.navSchoolLifeViewController == nil
            {
                let schoolLifeViewController:SchoolLifeViewController = SchoolLifeViewController(nibName: "SchoolLifeViewController", bundle: nil)
                self.navSchoolLifeViewController = CommonNavViewController(rootViewController: schoolLifeViewController)
            }
            
            self.mm_drawerController.setCenterViewController(self.navSchoolLifeViewController, withCloseAnimation: true, completion: nil)
 
        case 2:
            if self.navLibraryViewController == nil
            {
                let LibraryVC = LibraryViewController(nibName: "LibraryViewController", bundle: nil)
                self.navLibraryViewController = CommonNavViewController(rootViewController: LibraryVC)
            }
            
            self.mm_drawerController.setCenterViewController(self.navLibraryViewController, withCloseAnimation: true, completion: nil)
            
        case 3:
            
            if self.navTakeAwayViewController == nil
            {
                let takeAwayVC = RestaurantViewController(nibName: "RestaurantViewController", bundle: nil)
                
                self.navTakeAwayViewController = CommonNavViewController(rootViewController: takeAwayVC)
            }
            
            self.mm_drawerController.setCenterViewController(self.navTakeAwayViewController, withCloseAnimation: true, completion: nil)
            
        case 4:
            
            if self.navSimSimiViewController == nil
            {
                let simsimiVC = SimSimiViewController(nibName: "SimSimiViewController", bundle: nil)
                self.navSimSimiViewController = CommonNavViewController(rootViewController: simsimiVC)
            }
            
            self.mm_drawerController.setCenterViewController(self.navSimSimiViewController, withCloseAnimation: true, completion: nil)
        
        case 5 :
            
            if self.navSettingsViewController == nil
            {
                let settingsVC = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
                self.navSettingsViewController = CommonNavViewController(rootViewController: settingsVC)
            }
            
            self.mm_drawerController.setCenterViewController(self.navSettingsViewController, withCloseAnimation: true, completion: nil)
        default:
            break
            
        }
    }
    
}
