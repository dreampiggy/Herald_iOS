//
//  LectureViewController.swift
//  Herald
//
//  Created by lizhuoli on 15/4/5.
//  Copyright (c) 2015年 WangShuo. All rights reserved.
//

import UIKit

class LectureViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIGetter{
    
    var lectureArray:[NSDictionary]?
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var noLectureLabel: UILabel!
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        var color = UIColor(red: 153/255, green: 204/255, blue: 204/255, alpha: 1)
        var initResult = Tool.initNavigationAPI(self,navBarColor: color)
        if initResult{
            Tool.showProgressHUD("正在查询人文讲座")
            self.API.delegate = self
            API.sendAPI("lecture")
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        Tool.dismissHUD()
        API.cancelAllRequest()
    }
    
    func getResult(APIName: String, results: AnyObject) {
        results as NSDictionary
        Tool.showSuccessHUD("获取数据成功")
        lectureArray = results["detial"] as? [NSDictionary]
        if(lectureArray?.count == 0){
            tableView.hidden = true
            noLectureLabel.hidden = false
        }
        else{
            noLectureLabel.hidden = true
            tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
        }
    }
    
    func getError(APIName: String, statusCode: Int) {
        Tool.showErrorHUD("获取数据失败")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lectureArray?.count ?? 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier:String = "LectureTableViewCell"
        var row = indexPath.row
        
        var cell: LectureTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? LectureTableViewCell
        if cell == nil{
            var nibArray:NSArray = NSBundle.mainBundle().loadNibNamed("LectureTableViewCell", owner: self, options: nil)
            cell = nibArray.objectAtIndex(0) as? LectureTableViewCell
        }
        
        if let lectureInfoArray = lectureArray{
            cell?.lectureDateLabel.text = lectureInfoArray[row].valueForKey("date") as? String ?? ""
            cell?.lecturePlaceLabel.text = lectureInfoArray[row].valueForKey("place") as? String ?? ""
        }
        return cell!
    }
    
    func predictInfo(){
        let LecturePredictTableVC = LecturePredictTableViewController(nibName: "LecturePredictTableViewController", bundle: nil)
        self.navigationController?.pushViewController(LecturePredictTableVC, animated: true)
    }

}
