//
//  LabViewController.swift
//  Herald
//
//  Created by lizhuoli on 15/4/5.
//  Copyright (c) 2015年 WangShuo. All rights reserved.
//

import UIKit

class LabTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,APIGetter {
    
    
    @IBOutlet weak var tableView: UITableView!
    var sectionArray:NSArray = [AnyObject]()//存放Section，每个序号对应一个Section，代表这个物理实验的名称，比如：基础性实验(下)
    
    var labDictionary:NSDictionary?//存放整个JSON
    
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        let color = UIColor(red: 153/255, green: 204/255, blue: 204/255, alpha: 1)
        let initResult = Tool.initNavigationAPI(self,navBarColor: color)
        if initResult{
            Tool.showProgressHUD("正在查询物理实验信息")
            self.API.delegate = self
            API.sendAPI("phylab")
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        API.cancelAllRequest()
    }
    
    func getResult(APIName: String, results: JSON) {
        Tool.showSuccessHUD("获取数据成功")
        if let contentDictionary:NSDictionary = results["content"].dictionaryObject{
            labDictionary = contentDictionary
            sectionArray = contentDictionary.allKeys as [AnyObject]
        }
        tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
    }
    
    func getError(APIName: String, statusCode: Int) {
        Tool.showErrorHUD("获取数据失败")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section > sectionArray.count{
            return ""
        }
        else{
            let phyTypeName:String = sectionArray[section] as! String
            return phyTypeName
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section > sectionArray.count{
            return 0
        }
        else{
            let phyTypeName:String = sectionArray[section] as! String
            if let phyTypeDic = labDictionary?.valueForKey(phyTypeName) as? NSArray{
                return phyTypeDic.count
            }
            else{
                return 0
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cellIdentifier:String = "LabTableViewCell"
        let row = indexPath.row
        let section = indexPath.section
        
        var cell: LabTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? LabTableViewCell
        if cell == nil{
            let nibArray:NSArray = NSBundle.mainBundle().loadNibNamed("LabTableViewCell", owner: self, options: nil)
            cell = nibArray.objectAtIndex(0) as? LabTableViewCell
        }
        
        let phtTypeName:String = sectionArray[section] as! String
        if let labDetailDic:[NSDictionary] = labDictionary![phtTypeName] as? [NSDictionary]{
            cell?.nameLabel.text = labDetailDic[row]["name"] as? String ?? ""
            cell?.gradeLabel.text = labDetailDic[row]["Grade"] as? String ?? ""
            cell?.dayLabel.text = labDetailDic[row]["Day"] as? String ?? ""
            cell?.addressLabel.text = labDetailDic[row]["Address"] as? String ?? ""
            cell?.dateLabel.text = labDetailDic[row]["Date"] as? String ?? ""
            cell?.teachLabel.text = labDetailDic[row]["Teacher"] as? String ?? ""
        }
        return cell!
    }
    
    func refreshData(){
        API.sendAPI("phylab")
    }
}
