//
//  NicViewController.swift
//  Herald
//
//  Created by lizhuoli on 15/4/4.
//  Copyright (c) 2015年 WangShuo. All rights reserved.
//

import UIKit

class NicViewController: UIViewController, APIGetter {

    var firstSend = true
    
    struct networkInfo {
        var state:String?
        var used:String?
    }
    var networkArray = [networkInfo?]()
    
    var leftMoney = "0.00 元"
    
    @IBOutlet weak var nicMoneyLabel: UILabel!
    @IBOutlet weak var networkInfoText: UITextView!
    @IBOutlet weak var networkSegmentedControl: UISegmentedControl!
    
    @IBAction func networkSegmentedSelected(sender: UISegmentedControl) {
        var selectedNetworkType = sender.selectedSegmentIndex
        drawNetworkInfo(selectedNetworkType)
    }
    
    var API = HeraldAPI()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var color = UIColor(red: 153/255, green: 204/255, blue: 204/255, alpha: 1)
        
        var initResult = Tool.initNavigationAPI(self,navBarColor: color)
        if initResult{
            Tool.showProgressHUD("正在查询校园网信息")
            self.API.delegate = self
            API.sendAPI("nic")
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        Tool.dismissHUD()
        API.cancelAllRequest()
    }
    
    func getResult(APIName: String, results: AnyObject) {
        if let content:NSDictionary = results as? NSDictionary{
            firstSend = false
            Tool.showSuccessHUD("获取信息成功")
            leftMoney = content.valueForKey("left") as String
            
            //ugly way to set value....
            var webValue = content.valueForKey("web") as NSDictionary
            var webStruct = networkInfo(state: webValue.valueForKey("state") as? String, used: webValue.valueForKey("used") as? String)
            var brasAValue = content.valueForKey("a") as NSDictionary
            var brasAStruct = networkInfo(state: brasAValue.valueForKey("state") as? String, used: brasAValue.valueForKey("used") as? String)
            var brasBValue = content.valueForKey("b") as NSDictionary
            var brasBStruct = networkInfo(state: brasBValue.valueForKey("state") as? String, used: brasBValue.valueForKey("used") as? String)
            networkArray.append(webStruct)
            networkArray.append(brasAStruct)
            networkArray.append(brasBStruct)
            //
            nicMoneyLabel.text = leftMoney
            drawNetworkInfo(networkSegmentedControl.selectedSegmentIndex)
        }
    }
    
    func getError(APIName: String, statusCode: Int) {
        Tool.showErrorHUD("获取数据失败")
    }
    
    func drawNetworkInfo(networkType:Int){
        if !networkArray.isEmpty{
            var networkInfo = "\n状态：\n" + networkArray[networkType]!.state! + "\n\n已使用：\n" + networkArray[networkType]!.used!
            networkInfoText.text = networkInfo
        }
        else{
            Tool.showErrorHUD("获取数据失败")
        }
    }
    
    func refreshData(){
        Tool.showProgressHUD("正在更新数据")
        networkArray.removeAll(keepCapacity: true)
        API.sendAPI("nic")
    }

}
