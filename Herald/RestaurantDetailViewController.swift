//
//  RestaurantDetailViewController.swift
//  Herald
//
//  Created by Wangshuo on 14-9-13.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController,MLLinkLabelDelegate,SKSTableViewDelegate {

    
    var dataList:NSDictionary!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var addressLabel: UILabel!
    
    @IBOutlet var contactLabel: MLLinkLabel!
    
    
    @IBOutlet var lowestPriceLabel: UILabel!
    
    
    @IBOutlet var tableView: SKSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = self.dataList.objectForKey("name") as! NSString as String
        
        let barButton = UIBarButtonItem(title: "收起展开", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("collapse"))
        self.navigationItem.rightBarButtonItem = barButton
        
        
        let imageName:NSString = self.dataList.objectForKey("bigImage") as! NSString
        self.imageView.image = UIImage(named: imageName as String)
        
        self.addressLabel.text = self.dataList.objectForKey("addr") as! NSString as String
        self.addressLabel.numberOfLines = 0
        self.addressLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        self.contactLabel.text = self.dataList.objectForKey("contact") as! NSString as String
        self.contactLabel.delegate = self
        self.contactLabel.numberOfLines = 0
        self.contactLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        self.lowestPriceLabel.text = self.dataList.objectForKey("lowestPrice") as! NSString as String
        
        
        self.tableView.SKSTableViewDelegate = self
    }
    
    func collapse()
    {
        self.tableView.collapseCurrentlyExpandedIndexPaths()
    }
    
    func didClickLink(link: MLLink!, linkText: String!, linkLabel: MLLinkLabel!) {
        switch link.linkType {
        case MLLinkType.PhoneNumber:
            var url = "tel://"
            url += linkText
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        default:
            print("click MLLink error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let menuKeys:NSArray = self.dataList["menu"]!.allKeys as NSArray
        return menuKeys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "SKSTableViewCell"
        var cell:SKSTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? SKSTableViewCell
        
        if cell == nil
        {
            cell = SKSTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        
        let row = indexPath.row
        cell!.expandable = true
        
        let menuKeys:NSArray = self.dataList["menu"]!.allKeys as NSArray
        
        cell!.textLabel?.text = menuKeys[row] as! NSString as String
        
        return cell!
    }
    
    func tableView(tableView: SKSTableView!, numberOfSubRowsAtIndexPath indexPath: NSIndexPath!) -> Int {
        
        let menuKeys:NSArray = self.dataList["menu"]!.allKeys as NSArray
        let key:NSString = menuKeys[indexPath.row] as! NSString
        let menu:NSDictionary = self.dataList.objectForKey("menu") as! NSDictionary
        let Dic:NSDictionary = menu.objectForKey(key) as! NSDictionary
        let foodNameArray:NSArray = Dic.objectForKey("foodname") as! NSArray
        return foodNameArray.count
        
    }
    
    func tableView(tableView: SKSTableView!, heightForSubRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: SKSTableView!, cellForSubRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cellIdentifier = "SKSTableViewSubCell"
        var cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
        }
        
        let menuKeys:NSArray = self.dataList["menu"]!.allKeys as NSArray
        let key:NSString = menuKeys[indexPath.row] as! NSString
        let menu:NSDictionary = self.dataList.objectForKey("menu") as! NSDictionary
        let Dic:NSDictionary = menu.objectForKey(key) as! NSDictionary
        let foodNameArray:NSArray = Dic.objectForKey("foodname") as! NSArray
        let foodPriceArray:NSArray = Dic.objectForKey("foodprice") as! NSArray
        
        cell!.textLabel?.text = foodNameArray[indexPath.subRow - 1] as! NSString as String
        cell!.detailTextLabel?.text = foodPriceArray[indexPath.subRow - 1] as! NSString as String
        
        
        cell!.textLabel?.numberOfLines = 0
        cell!.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        cell!.detailTextLabel?.numberOfLines = 0
        cell!.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell!.detailTextLabel?.font = UIFont(name: "System", size: 20)
        
        return cell!
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
