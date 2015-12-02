//
//  SRTPViewController.swift
//  先声
//
//  Created by Wangshuo on 14-9-4.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class SRTPViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,APIGetter {

    
    @IBOutlet var stuIDLabel: UILabel!
    
    @IBOutlet var totalCreditLabel: UILabel!
    
    @IBOutlet var levelLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    var dataList:NSArray = []
    
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "SRTP详情"
        let color = UIColor(red: 153/255, green: 204/255, blue: 204/255, alpha: 1)
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("refreshData"))
        self.navigationItem.rightBarButtonItem = refreshButton
        
        let initResult = Tool.initNavigationAPI(self,navBarColor: color)
        if initResult{
            Tool.showProgressHUD("正在查询SRTP信息")
            self.API.delegate = self
            API.sendAPI("srtp")
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        Tool.dismissHUD()
        API.cancelAllRequest()
    }
    
    func getResult(APIName: String, results: JSON) {
        Tool.showSuccessHUD("获取成功")
        
        self.dataList = results["content"].arrayObject ?? []
        
        self.stuIDLabel.text = results["content"][0]["card number"].stringValue
        self.totalCreditLabel.text = results["content"][0]["total"].stringValue
        self.levelLabel.text = results["content"][0]["score"].stringValue
        
        self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
    }
    
    func getError(APIName: String, statusCode: Int) {
        Tool.showErrorHUD("获取数据失败")
    }

    func refreshData()
    {
        Tool.showProgressHUD("正在更新SRTP信息")
        API.sendAPI("srtp")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 75
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.dataList == []
        {
            return 0
        }
        else
        {
            return self.dataList.count - 1
        }
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRectMake(0, 0, 320, 30))
        headerView.backgroundColor = UIColor(patternImage: UIImage(named: "SRTP_header.jpg")!)
        
        let creditLabel = UILabel(frame: CGRectMake(15, 0, 40, 30))
        creditLabel.textColor = UIColor.darkGrayColor()
        creditLabel.font = UIFont(name: "System", size: 13)
        creditLabel.text = "学分"
        
        let projectLabel = UILabel(frame: CGRectMake(135, 0, 80, 30))
        projectLabel.textColor = UIColor.darkGrayColor()
        projectLabel.font = UIFont(name: "System", size: 13)
        projectLabel.text = "项目"
        
        let propertyLabel = UILabel(frame: CGRectMake(255, 0, 40, 30))
        propertyLabel.textColor = UIColor.darkGrayColor()
        propertyLabel.font = UIFont(name: "System", size: 13)
        propertyLabel.text = "性质"
        
        
        headerView.addSubview(creditLabel)
        headerView.addSubview(projectLabel)
        headerView.addSubview(propertyLabel)
        
        return headerView
        
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cellIdentifier:String = "SRTPTableViewCell"
        
        
        var cell: SRTPTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? SRTPTableViewCell
        
        
        if nil == cell
        {
            let nibArray:NSArray = NSBundle.mainBundle().loadNibNamed("SRTPTableViewCell", owner: self, options: nil)
            cell = nibArray.objectAtIndex(0) as? SRTPTableViewCell
        }

        let row = indexPath.row
        
        let credit = self.dataList[row+1]["credit"] as! NSString
        
        if credit.isEqualToString("")
        {
            cell?.creditLabel.text = "0.0"
        }
        else
        {
            cell?.creditLabel.text = self.dataList[row+1]["credit"] as! NSString as String
        }
        
        
        cell?.projectLabel.text = self.dataList[row+1]["project"] as? NSString as? String
        cell?.dateLabel.text = self.dataList[row+1]["date"] as? NSString as? String
        cell?.propertyLabel.text = self.dataList[row+1]["type"] as? NSString as? String
        
        cell?.projectLabel.numberOfLines = 0
        cell?.projectLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        return cell!
    }

}
