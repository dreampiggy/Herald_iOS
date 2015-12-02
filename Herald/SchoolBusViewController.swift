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
    var weekendInfo:[Dictionary<String,String?>] = []
    var weekdayInfo:[Dictionary<String,String?>] = []
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        let color = UIColor(red: 96/255, green: 199/255, blue: 222/255, alpha: 1)
        let initResult = Tool.initNavigationAPI(self,navBarColor: color)
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
        //这是我暂时想到的相对简单的写法……
        let weekendIn = results["content"]["weekend"]["进九龙湖"].array?.map(){["place":"进九龙湖", "bus":$0["bus"].string,"time":$0["time"].string]} ?? []
        let weekendOut = results["content"]["weekend"]["出九龙湖"].array?.map(){["place":"出九龙湖", "bus":$0["bus"].string,"time":$0["time"].string]} ?? []
        let weekdayIn = results["content"]["weekday"]["进九龙湖"].array?.map(){["place":"进九龙湖", "bus":$0["bus"].string,"time":$0["time"].string]} ?? []
        let weekdayOut = results["content"]["weekday"]["出九龙湖"].array?.map(){["place":"出九龙湖", "bus":$0["bus"].string,"time":$0["time"].string]} ?? []
        
        weekendInfo += weekendIn
        weekendInfo += weekendOut
        weekdayInfo += weekdayIn
        weekdayInfo += weekdayOut
        
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
        let row = indexPath.row
        let section = indexPath.section
        
        var cell: SchoolBusTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? SchoolBusTableViewCell
        if cell == nil{
            let nibArray:NSArray = NSBundle.mainBundle().loadNibNamed("SchoolBusTableViewCell", owner: self, options: nil)
            cell = nibArray.objectAtIndex(0) as? SchoolBusTableViewCell
        }
        if(weekendInfo.count == 0 || weekdayInfo.count == 0){
            return cell!
        }
        
        switch section{
        case 0:
            cell?.placeLabel.text = weekdayInfo[row]["place"] ?? ""
            cell?.busLabel.text = weekdayInfo[row]["bus"] ?? ""
            cell?.timeLabel.text = "时间: " + weekdayInfo[row]["time"]!! ?? ""
        case 1:
            cell?.placeLabel.text = weekendInfo[row]["place"] ?? ""
            cell?.busLabel.text = weekendInfo[row]["bus"] ?? ""
            cell?.timeLabel.text = "时间: " + weekendInfo[row]["time"]!! ?? ""
        default:break
        }
        
        return cell!
    }
}
