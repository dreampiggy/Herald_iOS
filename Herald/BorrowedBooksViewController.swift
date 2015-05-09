//
//  BorrowedBooksViewController.swift
//  先声
//
//  Created by Wangshuo on 14-9-8.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class BorrowedBooksViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,APIGetter {

    
    
    @IBOutlet weak var noBorrowLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    var dataList:NSArray! = []
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "已借书籍"
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("refreshData"))
        self.navigationItem.rightBarButtonItem = refreshButton
        var color = UIColor(red: 96/255, green: 199/255, blue: 222/255, alpha: 1)
        var initResult = Tool.initNavigationAPI(self,navBarColor: color)
        if initResult{
            Tool.showProgressHUD("正在查询图书借阅情况")
            self.API.delegate = self
            API.sendAPI("library")
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        Tool.dismissHUD()
        API.cancelAllRequest()
    }
    
    func getResult(APIName: String, results: AnyObject) {
        switch APIName{
        case "library":
            if let resultsArray = results as? NSArray
            {
                Tool.showSuccessHUD("获取成功")
                self.dataList = resultsArray
                if self.dataList.count == 0{
                    tableView.hidden = true
                    noBorrowLabel.hidden = false
                }
                else{
                    noBorrowLabel.hidden = true
                    tableView.hidden = false
                self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
                }
            }
        case "libraryRenew":
            if "success" == results as? String{
                Tool.showSuccessHUD("续借成功")
            }
            else{
                Tool.showErrorHUD("续借失败")
            }
        default:break
        }
    }
    
    func getError(APIName: String, statusCode: Int) {
        Tool.showErrorHUD("获取数据失败")
    }
    
    func refreshData()
    {
        Tool.showProgressHUD("正在刷新")
        API.sendAPI("library")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier:String = "BorrowedBooksTableViewCell"
        
        
        var cell: BorrowedBooksTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? BorrowedBooksTableViewCell
        
        
        if nil == cell
        {
            var nibArray:NSArray = NSBundle.mainBundle().loadNibNamed("BorrowedBooksTableViewCell", owner: self, options: nil)
            cell = nibArray.objectAtIndex(0) as? BorrowedBooksTableViewCell
        }
        
        var row = indexPath.row
        
        cell?.bookName.text = self.dataList[row]["title"] as! NSString as String
        cell?.borrowDate.text = self.dataList[row]["render_date"] as! NSString as String
        cell?.dueDate.text = self.dataList[row]["due_date"] as! NSString as String
        cell?.collectionSite.text = self.dataList[row]["place"] as! NSString as String
        cell?.author.text = self.dataList[row]["author"] as! NSString as String
        cell?.barCode.text = self.dataList[row]["barcode"] as! NSString as String
        cell?.renewTime.text = self.dataList[row]["renew_time"] as! NSString as String
        
        cell?.renewButton.tag = row
        cell?.renewButton.addTarget(self, action: Selector("renewButtonClicked:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        var color = UIColor(red: 96/255, green: 199/255, blue: 222/255, alpha: 0.3)
        cell?.backgroundColor = color
        
        return cell!
        
    }
    
    func renewButtonClicked(sender: UIButton)
    {
        var row = sender.tag
        var barcode:String? = self.dataList[row]["barcode"] as? String
        Tool.showProgressHUD("正在续借图书")
        API.sendAPI("libraryRenew", APIParameter: barcode ?? "")
    }
}