//
//  AcademicViewController.swift
//  先声
//
//  Created by Wangshuo on 14-9-2.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class AcademicViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,APIGetter {

    @IBOutlet var upSegmentControl: UISegmentedControl!
    
    @IBOutlet var downSegmentControl: UISegmentedControl!
    
    @IBOutlet var tableView: UITableView!
    
    var allInfoList:NSMutableArray = []//All information in a list with all JWC info.Should be initialized before use
    var contentDictionary:NSDictionary?//All information in a dictionary with 5 type of JWC info
    
    var currentList:NSMutableArray = []
    
    var segmentedControlLastPressedIndex:NSNumber = 0
    
    var firstLoad = true
    
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "教务信息"
        let color = UIColor(red: 153/255, green: 204/255, blue: 204/255, alpha: 1)
        
        self.view.backgroundColor = UIColor(red: 180/255, green: 230/255, blue: 230/255, alpha: 1)
        self.tableView.backgroundColor = UIColor(red: 180/255, green: 230/255, blue: 230/255, alpha: 1)
        
        self.upSegmentControl.addTarget(self, action: Selector("upSegmentedControlPressed"), forControlEvents: UIControlEvents.ValueChanged)
        self.downSegmentControl.addTarget(self, action: Selector("downSegmentedControlPressed"), forControlEvents: UIControlEvents.ValueChanged)
        
        //设置默认选择项索引
        self.upSegmentControl.selectedSegmentIndex = 0
        self.downSegmentControl.selectedSegmentIndex = UISegmentedControlNoSegment
        
        //设置表格刷新
        self.tableView.addFooterWithTarget(self, action: Selector("footerRefreshing"))
        let initResult = Tool.initNavigationAPI(self,navBarColor: color)
        if initResult{
            Tool.showProgressHUD("正在查询教务信息")
            self.API.delegate = self
            API.sendAPI("jwc")
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        Tool.dismissHUD()
        API.cancelAllRequest()
    }
    
    func getResult(APIName: String, results: JSON) {
        Tool.showSuccessHUD("获取成功")
        contentDictionary = results["content"].dictionaryObject
        getAllInformation()
        if firstLoad{
            upSegmentedControlPressed()
            firstLoad = false
        }
    }
    
    func getError(APIName: String, statusCode: Int) {
        Tool.showErrorHUD("获取数据失败")
    }

    
    
    func upSegmentedControlPressed()
    {
        let selectedIndex = self.upSegmentControl.selectedSegmentIndex
        if contentDictionary == nil{
            Tool.showErrorHUD("没有数据哦")
            return
        }
        switch selectedIndex
        {
        case 0:
            if  allInfoList.count != 0{
                self.downSegmentControl.selectedSegmentIndex = UISegmentedControlNoSegment
                self.currentList = allInfoList
                self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
            }
            
        case 1:
            if let segmentedContent:NSMutableArray = contentDictionary!["最新动态"] as? NSMutableArray{
                self.downSegmentControl.selectedSegmentIndex = UISegmentedControlNoSegment
                self.currentList = segmentedContent
                self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
            }
        case 2:
            if let segmentedContent:NSMutableArray = contentDictionary!["教务信息"] as? NSMutableArray{
                self.downSegmentControl.selectedSegmentIndex = UISegmentedControlNoSegment
                self.currentList = segmentedContent
                self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
            }
        default:
            break
        }
    }
    
    func downSegmentedControlPressed()
    {
        let selectedIndex = self.downSegmentControl.selectedSegmentIndex
        switch selectedIndex
            {
        case 0:
            if let segmentedContent:NSMutableArray = contentDictionary!["合作办学"] as? NSMutableArray{
                self.upSegmentControl.selectedSegmentIndex = UISegmentedControlNoSegment
                self.currentList = segmentedContent
                self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
            }
            
        case 1:
            if let segmentedContent:NSMutableArray = contentDictionary!["学籍管理"] as? NSMutableArray{
                self.upSegmentControl.selectedSegmentIndex = UISegmentedControlNoSegment
                self.currentList = segmentedContent
                self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
            }
            
        case 2:
            if let segmentedContent:NSMutableArray = contentDictionary!["实践教学"] as? NSMutableArray{
                self.upSegmentControl.selectedSegmentIndex = UISegmentedControlNoSegment
                self.currentList = segmentedContent
                self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
            }
            
        default:
            break
        }
    }
    
    //获取教务信息中的全部信息，而非某个信息，供第一个SegmentedControl显示
    func getAllInformation(){
        allInfoList = []//清空
        if let allContent = contentDictionary{
            for (_,infoArray) in allContent{
                allInfoList.addObjectsFromArray(infoArray as! Array<AnyObject>)
            }
        }
    }

    func footerRefreshing()
    {
        Tool.showProgressHUD("正在加载更多数据")
        API.sendAPI("jwc")
        self.tableView.footerEndRefreshing()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 110
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.currentList.count == 0
        {
            return 0
        }
        else
        {
            return self.currentList.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier:String = "AcademicTableViewCell"
        
        
        var cell: AcademicTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? AcademicTableViewCell
        
        
        if nil == cell
        {
            let nibArray:NSArray = NSBundle.mainBundle().loadNibNamed("AcademicTableViewCell", owner: self, options: nil)
            cell = nibArray.objectAtIndex(0) as? AcademicTableViewCell

        }
        

        cell?.backgroundColor = UIColor(red: 180/255, green: 230/255, blue: 230/255, alpha: 1)
        
        let row = indexPath.row
        
        
        cell?.headLineLabel.text = self.currentList[row]["title"] as? String
        cell?.dateLabel.text = self.currentList[row]["date"] as? String
        
        cell?.headLineLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell?.headLineLabel.numberOfLines = 0
        cell?.dateLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell?.dateLabel.numberOfLines = 0
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let academicDetailVC = AcademicDetailViewController()
        academicDetailVC.initWebView(self.currentList[row]["href"] as! NSString as String)
        self.navigationController!.pushViewController(academicDetailVC, animated: true)
    }
    //现在API只返回网页形式的教务信息，没有文字信息
}
