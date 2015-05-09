//
//  EmptyRoomViewController.swift
//  先声
//
//  Created by Wangshuo on 14-8-13.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class EmptyRoomViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource,APIGetter {

    @IBOutlet var pickerView: UIPickerView!

   
    @IBOutlet var tableView: UITableView!

    let schools = ["九龙湖","四牌楼","丁家桥"]
    let weeks = ["第一周","第二周","第三周","第四周","第五周","第六周","第七周","第八周","第九周","第十周","第十一周","第十二周","第十三周","第十四周","第十五周","第十六周","第十七周","第十八周","第十九周","第二十周"]
    let days = ["周一","周二","周三","周四","周五","周六","周日"]
    let fromLessons = ["1","2","3","4","5","6","7","8","9","10","11","12","13"]
    let toLessons = ["1","2","3","4","5","6","7","8","9","10","11","12","13"]

    var selectedSchool:String = "jlh"
    var selectedWeek:String = "1"
    var selectedDay:String = "1"
    var selectedFrom:String = "1"
    var selectedTo:String = "1"
    
    
    var emptyRooms : NSArray = []
    
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.API.delegate = self

        // Do any additional setup after loading the view.
        self.navigationItem.title = "空闲教室查询"
        var color = UIColor(red: 153/255, green: 204/255, blue: 204/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = color
       
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: Selector("searchRoom"))
        self.navigationItem.rightBarButtonItem = searchButton
        
        self.view.backgroundColor = UIColor(red: 180/255, green: 230/255, blue: 230/255, alpha: 1)
        
        self.tableView.backgroundColor = UIColor(red: 180/255, green: 230/255, blue: 230/255, alpha: 1)
    }
    
    override func viewWillDisappear(animated: Bool) {
        Tool.dismissHUD()
        API.cancelAllRequest()
    }
    
    func searchRoom()
    {
        
        Config.shareInstance().isNetworkRunning = CheckNetwork.doesExistenceNetwork()
        if !Config.shareInstance().isNetworkRunning
        {
            Tool.showErrorHUD("请检查网络连接")
        }
        else if self.selectedFrom.toInt() >= self.selectedTo.toInt()
        {
            Tool.showErrorHUD("开始节数必须大于结束节数")
        }
        else
        {
            Tool.showProgressHUD("正在获取教室数据")
            API.sendAPI("emptyRoom",APIParameter:self.selectedSchool,self.selectedWeek,self.selectedDay,self.selectedFrom,self.selectedTo)
        }
    }
    
    
    func getResult(APIName: String, results: AnyObject) {
        Tool.showSuccessHUD("获取数据成功")
        self.emptyRooms = results as! NSArray
        self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
    }
    
    func getError(APIName: String, statusCode: Int) {
        Tool.showErrorHUD("获取数据失败")
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component
        {
        case 0:
            return self.schools.count
        case 1:
            return self.weeks.count
        case 2:
            return self.days.count
        case 3:
            return self.fromLessons.count
        case 4:
            return self.toLessons.count
        default:
            return 0
            
        }
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    {
        switch component
        {
        case 0:
            return 80
        case 1:
            return 100
        case 2:
            return 50
        case 3:
            return 35
        case 4:
            return 35
        default:
            return 0
            
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView) -> UIView
    {
        var myView:UILabel?
        switch component
        {
        case 0:
            
            myView = UILabel(frame: CGRectMake(0, 0, 70, 30))
            myView?.textAlignment = NSTextAlignment.Center
            myView?.text = self.schools[row]
            myView?.font = UIFont.systemFontOfSize(20)
            myView?.backgroundColor = UIColor.clearColor()
            return myView!
        case 1:
            myView = UILabel(frame: CGRectMake(0, 0, 90, 30))
            myView?.textAlignment = NSTextAlignment.Center
            myView?.text = self.weeks[row]
            myView?.font = UIFont.systemFontOfSize(20)
            myView?.backgroundColor = UIColor.clearColor()
            return myView!
        case 2:
            myView = UILabel(frame: CGRectMake(0, 0, 80, 30))
            myView?.textAlignment = NSTextAlignment.Center
            myView?.text = self.days[row]
            myView?.font = UIFont.systemFontOfSize(20)
            myView?.backgroundColor = UIColor.clearColor()
            return myView!
        case 3:
            myView = UILabel(frame: CGRectMake(0, 0, 80, 30))
            myView?.textAlignment = NSTextAlignment.Center
            myView?.text = self.fromLessons[row]
            myView?.font = UIFont.systemFontOfSize(20)
            myView?.backgroundColor = UIColor.clearColor()
            return myView!
        case 4:
            
            myView = UILabel(frame: CGRectMake(0, 0, 70, 30))
            myView?.textAlignment = NSTextAlignment.Center
            myView?.text = self.toLessons[row]
            myView?.font = UIFont.systemFontOfSize(20)
            myView?.backgroundColor = UIColor.clearColor()
            return myView!
            
        default:
            return myView!
            
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component
            {
        case 0:
            if 0 == row
            {
                self.selectedSchool = "jlh"
            }
            if 1 == row
            {
                self.selectedSchool = "spl"
            }
            if 2 == row
            {
                self.selectedSchool = "djq"
            }
        case 1:
            return self.selectedWeek = NSString(format: "%ld", row + 1) as String
        case 2:
            return self.selectedDay = NSString(format: "%ld", row + 1) as String
        case 3:
            return self.selectedFrom = NSString(format: "%ld", row + 1) as String
        case 4:
            return self.selectedTo = NSString(format: "%ld", row + 1) as String
            
        default:
            break
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.emptyRooms.count / 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier:String = "EmptyRoomTableViewCell"

        var cell: EmptyRoomTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? EmptyRoomTableViewCell
        
        if nil == cell
        {
            var nibArray:NSArray = NSBundle.mainBundle().loadNibNamed("EmptyRoomTableViewCell", owner: self, options: nil)
            cell = nibArray.objectAtIndex(0) as? EmptyRoomTableViewCell
        }
    
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        cell?.backgroundColor = UIColor(red: 180/255, green: 230/255, blue: 230/255, alpha: 1)
        
        var row = indexPath.row
        if 0 == row
        {
            cell!.leftRoom.text = self.emptyRooms[0] as? String
            cell!.rightRoom.text = self.emptyRooms[1] as? String
        }
        else
        {
            cell!.leftRoom.text = self.emptyRooms[row * 2] as? String
            cell!.rightRoom.text = self.emptyRooms[row * 2 + 1] as? String
        }
        return cell!
    }
    
}
