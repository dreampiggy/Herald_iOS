//
//  GradeViewController.swift
//  先声
//
//  Created by Wangshuo on 14-9-3.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class GradeViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,APIGetter{

    
    @IBOutlet var totalCreditLabel: UILabel!
    
    @IBOutlet var GPALabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    var dataList:NSArray = []
    var termList:NSMutableArray = []
    var courseList:NSMutableArray = []
    
    var totalCredit: Float = 0
    var GPA: Float = 0
    
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "成绩详情"
    

            
        var color = UIColor(red: 153/255, green: 204/255, blue: 204/255, alpha: 1)
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("refreshData"))
        self.navigationItem.rightBarButtonItem = refreshButton
        
        var initResult = Tool.initNavigationAPI(self,navBarColor: color)
        self.API.delegate = self
        
        if let cacheGPA = Config.GPA{
            self.dataClassify(cacheGPA)
            self.GPALabel.text = NSString(format: "%.3f", self.GPA)
            self.totalCreditLabel.text = NSString(format: "%.1f", self.totalCredit)
            
            self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
        }
        else if initResult{
            Tool.showProgressHUD("正在查询GPA信息，请耐心等待")
            API.sendAPI("gpa")
        }
    }

    override func viewWillDisappear(animated: Bool) {
        Tool.dismissHUD()
        API.cancelAllRequest()
    }
    

    func dataClassify(data:NSArray)
    {
        //需要重新归零，否则更新后会重复加上学分
        self.totalCredit = 0
        
        //获取学期数组
        var termCount = 0
        
    
        self.termList[termCount] = data[1]["semester"] as NSString
        termCount += 1
        
        for i in 2..<data.count
        {
            var termCurrent = data[i]["semester"] as NSString
            var termExisted = self.termList[termCount - 1] as NSString
            if !termCurrent.isEqualToString(termExisted)
            {
                self.termList.addObject(data[i]["semester"] as NSString)
                termCount += 1
            }
        }
        
        
        //获取课程分类和计算总学分
        var termNum = 0
        
        //self.courseList = NSMutableArray(capacity: self.termList.count)
        
        for i in 0..<self.termList.count
        {
            self.courseList[i] = NSMutableArray()
        }
        
        for i in 1..<data.count
        {
            var termCurrent :NSString = data[i]["semester"] as NSString
            if termCurrent.isEqualToString(self.termList[termNum] as NSString)
            {
                self.courseList[termNum].addObject(data[i])
                //需要先转成NSString  否则会出现动态转换错误 崩溃
                var credit:NSString = data[i]["credit"] as NSString
                self.totalCredit += credit.floatValue
            }
            else
            {
                termNum += 1
                self.courseList[termNum].addObject(data[i])
                var credit:NSString = data[i]["credit"] as NSString
                self.totalCredit += credit.floatValue
            }
        
        }
        
        //需要先转成NSString  否则会出现动态转换错误 崩溃
        var gpa = data[0]["gpa"] as NSString
        self.GPA = gpa.floatValue
    }
    
    
    func refreshData()
    {
        Tool.showProgressHUD("正在更新成绩，请耐心等待")
        API.sendAPI("gpa")
    }
    
    func getResult(APIName: String, results: AnyObject) {
        Tool.showSuccessHUD("获取成功")
        if let GPAToCache = results as? NSArray{
            Config.saveGPA(GPAToCache)
            self.dataClassify(GPAToCache)
        }
        
        self.GPALabel.text = NSString(format: "%.3f", self.GPA)
        self.totalCreditLabel.text = NSString(format: "%.1f", self.totalCredit)
        
        self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
    }
    
    func getError(APIName: String, statusCode: Int) {
        Tool.showErrorHUD("获取数据失败")
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.termList.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerView = UIView(frame: CGRectMake(0, 0, 320, 30))
        headerView.backgroundColor = UIColor(patternImage: UIImage(named: "Grades_header.jpg")!)
        
        var termLabel = UILabel(frame: CGRectMake(40, 0, 100, 30))
        termLabel.textColor = UIColor.whiteColor()
        termLabel.highlightedTextColor = UIColor.whiteColor()
        termLabel.font = UIFont(name: "System Bold", size: 18)
        termLabel.text = self.termList[section] as? String
        
        var scoreLabel = UILabel(frame: CGRectMake(150, 0, 40, 30))
        scoreLabel.textColor = UIColor.whiteColor()
        scoreLabel.font = UIFont(name: "System", size: 13)
        scoreLabel.text = "成绩"
        
        var creditLabel = UILabel(frame: CGRectMake(205, 0, 40, 30))
        creditLabel.textColor = UIColor.whiteColor()
        creditLabel.font = UIFont(name: "System", size: 13)
        creditLabel.text = "学分"
        
        var propertyLabel = UILabel(frame: CGRectMake(268, 0, 40, 30))
        propertyLabel.textColor = UIColor.whiteColor()
        propertyLabel.font = UIFont(name: "System", size: 13)
        propertyLabel.text = "性质"
        
        headerView.addSubview(termLabel)
        headerView.addSubview(scoreLabel)
        headerView.addSubview(creditLabel)
        headerView.addSubview(propertyLabel)
        
        return headerView
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.courseList == []
        {
            return 0
        }
        else
        {
            return self.courseList[section].count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier:String = "GradeTableViewCell"
        
        
        var cell: GradeTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? GradeTableViewCell
        
        
        if nil == cell
        {
            var nibArray:NSArray = NSBundle.mainBundle().loadNibNamed("GradeTableViewCell", owner: self, options: nil)
            cell = nibArray.objectAtIndex(0) as? GradeTableViewCell
        }
        
        var section = indexPath.section
        var row = indexPath.row
        
        cell?.nameLabel.text = self.courseList[section][row]["name"] as? String
        cell?.gradeLabel.text = self.courseList[section][row]["score"] as? String
        cell?.creditLabel.text = self.courseList[section][row]["credit"] as? String
        cell?.propertyLabel.text = self.courseList[section][row]["type"] as? String
        
        cell?.nameLabel.adjustsFontSizeToFitWidth = true
        cell?.propertyLabel.adjustsFontSizeToFitWidth = true
        
        return cell!
    }

}