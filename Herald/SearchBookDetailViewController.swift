//
//  SearchBookDetailViewController.swift
//  先声
//
//  Created by Wangshuo on 14-9-9.
//  Copyright (c) 2014年 WangShuo. All rights reserved.
//

import UIKit

class SearchBookDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,APIGetter {

    
    @IBOutlet var tableView: UITableView!
    
    var searchText:NSString?
    
    var dataList:NSMutableArray = []
    
    var refreshtag:Int = 0
    
    var firstLoad = true
    var initResult = false
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "查询结果"
        
        var color = UIColor(red: 96/255, green: 199/255, blue: 222/255, alpha: 1)
        let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("refreshData"))
        self.navigationItem.rightBarButtonItem = refreshButton
        
        initResult = Tool.initNavigationAPI(self,navBarColor: color)
        if initResult{
            self.API.delegate = self
            API.sendAPI("searchBook",APIParameter: searchText as? String ?? "")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if (initResult && firstLoad){
            firstLoad = false
            Tool.showProgressHUD("正在查询图书信息")
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        Tool.dismissHUD()
        API.cancelAllRequest()
    }
    
    func getResult(APIName: String, results: AnyObject) {
        if let content:NSArray = results as? NSArray{
            Tool.showSuccessHUD("获取数据成功")
            for item in content{
                self.dataList.addObject(item)
            }
            self.tableView.reloadDataAnimateWithWave(WaveAnimation.RightToLeftWaveAnimation)
        }
    }
    
    func getError(APIName: String, statusCode: Int) {
        Tool.showErrorHUD("获取数据失败")
    }
    
    func refreshData()
    {
        Tool.showProgressHUD("正在重新获取")
        API.sendAPI("searchBook",APIParameter: searchText as? String ?? "")
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier:String = "SearchBookDetailTableViewCell"
        
        
        var cell: SearchBookDetailTableViewCell? = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? SearchBookDetailTableViewCell
        
        
        if nil == cell
        {
            var nibArray:NSArray = NSBundle.mainBundle().loadNibNamed("SearchBookDetailTableViewCell", owner: self, options: nil)
            cell = nibArray.objectAtIndex(0) as? SearchBookDetailTableViewCell
        }
        
        var row = indexPath.row

        cell?.bookName.text = self.dataList[row]["name"] as! NSString as String    //书名
        cell?.publisher.text = self.dataList[row]["publish"] as! NSString as String    //发行商
        cell?.author.text = self.dataList[row]["author"] as! NSString as String    //作者
        cell?.docType.text = self.dataList[row]["type"] as! NSString as String     //书籍分类
        cell?.storeNum.text = self.dataList[row]["all"] as! NSString as String   //馆藏书目本数
        cell?.lendableNum.text = self.dataList[row]["left"] as! NSString as String     //可借书目本数

        cell?.bookName.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell?.bookName.numberOfLines = 0
        
        cell?.publisher.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell?.publisher.numberOfLines = 0
        
        cell?.author.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell?.author.numberOfLines = 0
        
        var color = UIColor(red: 96/255, green: 199/255, blue: 222/255, alpha: 0.3)
        cell?.backgroundColor = color
        
        return cell!
    }

}
