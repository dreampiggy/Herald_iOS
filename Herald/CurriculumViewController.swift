//
//  CurriculumViewController.swift
//  先声
//
//  Created by Wangshuo on 14-8-21.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class CurriculumViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,APIGetter {
    
    
    @IBOutlet var termSegmentControl: UISegmentedControl!
    
    @IBOutlet var daySegmentControl: UISegmentedControl!
    
    @IBOutlet var tableView: UITableView!
    
    var totalCurriculum:NSDictionary?
    
    var currentCurriculum:NSMutableArray?
    
    var selectedDay:String = "Mon"

    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "课表查询"
        var color = UIColor(red: 153/255, green: 204/255, blue: 204/255, alpha: 1)
        
        let refreshButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("refreshCurriculum"))
        self.navigationItem.rightBarButtonItem = refreshButton
        
        self.view.backgroundColor = UIColor(red: 180/255, green: 230/255, blue: 230/255, alpha: 1)
        self.tableView.backgroundColor = UIColor(red: 180/255, green: 230/255, blue: 230/255, alpha: 1)
        
        self.daySegmentControl.addTarget(self, action: Selector("daySegmentedControlPressed"), forControlEvents: UIControlEvents.ValueChanged)
        self.daySegmentControl.selectedSegmentIndex = 0
        
        var initResult = Tool.initNavigationAPI(self,navBarColor: color)
        self.API.delegate = self
        if let cacheResult = Config.curriculum{
            totalCurriculum = cacheResult
            daySegmentedControlPressed()
        }
        else if initResult{
            Tool.showProgressHUD("正在查询课表信息")
            API.sendAPI("curriculum")
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        Tool.dismissHUD()
        API.cancelAllRequest()
    }
    
    func getResult(APIName: String, results: AnyObject) {
        Tool.showSuccessHUD("获取成功")
        if let curriculumToCache = results as? NSDictionary{
            Config.saveCurriculum(curriculumToCache)
            totalCurriculum = curriculumToCache
        }
        daySegmentedControlPressed()
    }
    
    func getError(APIName: String, statusCode: Int) {
        Tool.showErrorHUD("获取信息失败")
    }
    
    func refreshCurriculum()
    {
        Tool.showProgressHUD("正在更新课表")
        API.sendAPI("curriculum")
    }

    func daySegmentedControlPressed()
    {
        var selectedIndex = self.daySegmentControl.selectedSegmentIndex
        switch selectedIndex
        {
        case 0:
            self.selectedDay = "Mon"
            self.currentCurriculum = totalCurriculum?["Mon"] as? NSMutableArray ?? []
            self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
        case 1:
            self.selectedDay = "Tue"
            self.currentCurriculum = totalCurriculum?["Tue"] as? NSMutableArray ?? []
            self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
        case 2:
            self.selectedDay = "Wed"
            self.currentCurriculum = totalCurriculum?["Wed"] as? NSMutableArray ?? []
            self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
        case 3:
            self.selectedDay = "Thu"
            self.currentCurriculum = totalCurriculum?["Thu"] as? NSMutableArray ?? []
            self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
        case 4:
            self.selectedDay = "Fri"
            self.currentCurriculum = totalCurriculum?["Fri"] as? NSMutableArray ?? []
            self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
        case 5:
            self.selectedDay = "Sat"
            self.currentCurriculum = totalCurriculum?["Sat"] as? NSMutableArray ?? []
            self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
        case 6:
            self.selectedDay = "Sun"
            self.currentCurriculum = totalCurriculum?["Sun"] as? NSMutableArray ?? []
            self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
            
        default:
            break
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 116
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if self.currentCurriculum == nil
        {
            return 0
        }
        else if self.currentCurriculum!.count != 0//课表非空
        {
            return self.currentCurriculum!.count
        }
        else{//课表为空
            return 1
        }
        
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier:String = "CurriculumTableViewCell"
        
        
        var cell: CurriculumTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? CurriculumTableViewCell
        
        
        if nil == cell
        {
            var nibArray:NSArray = NSBundle.mainBundle().loadNibNamed("CurriculumTableViewCell", owner: self, options: nil)
            cell = nibArray.objectAtIndex(0) as? CurriculumTableViewCell
        }
        
        
        var row = indexPath.row
        
        if (self.currentCurriculum != nil && self.currentCurriculum?.count != 0){//有课表信息
            cell?.nameofLesson.text = self.currentCurriculum![row][0] as? String
            cell?.placeofLesson.text = self.currentCurriculum![row][2] as? String
            var week:NSString = self.currentCurriculum![row][1] as! NSString
            
            var last = 0
            for i in 4..<10
            {
                if 93 == week.characterAtIndex(i)   // 93 是 "]"的 ASCII码
                {
                    last = i
                    break
                }
            }
            
            var weekRange:NSRange = NSMakeRange(1, last-1)
            week = week.substringWithRange(weekRange)
            
            cell?.weekofLesson.text = week as String
            
            var time:NSString = self.currentCurriculum![row][1] as! NSString
            
            time = time.substringFromIndex(last+1)
            
            cell?.timeofLesson.text = time as String
            
            //设置自动换行
            cell?.nameofLesson.lineBreakMode = NSLineBreakMode.ByWordWrapping
            cell?.nameofLesson.numberOfLines = 0
            
            cell?.placeofLesson.lineBreakMode = NSLineBreakMode.ByWordWrapping
            cell?.placeofLesson.numberOfLines = 0
        }
        else if (self.currentCurriculum != nil && self.currentCurriculum?.count == 0){
            cell?.nameofLesson.text = "没课你敢信？"
            cell?.timeofLesson.text = nil
            cell?.placeofLesson.text = nil
            cell?.weekofLesson.text = nil
        }
        
        return cell!
    }

}
