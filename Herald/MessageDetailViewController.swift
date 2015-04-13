//
//  MessageDetailViewController.swift
//  Herald
//
//  Created by Wangshuo on 14-9-17.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit
import MessageUI

class MessageDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,HttpProtocol,MFMailComposeViewControllerDelegate,UITextFieldDelegate {

    
    @IBOutlet var topView: UIView!
    
    @IBOutlet var commentView: UIView!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var textField: UITextField!
    var httpController = HttpController()
    var dataList:NSDictionary!
    var comments:NSMutableArray!

    
    @IBOutlet var messageID: UILabel!
    @IBOutlet var commentNum: UILabel!
    var colorArray:NSArray = [UIColor(red: 111/255, green: 197/255, blue:85/255, alpha: 1),
        UIColor(red: 249/255, green: 197/255, blue: 85/255, alpha: 1),
        UIColor(red: 251/255, green: 151/255, blue: 65/255, alpha: 1),
        UIColor(red: 243/255, green: 66/255, blue: 70/255, alpha: 1),
        UIColor(red: 166/255, green: 70/255, blue: 167/255, alpha: 1),
        UIColor(red: 38/255, green: 173/255, blue: 229/255, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
            
        var reportButton = UIBarButtonItem(title: "举报此条", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("reportButtonClicked"))
        self.navigationItem.rightBarButtonItem = reportButton
        
        self.textField.delegate = self
        self.textField.returnKeyType = UIReturnKeyType.Send
            
        var colorNum = Int(arc4random_uniform(6))
        self.topView.backgroundColor = self.colorArray[colorNum] as? UIColor
        self.commentView.backgroundColor = self.colorArray[colorNum] as? UIColor
        self.navigationController?.navigationBar.barTintColor = self.colorArray[colorNum] as? UIColor
        self.textField.placeholder = "在此评论"
            
        
        self.commentNum.text = String(self.comments.count)
        self.messageID.text  = self.dataList["herald_id"] as NSString
    
        var label = UILabel()
        label.text = self.dataList["content"] as NSString
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = UIFont(name: "System", size: 25)
            
        var maxSize = CGSizeMake(200, 9999)
        var size:CGSize = label.sizeThatFits(maxSize)
        var topViewSize = self.topView.frame.size
        label.frame = CGRectMake((topViewSize.width - size.width)/2, (topViewSize.height - size.height)/2 , size.width , size.height)
        self.topView.addSubview(label)
            
        self.tableView.reloadData()
        
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        
        var renrenID = self.dataList["renren_id"] as NSString
        let parameter:NSDictionary = ["id":renrenID,"comment":self.textField.text]
        self.httpController.postToURL("http://121.248.63.105/service/treehole", parameter: parameter, tag: "postComment")
        
        self.comments.addObject(self.textField.text)
        self.tableView.reloadData()
        
        self.textField.text = ""
        self.textField.resignFirstResponder()
        return true
    }
    
    func reportButtonClicked()
    {
        var mailController:MFMailComposeViewController = MFMailComposeViewController()
        mailController.mailComposeDelegate = self
        
        mailController.setToRecipients([NSString(string: "364987469@qq.com")])
    
        var subject = "举报编号"
        subject += self.dataList["herald_id"] as NSString
        subject += "的消息(附理由)"
        
        mailController.setSubject(subject)
        self.presentViewController(mailController, animated: true, completion: nil)

    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.comments.count
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var label = UILabel()
        
        label.text = self.comments[indexPath.row] as NSString
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = UIFont(name: "System", size: 15)
        
        var maxSize = CGSizeMake(200, 9999)
        var size:CGSize = label.sizeThatFits(maxSize)
        
        return size.height + 110
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cellIdentifier:String = "CommentTableViewCell"
        
        
        var cell: CommentTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? CommentTableViewCell
        
        
        if nil == cell
        {
            var nibArray:NSArray = NSBundle.mainBundle().loadNibNamed("CommentTableViewCell", owner: self, options: nil)
            cell = nibArray.objectAtIndex(0) as? CommentTableViewCell
            
            
            var label = UILabel()
    
            label.text = self.comments[indexPath.row] as NSString
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
            label.font = UIFont(name: "System", size: 15)
            
            var maxSize = CGSizeMake(200, 9999)
            var size:CGSize = label.sizeThatFits(maxSize)
            var contentViewSize = cell!.frame.size
            
            cell!.commentsLabel = UILabel()
            cell!.commentsLabel.frame = CGRectMake((contentViewSize.width - size.width)/2, (contentViewSize.height - size.height)/2, size.width ,size.height)
            cell!.commentsLabel.numberOfLines = 0
            cell!.commentsLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
            cell!.addSubview(cell!.commentsLabel)
            
            
            
        }
        
        var row = indexPath.row
        
        cell!.commentsFloor.text =  "#" + String(row+1)
        
        cell!.commentsLabel.text = self.comments[indexPath.row] as NSString

        
        cell!.likeButton.tag = 0
        cell!.likeButton.particleImage = UIImage(named: "Sparkle.png")
        cell!.likeButton.particleScale = 0.05;
        cell!.likeButton.particleScaleRange = 0.02;
        cell!.likeButton.addTarget(self, action: Selector("likeButtonClicked:"), forControlEvents: UIControlEvents.TouchUpInside)
        

        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var row = indexPath.row + 1
        var text = "回复" + String(row) + "楼:"
        self.textField.text = text
        self.textField.becomeFirstResponder()
        
    }

    
    func likeButtonClicked(sender:MCFireworksButton)
    {
        
        if sender.tag == 0
        {
            sender.tag = 1
        }
        else
        {
            sender.tag = 0
        }
        
        if sender.tag == 1
        {
            sender.popOutsideWithDuration(0.5)
            sender.setImage(UIImage(named: "Like-Blue.png"), forState: UIControlState.Normal)
            sender.animate()
        }
        else
        {
            sender.popInsideWithDuration(0.4)
            sender.setImage(UIImage(named: "Like.png"), forState: UIControlState.Normal)
            
        }
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
