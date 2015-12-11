//
//  RestaurantViewController.swift
//  先声
//
//  Created by Wangshuo on 14-9-4.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet var tableView: UITableView!
    
    var dataList:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "外卖"
        
        let color = UIColor(red: 240/255, green: 100/255, blue: 25/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = color
        
        self.setupLeftMenuButton()
        
        
        let plistPath = NSBundle.mainBundle().pathForResource("TakeAway", ofType: "plist")
        self.dataList = NSArray(contentsOfFile: plistPath!)!
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
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cellIdentifier:String = "reuseIdentifier"
        
        var cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier)

        // Configure the cell...
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        }
        let row = indexPath.row
        
        
        
        cell!.textLabel?.text = self.dataList[row].objectForKey("name") as! NSString as String
        
        cell!.detailTextLabel?.text = self.dataList[row].objectForKey("addr") as! NSString as String
        
        cell!.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell!.detailTextLabel?.numberOfLines = 0

    
        cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        let imageName:NSString = self.dataList[row].objectForKey("image") as! NSString
        cell!.imageView?.image = UIImage(named: imageName as String)
        
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let passDataList:NSDictionary = self.dataList[indexPath.row] as! NSDictionary
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let restaurantDetailVC = RestaurantDetailViewController(nibName: "RestaurantDetailViewController", bundle: nil)
        restaurantDetailVC.dataList = passDataList
        
        self.navigationController!.pushViewController(restaurantDetailVC, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
