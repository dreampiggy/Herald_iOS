//
//  SchoolBusViewController.swift
//  Herald
//
//  Created by lizhuoli on 15/4/1.
//  Copyright (c) 2015年 WangShuo. All rights reserved.
//

import UIKit

class SchoolBusViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, APIGetter{
    
    @IBOutlet weak var tableView: UITableView!
    var weekendInfo:[Dictionary<String,String>] = []
    var weekdayInfo:[Dictionary<String,String>] = []
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        var color = UIColor(red: 96/255, green: 199/255, blue: 222/255, alpha: 1)
        var initResult = Tool.initNavigationAPI(self,navBarColor: color)
        if initResult{
            Tool.showProgressHUD("正在查询校车信息")
            self.API.delegate = self
            API.sendAPI("schoolbus")
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        Tool.dismissHUD()
        API.cancelAllRequest()
    }
    
    func getResult(APIName: String, results: JSON) {
        Tool.showSuccessHUD("获取数据成功")
        //Fuck to change this type...Any good ways?
        var tempWeekend:NSDictionary = results["content"]["weekend"].dictionaryObject ?? NSDictionary()
        for busType in tempWeekend.allKeys{
            var tempWeekendType = tempWeekend[busType as! String] as! [NSDictionary]
            for var i = 0;i < tempWeekendType.count;++i{
                var finalTempDictionary = ["place":busType as! String,"bus":tempWeekendType[i]["bus"] as! String,"time":tempWeekendType[i]["time"] as! String]
                weekendInfo.append(finalTempDictionary)
            }
        }
        
        var tempWeekday:NSDictionary = results["content"]["weekday"].dictionaryObject ?? NSDictionary()
        for busType in tempWeekday.allKeys{
            var tempWeekdayType = tempWeekday[busType as! String] as! [NSDictionary]
            for var i = 0;i < tempWeekdayType.count;++i{
                var finalTempDictionary = ["place":busType as! String,"bus":tempWeekdayType[i]["bus"] as! String,"time":tempWeekdayType[i]["time"] as! String]
                weekdayInfo.append(finalTempDictionary)
            }
        }
        tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
    }
    
    func getError(APIName: String, statusCode: Int) {
        Tool.showErrorHUD("获取数据失败")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "工作日时刻"
        case 1:
            return "周末时刻"
        default:
            return nil
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return weekdayInfo.count
        case 1:
            return weekendInfo.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier:String = "SchoolBusTableViewCell"
        var row = indexPath.row
        var section = indexPath.section
        
        var cell: SchoolBusTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? SchoolBusTableViewCell
        if cell == nil{
            var nibArray:NSArray = NSBundle.mainBundle().loadNibNamed("SchoolBusTableViewCell", owner: self, options: nil)
            cell = nibArray.objectAtIndex(0) as? SchoolBusTableViewCell
        }
        if(weekendInfo.count == 0 || weekdayInfo.count == 0){
            return cell!
        }
        
        switch section{
        case 0:
            cell?.placeLabel.text = weekdayInfo[row]["place"] ?? ""
            cell?.busLabel.text = weekdayInfo[row]["bus"] ?? ""
            cell?.timeLabel.text = "时间: " + weekdayInfo[row]["time"]!
        case 1:
            cell?.placeLabel.text = weekendInfo[row]["place"] ?? ""
            cell?.busLabel.text = weekendInfo[row]["bus"] ?? ""
            cell?.timeLabel.text = "时间: " + weekendInfo[row]["time"]!
        default:break
        }
        
        
        return cell!
    }
}
