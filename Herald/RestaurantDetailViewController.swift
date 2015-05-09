//
//  RestaurantDetailViewController.swift
//  Herald
//
//  Created by Wangshuo on 14-9-13.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController,MLEmojiLabelDelegate,SKSTableViewDelegate {

    
    var dataList:NSDictionary!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var addressLabel: UILabel!
    
    @IBOutlet var contactLabel: MLEmojiLabel!
    
    
    @IBOutlet var lowestPriceLabel: UILabel!
    
    
    @IBOutlet var tableView: SKSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = self.dataList.objectForKey("name") as NSString
        
        var barButton = UIBarButtonItem(title: "收起展开", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("collapse"))
        self.navigationItem.rightBarButtonItem = barButton
        
        
        var imageName:NSString = self.dataList.objectForKey("bigImage") as NSString
        self.imageView.image = UIImage(named: imageName)
        
        self.addressLabel.text = self.dataList.objectForKey("addr") as NSString
        self.addressLabel.numberOfLines = 0
        self.addressLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        self.contactLabel.emojiText = self.dataList.objectForKey("contact") as NSString
        self.contactLabel.emojiDelegate = self
        self.contactLabel.numberOfLines = 0
        self.contactLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        self.lowestPriceLabel.text = self.dataList.objectForKey("lowestPrice") as NSString
        
        
        self.tableView.SKSTableViewDelegate = self
    }
    
    func collapse()
    {
        self.tableView.collapseCurrentlyExpandedIndexPaths()
    }
    
    func mlEmojiLabel(emojiLabel: MLEmojiLabel!, didSelectLink link: String!, withType type: MLEmojiLabelLinkType) {
        switch type
        {
        case MLEmojiLabelLinkType.PhoneNumber:

            var url = "tel://"
            url += link
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
            
        default:
            println("click emojiLabel error")
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
        var menuKeys:NSArray = self.dataList["menu"]!.allKeys as NSArray
        return menuKeys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellIdentifier = "SKSTableViewCell"
        var cell:SKSTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? SKSTableViewCell
        
        if cell == nil
        {
            cell = SKSTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        
        var row = indexPath.row
        cell!.expandable = true
        
        var menuKeys:NSArray = self.dataList["menu"]!.allKeys as NSArray
        
        cell!.textLabel?.text = menuKeys[row] as NSString
        
        return cell!
    }
    
    func tableView(tableView: SKSTableView!, numberOfSubRowsAtIndexPath indexPath: NSIndexPath!) -> Int {
        
        var menuKeys:NSArray = self.dataList["menu"]!.allKeys as NSArray
        var key:NSString = menuKeys[indexPath.row] as NSString
        var menu:NSDictionary = self.dataList.objectForKey("menu") as NSDictionary
        var Dic:NSDictionary = menu.objectForKey(key) as NSDictionary
        var foodNameArray:NSArray = Dic.objectForKey("foodname") as NSArray
        return foodNameArray.count
        
    }
    
    func tableView(tableView: SKSTableView!, heightForSubRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: SKSTableView!, cellForSubRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cellIdentifier = "SKSTableViewSubCell"
        var cell:UITableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: cellIdentifier)
        }
        
        var menuKeys:NSArray = self.dataList["menu"]!.allKeys as NSArray
        var key:NSString = menuKeys[indexPath.row] as NSString
        var menu:NSDictionary = self.dataList.objectForKey("menu") as NSDictionary
        var Dic:NSDictionary = menu.objectForKey(key) as NSDictionary
        var foodNameArray:NSArray = Dic.objectForKey("foodname") as NSArray
        var foodPriceArray:NSArray = Dic.objectForKey("foodprice") as NSArray
        
        cell!.textLabel?.text = foodNameArray[indexPath.subRow - 1] as NSString
        cell!.detailTextLabel?.text = foodPriceArray[indexPath.subRow - 1] as NSString
        
        
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
