//
//  SeuCardViewController.swift
//  Herald
//
//  Created by lizhuoli on 15/4/4.
//  Copyright (c) 2015年 WangShuo. All rights reserved.
//

import UIKit

class SeuCardViewController: UIViewController, APIGetter {

    var firstSend = true
    
    var APIResult:NSDictionary?{
        didSet{
            updateUI()
        }
    }
    
    @IBOutlet weak var cardMoney: UILabel!
    @IBOutlet weak var cardState: UILabel!
    
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        let color = UIColor(red: 153/255, green: 204/255, blue: 204/255, alpha: 1)
        let initResult = Tool.initNavigationAPI(self,navBarColor: color)
        if initResult{
            Tool.showProgressHUD("正在查询一卡通信息")
            self.API.delegate = self
            API.sendAPI("card")
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        API.cancelAllRequest()
    }
    
    func getResult(APIName: String, results: JSON) {
        Tool.showSuccessHUD("获取数据成功")
        firstSend = false
        APIResult = results["content"].dictionaryObject
    }
    
    func getError(APIName: String, statusCode: Int) {
        Tool.showErrorHUD("获取数据失败")
    }
    
    
    func updateUI(){
        var cardMoneyText = ""
        if APIResult?.count == 2{
            cardMoneyText = APIResult?.valueForKey("left") as? String ?? "0.00 "
            cardMoney.text = cardMoneyText + " 元"
            cardState.text = APIResult?.valueForKey("state") as? String ?? "未知"
            
        }
    }
    
    func detailInfo(){
        let SeuCardTableVC = SeuCardTableViewController(nibName: "SeuCardTableViewController", bundle: nil)
        self.navigationController?.pushViewController(SeuCardTableVC, animated: true)
    }

}
