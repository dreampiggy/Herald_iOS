//
//  SimSimiViewController.swift
//  先声
//
//  Created by Wangshuo on 14-9-3.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class SimSimiViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,APIGetter {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var toolBar: UIToolbar!
    
    @IBOutlet var textField: UITextField!

    
    
    var totalChatList :NSMutableArray = [["who":"simsimi","message":"Hi~"],["who":"simsimi","message":"我是东大小黄鸡哦"],["who":"simsimi","message":"我可以无休止地陪你聊天"],["who":"simsimi","message":"但是我也可能会说错话"],["who":"simsimi","message":"你可不要怪我呀"]]
    
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.API.delegate = self
        self.navigationItem.title = "东大小黄鸡"
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 239/255, blue: 80/255, alpha: 1)
        
        self.setupLeftMenuButton()
        self.toolBar.setBackgroundImage(UIImage(named: "toolbar_bottom_bar.png"), forToolbarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
        //dynamic change the textfield size to the screen size
        var textFieldFrameSize = self.textField.frame.size
        textFieldFrameSize.width = UIScreen.mainScreen().bounds.width - 32
        if (UIScreen.mainScreen().bounds.width == 414){
            textFieldFrameSize.width -= 7//iPhone 6 Plus have 7 pixel left
        }
        self.textField.frame.size = textFieldFrameSize
        self.textField.returnKeyType = UIReturnKeyType.Send
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    override func viewWillDisappear(animated: Bool) {
        API.cancelAllRequest()
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        self.textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        var localdic = ["who":"myself","message":self.textField.text]
        self.totalChatList.addObject(localdic)
        self.tableView.reloadData()
        
        if self.totalChatList.count > 0
        {
            var index = NSIndexPath(forRow: self.totalChatList.count - 1, inSection: 0)
            self.tableView.scrollToRowAtIndexPath(index, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        }
        
        let message = self.textField.text ?? ""

        API.sendAPI("simsimi", APIParameter: message)
        
        self.textField.text = ""
        self.textField.resignFirstResponder()
        return true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.totalChatList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var row = indexPath.row
        var str:NSString = self.totalChatList[row].objectForKey("message") as! NSString
        
        var calLabel = UILabel()
        calLabel.text = str as String
        calLabel.numberOfLines = 0
        calLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        calLabel.font = UIFont(name: "System", size: 10)
        
        var maxSize = CGSizeMake(200, 9999)
        var size:CGSize = calLabel.sizeThatFits(maxSize)
        
        return size.height + 40
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellIdentifier = "reuseIdentifier"
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        var row = indexPath.row
        
        //清除上一次视图
        
        for view in cell.contentView.subviews
        {
            if view.tag == 1001 || view.tag == 1002
            {
                view.removeFromSuperview()
            }
        }
        
        //头像
        var imageViewHead = UIImageView()
        imageViewHead.tag = 1001
        
        //气泡
        var imageViewBubble = UIImageView()
        imageViewBubble.tag = 1001
        
        //文字
        
        var label = UILabel()
        label.tag = 1003
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.text = self.totalChatList[row]["message"] as? String
        
        //计算文字内容宽度高度
        var text:NSString = label.text!
    
        
        var calLabel = UILabel()
        calLabel.text = text as String
        calLabel.numberOfLines = 0
        calLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        calLabel.font = UIFont(name: "System", size: 10)
        
        var maxSize = CGSizeMake(200, 9999)
        var size:CGSize = calLabel.sizeThatFits(maxSize)
        
        //设置头像文字气泡,需要判断是自己还是Simsimi
        
        if self.totalChatList[row].objectForKey("who")!.isEqualToString("myself")
        {
            var screenSize:CGSize = UIScreen.mainScreen().bounds.size
            
            imageViewHead.image = UIImage(named: "Side_SchoolBadge.png")
            imageViewHead.frame = CGRectMake(screenSize.width-45, 0, 40, 40)
            imageViewBubble.image = UIImage(named: "chatto_bg_normal.png")
            label.frame = CGRectMake(20, 0, size.width + 20 , size.height + 30 )
            imageViewBubble.frame = CGRectMake(screenSize.width-imageViewHead.frame.size.width-size.width-60,0, size.width+50, size.height+40)
        }
        else
        {
            imageViewHead.image = UIImage(named: "Simsimi.png")
            imageViewHead.frame = CGRectMake(5, 0, 40, 40)
            imageViewBubble.image = UIImage(named: "chatfrom_bg_normal.png")
            label.frame = CGRectMake(20, 0, size.width + 20 , size.height + 30 )
            imageViewBubble.frame = CGRectMake(50, 0, size.width+50, size.height+40)
        }
        
        
        var insets:UIEdgeInsets = UIEdgeInsetsMake(50, 50, 50, 50)
        // 指定为拉伸模式，伸缩后重新赋值
        imageViewBubble.image = imageViewBubble.image?.resizableImageWithCapInsets(insets, resizingMode: UIImageResizingMode.Stretch)
        
        cell.backgroundColor = UIColor.clearColor()
        
        imageViewBubble.addSubview(label)
        cell.contentView.addSubview(imageViewBubble)
        cell.contentView.addSubview(imageViewHead)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.textField.resignFirstResponder()
    }
    
    func getResult(APIName: String, results: AnyObject) {
        var res = ""
        if results.isEqualToString("error")
        {
            res = "我听不懂你在说什么呀"
        }
        else
        {
            res = results.stringByReplacingOccurrencesOfString("<br>", withString: "\n")
        }
        
        var localdic = ["who":"Simsimi","message":res]
        self.totalChatList.addObject(localdic)
        self.tableView.reloadData()
        
        if self.totalChatList.count > 0
        {
            var index = NSIndexPath(forRow: self.totalChatList.count - 1, inSection: 0)
            self.tableView.scrollToRowAtIndexPath(index, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
        }
    }
    
    func getError(APIName: String, statusCode: Int) {
        var res = ""
        res = "服务器提了一个问题，小黄鸡正在紧张处理中……"
        var localdic = ["who":"Simsimi","message":res]
        self.totalChatList.addObject(localdic)
        self.tableView.reloadData()
        
        if self.totalChatList.count > 0
        {
            var index = NSIndexPath(forRow: self.totalChatList.count - 1, inSection: 0)
            self.tableView.scrollToRowAtIndexPath(index, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
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
