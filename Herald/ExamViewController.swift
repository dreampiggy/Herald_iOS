//
//  ExamViewController.swift
//  Herald
//
//  Created by lizhuoli on 15/12/11.
//  Copyright © 2015年 WangShuo. All rights reserved.
//

import UIKit

class ExamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIGetter {

    
    @IBOutlet weak var tableView: UITableView!
    
    var dataList:[NSDictionary] = []
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "考试查询"

        let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("refreshData"))
        self.navigationItem.rightBarButtonItem = refreshButton
        let background = UIColor(red: 180/255, green: 230/255, blue: 230/255, alpha: 1)
        self.view.backgroundColor = background
        self.tableView.backgroundColor = background
        
        let initResult = Tool.initNavigationAPI(self)
        if initResult{
            Tool.showProgressHUD("正在查询考试信息")
            self.API.delegate = self
            API.sendAPI("exam")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getResult(APIName: String, results: JSON) {
        Tool.showSuccessHUD("获取成功")
        self.dataList = results["content"].arrayObject as? [NSDictionary] ?? []
        
        self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
    }
    
    func getError(APIName: String, statusCode: Int) {
        Tool.showErrorHUD("获取失败")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 160
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier:String = "ExamTableViewCell"
        
        let cell:ExamTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? ExamTableViewCell ?? NSBundle.mainBundle().loadNibNamed(cellIdentifier, owner: self, options: nil)[0] as? ExamTableViewCell
        let row = indexPath.row
        cell?.backgroundColor = UIColor(red: 180/255, green: 230/255, blue: 230/255, alpha: 1)
        
        cell?.course.text = self.dataList[row]["course"] as? String ?? ""
        cell?.time.text = self.dataList[row]["time"] as? String ?? ""
        cell?.location.text = self.dataList[row]["location"] as? String ?? ""
        cell?.hour.text = self.dataList[row]["hour"] as? String ?? ""
        cell?.teacher.text = self.dataList[row]["teacher"] as? String ?? ""
        
        return cell!
    }
    
    
    func refreshData()
    {
        Tool.showProgressHUD("正在更新考试信息")
        API.sendAPI("exam")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
